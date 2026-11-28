[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$testRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectRoot = [IO.Path]::GetFullPath((Join-Path $testRoot '..'))
$validateMethod = Join-Path $projectRoot 'scripts\validate-method.ps1'
$listMethods = Join-Path $projectRoot 'scripts\list-methods.ps1'
$newMethod = Join-Path $projectRoot 'scripts\new-method.ps1'
$utf8NoBom = New-Object Text.UTF8Encoding($false)

function Stop-Test {
    param([string]$Message)
    throw "Brainstorm method system contract failed: $Message"
}

function Assert-Test {
    param([bool]$Condition, [string]$Message)
    if (-not $Condition) { Stop-Test -Message $Message }
}

function Invoke-SuccessJson {
    param([string]$ScriptPath, [string[]]$Arguments)
    $output = @(& powershell -NoProfile -ExecutionPolicy Bypass -File $ScriptPath @Arguments)
    if ($LASTEXITCODE -ne 0) { Stop-Test -Message "Command failed: $ScriptPath" }
    try {
        return ($output -join "`n") | ConvertFrom-Json
    } catch {
        Stop-Test -Message "Command did not return JSON: $ScriptPath"
    }
}

function Invoke-ExpectedFailure {
    param([string]$ScriptPath, [string[]]$Arguments)
    $previousPreference = $ErrorActionPreference
    $ErrorActionPreference = 'Continue'
    try {
        $output = @(& powershell -NoProfile -ExecutionPolicy Bypass -File $ScriptPath @Arguments 2>&1)
    } finally {
        $ErrorActionPreference = $previousPreference
    }
    Assert-Test -Condition ($LASTEXITCODE -ne 0) -Message "Command should have failed: $ScriptPath"
    Assert-Test -Condition (($output -join "`n").Contains('Brainstorm method contract failed:')) -Message 'Expected failure did not use the method contract prefix.'
}

$validation = Invoke-SuccessJson -ScriptPath $validateMethod -Arguments @()
Assert-Test -Condition ([bool]$validation.structure_passed) -Message 'Method validation did not pass.'
Assert-Test -Condition ([int]$validation.ready_count -eq 19) -Message 'TB-005 must expose exactly nineteen ready methods.'
Assert-Test -Condition ([int]$validation.placeholder_count -eq 0) -Message 'TB-005 must expose exactly zero placeholders.'
Assert-Test -Condition ([int]$validation.source_count -eq 30) -Message 'Current source inventory must contain thirty records; this is not a fresh-read or efficacy count.'
$expectedIds = @('brain-dump', 'how-might-we', 'scamper', 'forced-connections', 'analogy', 'morphological-matrix', 'kj-affinity', 'anchored-decision-matrix', 'assumption-reversal', 'first-principles', 'future-backcasting', 'reverse-brainstorming', 'worst-possible-idea', 'brainwriting-6-3-5', 'disney-strategy', 'crazy-8s', 'lotus-blossom', 'mashup', 'nm-method')
foreach ($methodId in $expectedIds) {
    Assert-Test -Condition (@($validation.method_ids) -ccontains $methodId) -Message "Missing ready method: $methodId"
}

$readyList = Invoke-SuccessJson -ScriptPath $listMethods -Arguments @()
Assert-Test -Condition ([int]$readyList.count -eq 19) -Message 'Default list must return nineteen ready methods.'
Assert-Test -Condition ([string]$readyList.selection_note -like '*semantic*') -Message 'List output must preserve the semantic selection boundary.'
$divergenceList = Invoke-SuccessJson -ScriptPath $listMethods -Arguments @('-Category', 'divergence')
Assert-Test -Condition ([int]$divergenceList.count -eq 11) -Message 'Divergence filter must return the eleven ready divergence methods.'
foreach ($methodId in @('scamper', 'forced-connections', 'analogy', 'morphological-matrix', 'reverse-brainstorming', 'worst-possible-idea', 'brainwriting-6-3-5')) {
    Assert-Test -Condition (@($divergenceList.methods.method_id) -ccontains $methodId) -Message "Divergence filter is missing: $methodId"
}
$placeholderList = Invoke-SuccessJson -ScriptPath $listMethods -Arguments @('-Status', 'placeholder')
Assert-Test -Condition ([int]$placeholderList.count -eq 0) -Message 'Explicit placeholder list must contain zero entries.'
foreach ($placeholder in @($placeholderList.methods)) {
    Assert-Test -Condition ([string]$placeholder.status -ceq 'placeholder') -Message 'Placeholder list leaked a non-placeholder method.'
    Assert-Test -Condition (-not (@($readyList.methods.method_id) -ccontains [string]$placeholder.method_id)) -Message "Placeholder leaked into the default ready list: $($placeholder.method_id)"
}
Invoke-ExpectedFailure -ScriptPath $validateMethod -Arguments @('-MethodId', 'missing-method')

$catalog = [IO.File]::ReadAllText((Join-Path $projectRoot 'methods\catalog.json'), $utf8NoBom) | ConvertFrom-Json
$perspectives = ([IO.File]::ReadAllText((Join-Path $projectRoot 'perspectives/catalog.json'), $utf8NoBom) | ConvertFrom-Json).perspectives
Assert-Test -Condition (@($perspectives).Count -eq 12) -Message 'Adoption must preserve all twelve perspective identities.'
foreach ($perspective in $perspectives) {
    Assert-Test -Condition ([string]$perspective.status -ceq 'ready') -Message "Adopted perspective is not ready: $($perspective.perspective_id)"
    $perspectiveText = [IO.File]::ReadAllText((Join-Path $projectRoot ([string]$perspective.path)), $utf8NoBom)
    Assert-Test -Condition ($perspectiveText.Contains('- Status: `ready`')) -Message "Perspective document status differs: $($perspective.perspective_id)"
}
$router = [IO.File]::ReadAllText((Join-Path $projectRoot 'methods\METHOD_ROUTER.md'), $utf8NoBom)
$readyRouter = $router
foreach ($method in @($catalog.methods)) {
    $methodId = [string]$method.method_id
    $methodPath = Join-Path $projectRoot ([string]$method.path)
    Assert-Test -Condition (Test-Path -LiteralPath $methodPath -PathType Leaf) -Message "Catalog path is missing: $methodId"
    if ([string]$method.status -ceq 'ready') {
        Assert-Test -Condition ($readyRouter.Contains("``$methodId``")) -Message "Ready method is missing from the router: $methodId"
    } elseif ([string]$method.status -ceq 'rejected') {
        Assert-Test -Condition (-not $readyRouter.Contains("``$methodId``")) -Message "Rejected method leaked into the ready router: $methodId"
    } else {
        Assert-Test -Condition (-not $readyRouter.Contains("``$methodId``")) -Message "Placeholder leaked into the ready router: $methodId"
        Assert-Test -Condition (-not [string]::IsNullOrWhiteSpace([string]$method.research_gap)) -Message "Placeholder lacks a research gap: $methodId"
        Assert-Test -Condition (@($method.ready_conditions).Count -ge 3) -Message "Placeholder lacks ready conditions: $methodId"
    }
}


# Content contracts check publication/traceability, not creative efficacy.
foreach ($relativePath in @('methods/OPERATING_GUIDE.md','methods/MAINTENANCE.md','docs/research/public-sources.md','examples/co-creation/README.md','examples/co-creation/game-open.md','examples/co-creation/service-selected.md','examples/co-creation/combination-conflict.md','examples/co-creation/multi-source-gap.md')) {
    Assert-Test -Condition (Test-Path -LiteralPath (Join-Path $projectRoot $relativePath) -PathType Leaf) -Message "Missing professional-content consumer: $relativePath"
}
foreach ($method in @($catalog.methods | Where-Object { [string]$_.status -ceq 'ready' })) {
    $content = [IO.File]::ReadAllText((Join-Path $projectRoot ([string]$method.path)), $utf8NoBom)
    Assert-Test -Condition ([int]$method.version -ge 2) -Message "Ready content not migrated: $($method.method_id)"
    Assert-Test -Condition ($content.Contains('## Evidence boundary')) -Message "Missing efficacy boundary: $($method.method_id)"
    Assert-Test -Condition ($content.Contains('../OPERATING_GUIDE.md')) -Message "Missing common operating consumer: $($method.method_id)"
    Assert-Test -Condition (-not ($method.PSObject.Properties.Name -ccontains 'multi_agent_requirement')) -Message 'Method metadata must not require a participant count or named team.'
}
$rejected = @($catalog.methods | Where-Object { [string]$_.status -ceq 'rejected' })
Assert-Test -Condition ($rejected.Count -eq 0) -Message 'Retired methods must not remain in the live catalog.'
$sourceInventory = [IO.File]::ReadAllText((Join-Path $projectRoot 'docs/research/public-sources.json'), $utf8NoBom) | ConvertFrom-Json
$oldBrainwritingSource = @($sourceInventory.sources | Where-Object { [string]$_.source_id -ceq 'SRC-BW-001' })[0]
Assert-Test -Condition ([string]$oldBrainwritingSource.source_level -ceq 'secondary-practice') -Message 'Wikipedia must not be classified as a primary source.'
$disneySource = @($sourceInventory.sources | Where-Object { [string]$_.source_id -ceq 'SRC-DS-001' })[0]
Assert-Test -Condition ([string]$disneySource.url -ceq 'https://www.nlpu.com/Patterns/pattern7.htm') -Message 'Disney source regressed to an unrelated article.'

$systemTemp = [IO.Path]::GetFullPath([IO.Path]::GetTempPath())
$sandbox = Join-Path $systemTemp ('brainstorm-method-contract-' + [guid]::NewGuid().ToString('N'))
try {
    foreach ($directory in @('methods', 'docs\research', 'schemas')) {
        $target = Join-Path $sandbox $directory
        [void](New-Item -ItemType Directory -Path $target -Force)
        Copy-Item -LiteralPath (Join-Path $projectRoot $directory) -Destination (Split-Path -Parent $target) -Recurse -Force
    }


    # Corrupt a real ready identity in a private copy, assert rejection, then restore.
    $copiedCatalogPath = Join-Path $sandbox 'methods/catalog.json'
    $copiedCatalogText = [IO.File]::ReadAllText($copiedCatalogPath, $utf8NoBom)
    $badCatalog = $copiedCatalogText | ConvertFrom-Json
    $badCatalog.methods[0].source_ids = @('SRC-MISSING-999')
    [IO.File]::WriteAllText($copiedCatalogPath, ($badCatalog | ConvertTo-Json -Depth 16), $utf8NoBom)
    Invoke-ExpectedFailure -ScriptPath $validateMethod -Arguments @('-ProjectRoot', $sandbox)
    [IO.File]::WriteAllText($copiedCatalogPath, $copiedCatalogText, $utf8NoBom)
    $copiedMethodPath = Join-Path $sandbox ([string]$catalog.methods[0].path)
    $copiedMethodText = [IO.File]::ReadAllText($copiedMethodPath, $utf8NoBom)
    [IO.File]::WriteAllText($copiedMethodPath, $copiedMethodText.Replace([string]$catalog.methods[0].positive_case_id, 'REMOVED-CASE'), $utf8NoBom)
    Invoke-ExpectedFailure -ScriptPath $validateMethod -Arguments @('-ProjectRoot', $sandbox)
    [IO.File]::WriteAllText($copiedMethodPath, $copiedMethodText, $utf8NoBom)

    $created = Invoke-SuccessJson -ScriptPath $newMethod -Arguments @(
        '-MethodId', 'example-placeholder',
        '-DisplayName', 'Example Placeholder',
        '-Category', 'divergence',
        '-ProjectRoot', $sandbox
    )
    Assert-Test -Condition ([string]$created.status -ceq 'placeholder') -Message 'new-method must create only a placeholder.'
    $sandboxValidation = Invoke-SuccessJson -ScriptPath $validateMethod -Arguments @('-ProjectRoot', $sandbox, '-MethodId', 'example-placeholder')
    Assert-Test -Condition ([bool]$sandboxValidation.structure_passed) -Message 'Generated placeholder did not pass structural validation.'
    $placeholderList = Invoke-SuccessJson -ScriptPath $listMethods -Arguments @('-ProjectRoot', $sandbox, '-Status', 'placeholder')
    Assert-Test -Condition ([int]$placeholderList.count -eq 1) -Message 'Generated placeholder was not added to the existing placeholder set.'

    $sandboxCatalog = [IO.File]::ReadAllText((Join-Path $sandbox 'methods\catalog.json'), $utf8NoBom) | ConvertFrom-Json
    $generated = @($sandboxCatalog.methods | Where-Object { [string]$_.method_id -ceq 'example-placeholder' })
    Assert-Test -Condition ($generated.Count -eq 1 -and [string]$generated[0].status -ceq 'placeholder') -Message 'Generated catalog entry must remain placeholder.'
    Assert-Test -Condition (@($generated[0].source_ids).Count -eq 0) -Message 'Generated placeholder must not invent sources.'
    Invoke-ExpectedFailure -ScriptPath $newMethod -Arguments @(
        '-MethodId', 'example-placeholder',
        '-DisplayName', 'Duplicate',
        '-Category', 'divergence',
        '-ProjectRoot', $sandbox
    )
} finally {
    if (Test-Path -LiteralPath $sandbox -PathType Container) {
        $cleanupTarget = [IO.Path]::GetFullPath($sandbox)
        Assert-Test -Condition ($cleanupTarget.StartsWith($systemTemp, [StringComparison]::OrdinalIgnoreCase)) -Message "Unsafe cleanup target: $cleanupTarget"
        Remove-Item -LiteralPath $cleanupTarget -Recurse -Force
    }
}

Write-Output 'Brainstorm method system contract: PASS'
