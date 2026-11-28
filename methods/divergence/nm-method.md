# NM Method

## Contract

- Method ID: `nm-method`
- Category: `divergence`
- Status: `ready`
- Content version: `2`

公共约束见[方法操作约定](../OPERATING_GUIDE.md)。

## Purpose

通过关键词、类似物及其背景原理，把跨域关系转成目标问题的解法。

## Input contract

明确课题、要改变的功能关键词和可以核对的类似物。

## Use when

需要从类似功能的运作原理找到新机制，而非只借外形或题材。

## Avoid when

源域原理未知且不能核查，或目标已有明确实现方案。

## Procedure

1. 确定课题及关键词 KW，优先描述功能或动作。
2. QA：列举具有类似功能的事物，选择一个与课题有可解释关系的对象。
3. QB：追问该对象为什么能这样运转，记录背景、条件与依据；事实不明先标未知或查证。
4. QC：把 QB 的原理与原课题相连，提出目标机制，同时保留不适用之处。
5. 将 QC 整理为一个可理解的解法片段，检查条件、代价及下一必要验证。
6. 仅换名称而没有原理迁移时回到 QB；无合适类比可直接停止。

## Output contract

课题→KW→QA→QB→QC→解法的可追踪链，以及失配和待核事实。

## Exit conditions

原理已转成可比较的解法，或 QB 无依据、与目标条件冲突、继续联想无增量时停止。

## Single-user + AI adaptation

采用創造開発研究所讲解的 KW/QA/QB/QC 实践路线；这是所引 NM／NM-T 背景下的明确操作版本，不宣称覆盖 NM 全部变体。Agent 提案，用户仍拥有采用决定。

## Traceability

KW、类似物来源、QB 事实/假设、QC 与衍生 Idea 分开存引用，不把类比推断写成目标实测。

## Sources

- `SRC-NM-001`

见[来源注册表](../../docs/research/public-sources.md)。

## Evidence boundary

日文实践来源确认 NM 名称与中山正和关系，并给出课题、KW、QA、QB、QC、整理解法六步。本仓未通读创始人原著；只采用该有来源的实践路线。相较 analogy，此处用固定问题链引导背景原理探索。

以下为合成行为案例，分别展示可执行路径与应拒绝的误用。

## Behavior cases

### Positive case

`CASE-NM-P01`：课题“交接遗漏”，KW“接续”，QA 选接力赛交棒；QB 核对交接区与双方动作协调，QC 提出接班方确认收取关键事项后离岗。保留“工作交接不是竞速”的失配，不声称演绎已经证明有效。

### Negative case

`CASE-NM-N01`：KW“传递”联想到蚂蚁，未核其通讯机制就断言“全部员工照做能零遗漏”。QB 缺依据，QC 也没有对应条件；先查原理或换类似物，不能越过 QB。
