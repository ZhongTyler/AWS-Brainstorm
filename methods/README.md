# Brainstorm 方法目录

这里保存一次可调用的认知操作。身份以[catalog.json](catalog.json)为准；按[卡点路由](METHOD_ROUTER.md)，使用时遵循[公共操作约定](OPERATING_GUIDE.md)。当前21个ready、0个placeholder、0个rejected；不固定按阶段跑全部方法。

21份活跃正文均提供独有操作、具体正反例、失效与停止条件、参与边界、来源及效果限制。`ready`为可执行资格，不意味着已证明比直接脑暴有效；公开来源与复用边界见[来源与限制](../docs/research/public-sources.md)。

- 列表：`powershell -NoProfile -ExecutionPolicy Bypass -File scripts/list-methods.ps1`
- 结构验证：`powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-method.ps1`
- 行为合同：`powershell -NoProfile -ExecutionPolicy Bypass -File tests/method-system.contract.ps1`
- 新增骨架：`scripts/new-method.ps1`；仅创建placeholder，资格补齐后按[维护入口](MAINTENANCE.md)审核。
- 具体共创全链见[示例](../examples/co-creation/README.md)。

2026-11-28 按用户决定补齐并采用 crazy-8s、lotus-blossom、mashup、nm-method；记录Method Run和Idea来源不意味着必须向用户展示底层表。

本轮新增[CCST挑战编排](synthesis/ccst-challenge-design.md)与[谜题依赖图](synthesis/puzzle-dependency-graph.md)，游戏视角和复用配方见[Game Concept](../playbooks/game-concept/README.md)。来源及自编边界见[游戏设计来源](../docs/research/game-design-sources.md)。
