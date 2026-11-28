# Mashup

## Contract

- Method ID: `mashup`
- Category: `divergence`
- Status: `ready`
- Content version: `2`

公共约束见[方法操作约定](../OPERATING_GUIDE.md)。

## Purpose

把目标方案与一个具有所需特质的现实范例叠合，产生新的使用机制。

## Input contract

目标 A、想增加的具体特质、体现该特质的范例 B 及其可核对行为。

## Use when

知道缺少哪种体验或能力，但在本领域想不出实现关系。

## Avoid when

只有两个名词，没有要借的特质；缺的是事实或资源，不是概念关系。

## Procedure

1. 写明 A 欠缺的特质，例如“使用者能看见等待进度”，避免只写“更高级”。
2. 找一个真实范例 B，分清查得的运转方式与当前假设。
3. 提问“如果 A 借用 B 的这项特质，会怎样运转？”分别保留 A、B 和借用点。
4. 将借用落实为触发、动作、反馈与付出，说明需改变哪些约束。
5. 对照不混搭的基线，检查是否真增加了目标特质；冲突就收窄或放弃。

## Output contract

A/B 身份、特质、借用机制、具体片段、冲突与未知。

## Exit conditions

形成足以比较的机制，或只剩换皮和名字相似时停止；不枚举全部品牌配对。

## Single-user + AI adaptation

Agent 可选范例并提出机制，用户评判方向；不模拟设计团队同意，不把熟悉品牌当证据。

## Traceability

Idea 回链 A、B、借用特质及实际来源，范例事实与自编机制分开。

## Sources

- `SRC-MU-001`

见[来源注册表](../../docs/research/public-sources.md)。

## Evidence boundary

IDEO.org 的 Mash-Ups 支持先选特质再叠合现实范例。它与 forced-connections 的区别是有目标特质，而非先引入外部刺激；与 morphological-matrix 的区别是借具体范例，不是组合参数维度。

以下为合成行为案例，分别展示可执行路径与应拒绝的误用。

## Behavior cases

### Positive case

`CASE-MU-P01`：共享工具服务 A 缺“借用去向可见”，范例 B 是图书馆代书板：借出时留下可见占位。适配为柜内借用牌，保留借出者和预计归还时间，另核隐私条件。

### Negative case

`CASE-MU-N01`：“借物平台 + 社交网络”只新增点赞和头像，却没改善借用去向可见。保留为未解决特质的候选，不以两种产品名相加宣告完成。
