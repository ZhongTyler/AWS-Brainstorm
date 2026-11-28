# 谜题依赖图

## Contract

- Method ID: `puzzle-dependency-graph`
- Category: `synthesis`
- Status: `ready`
- Content version: `2`

公共约束见[方法操作约定](../OPERATING_GUIDE.md)。

## Purpose

从目标倒推必要条件，发现并行题目、瓶颈、替代路径与知识缺口。

## Input contract

一个需要达成的目标、已有对象与动作、世界规则和当前可获得的知识。

## Use when

谜题、调查或非线性任务的先后依赖不清，玩家容易形成无解或单点卡关。

## Avoid when

只有一个确定动作且依赖已清楚；不要求所有任务都有多条路线。

## Procedure

1. 从当前目标或一条谜题链的终点倒推，写出必须先成立的条件；不从尚无用途的钥匙或道具堆起。
2. 将解决动作与前置条件连接，区分同时满足、任一满足和可独立并行，标出真正的汇合瓶颈。
3. 另列玩家获得线索、理解规则和验证假设的机会；动作依赖与知识依赖不能互相假定已满足。
4. 推演可能先到达、遗漏或跳过的路径，检查永久失去必要物、信息提前泄漏与提示后仍无法继续的情况。
5. 保留有价值的选择与复杂度，必要时调整提示、返回或替代条件；图达到足够可制作的关系后移交下游验证。

## Output contract

目标/条件依赖图，AND/OR关系，并行与瓶颈，知识到达及异常路径说明。

## Exit conditions

主要依赖和恢复边界足以继续，或进一步展开已是接受方向内的细节时停止。

## Single-user + AI adaptation

Ron Gilbert 的依赖图不是唯一游玩顺序图。本仓增加玩家知识与异常路径检查，图可用文本或现有Mermaid，不要求新装工具。

## Traceability

保留实际输入、父项、变化及决定的引用；图和片段是候选，不自动扩大采用范围。

## Sources

- `SRC-PDC-001`

公开出处与适配见[游戏设计来源](../../docs/research/game-design-sources.md)。

## Evidence boundary

来源支持方法的操作身份，不证明普遍收益。本文例子为合成教学例；图、结构检查与真实Play分别报告。

## Behavior cases

### Positive case

`CASE-PDC-P01`：进入阁楼需打开锁和移开堵门木架；钥匙和搬运工具可先后任意取得，两条链在开门处汇合。另核玩家怎样知道木架可移动。

### Negative case

`CASE-PDC-N01`：图上强制先取钥匙再找工具，实际二者无依赖；或允许销毁唯一钥匙却不提供替代、回退或明确不可逆后果。
