# Brainstorm

<!-- release:2.1.0 -->
Legacy redesign starts with the intended experience and concrete evidence from the old version. Clear local changes proceed directly. New contrast examples are synthetic practice material, not adopted product decisions or measured outcomes.
[Release and recovery](docs/releases/2.1.0.md)

[简体中文](README.md)

Explore alternatives and retain proposals, decisions and recovery.

This repository is the independent publication authority for Brainstorm. Start with the [domain guide](README.md) and the [module contract](module.json). Follow the listed runtime prerequisites. User projects, facts, accounts and runtime stay in user-owned locations. AWS and meta are optional collaboration and governance integrations.

```text
python .module/module_manager.py verify
python .module/module_manager.py related
python .module/module_manager.py audit --target <workspace> --modules <related-id>
python .module/module_manager.py fetch --target <workspace> --modules <related-id> --apply
```

Review existing workflows, ownership and interfaces before retrieval. The manager reuses a matching verified module and preserves existing directories and edits. Fetching a peer does not run its services or complete a business integration. See [cooperation](docs/module-cooperation.md) for handoff and recovery.

<!-- module-panorama:start -->
```mermaid
flowchart LR
    brainstorm["Brainstorm"]
    fromdemotospec["FromDemoToSpec"]
    game_analysis_decision["GameAnalysisDecision"]
    knowledge["Knowledge"]
    meta["Meta"]
    skills["Skills"]
    brainstorm -.-> fromdemotospec
    brainstorm -.-> game_analysis_decision
    brainstorm -.-> knowledge
    brainstorm -.-> meta
    brainstorm -.-> skills
```

虚线表示可选协作。具体用途与接口见 module.json 和协作说明。 / Dashed edges indicate optional cooperation. See module.json and the cooperation guide.
<!-- module-panorama:end -->

The [AWS overview](https://github.com/ZhongTyler/AgentWorkSpace) presents the full module network. This module retains original third-party notices and the reviewed 1.30.0 source record. Independent module versioning starts at 2.0.0.
