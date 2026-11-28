# Lotus Blossom

## Contract

- Method ID: `lotus-blossom`
- Category: `divergence`
- Status: `ready`
- Content version: `2`

公共约束见[方法操作约定](../OPERATING_GUIDE.md)。

## Purpose

从一个中心问题逐层展开相关方向，并让每个分支保留与中心的关系。

## Input contract

一个中心主题、当前缺口和本轮可承受的分支预算。

## Use when

探索面偏窄，需要看清多个方向及其子可能。

## Avoid when

问题尚未有边界，或已经需要比较/实施；不为填格扩大任务。

## Procedure

1. 将中心问题记为 L0；参考实践版的八个周边位置，写第一层相关方向 L1～L8。
2. 去掉同义项并保留理由，检查每个方向如何回答中心问题。
3. 原版把各方向再作为中心向外展开。本仓默认只挑最有用的方向展开第二层，以 L3.1 等记录父子关系。
4. 每个末端写具体行动和结果；本轮最多两层，每层最多八个子项，实际预算可更小。
5. 合并重复但保留来源路径；把有用分支交给比较或片段设计，不继续无限展开。

## Output contract

中心、带父 ID 的分支树、有用的末端片段和未展开方向。

## Exit conditions

达到预先选定预算/两层，或新增项开始同义、偏题、不能改变下一步时停止；空格不要求填满。

## Single-user + AI adaptation

Agent 负责展树和归并，用户回应有用分支。选择展开部分而非全部八乘八是本仓有界适配，不伪装成原版完整执行。

## Traceability

每个 Idea 回链末端和中心；跨枝合并保留多个父引用，历史分支不删除。

## Sources

- `SRC-LB-001`

见[来源注册表](../../docs/research/public-sources.md)。

## Evidence boundary

Digital Society School 发布的实践说明支持中心→八方向→各八子方向。这里采用其展开结构；两层与预算规则为本仓适配，不作历史首创或效果证据。

以下为合成行为案例，分别展示可执行路径与应拒绝的误用。

## Behavior cases

### Positive case

`CASE-LB-P01`：“让小区借物服务继续运转”拆出借出、归还、损坏、闲置等方向。选择归还 L2 展开“近处投递 L2.1”“预约交接 L2.2”，二者都保留与中心的关系；不为凑 64 项增设后台系统。

### Negative case

`CASE-LB-N01`：把中心“减少遗失”扩成“宣传品牌→广告招商→节庆营销”，末端已不能解释如何减少遗失。停止这条分支并保留偏题说明，不把分支数当覆盖质量。
