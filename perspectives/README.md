# 按缺口使用的视角卡

Perspective帮助发现遗漏、构造另一种差异或检查候选假设；Method执行认知变换。视角卡是本仓自编提示，不是专家身份或独立证据。

身份见[catalog.json](catalog.json)：6张core、12张game-design，已按用户 2026-11-28 的决定全部正式采用，状态为 `ready`；按实际缺口使用，后续有反例再调整。历史`no_finding_streak`仅保留旧观测字段，不再作为自动必跑、撤卡或用户审批的计数器；没有finding也可能是已有分析已覆盖。

## 怎么选择

只挑能处理当前缺口的卡；快速/标准/deep都不规定跑多少卡。Agent自主选，不请求用户批准卡名。领域内容适用时可用game-design卡，不依赖先创建playbook，也不因为有领域卡就同时跑对应core卡。

| 可见缺口 | 候选卡 |
|---|---|
| 看不到使用者具体动作与结果 | user-experience |
| 成本/依赖是否改变概念范围未知 | implementation-scope |
| 局部成立但互相作用未知 | system-effects |
| 谁承担持续付出、激励是否错位 | value-sustainability |
| 输入/理解/接入条件排除目标使用者 | accessibility-inclusion |
| 已共识但关键假设缺反例 | counterpoint-failure |
| 首次理解与独立运用尚未区分 | gd-first-run-curve |
| 目标玩家、体验承诺或取舍不清 | gd-player-motivation |
| 成长已获得却没有发挥机会，或资源演化不明 | gd-economy-evolution |
| 强组合是否压平其他判断尚不清楚 | gd-degeneracy |
| 输入、控制空间、判断窗口或归因有断点 | gd-feel-feedback |
| 有限篇幅的完整性与有效变化未确定 | gd-content-throughput |
| 行动很多却没有值得判断或表达的差异 | gd-meaningful-choice |
| 新旧机制割裂或频繁要求重新学习 | gd-mechanic-coherence |
| 玩家只能猜答案，尝试不能增进认识 | gd-information-discovery |
| 地图变化没有改变路线、能力或遭遇关系 | gd-space-encounter |
| 强度单一或失败只带来重复劳动 | gd-rhythm-recovery |
| 主题、角色、玩家行动和表达脱节 | gd-theme-expression |

任何时点有真实新缺口都可使用，包括已收敛后的新证据；已锁定决定不能因扫描自动重开。发散中仅针对影响方向的限制，不提前全盘打分。

## 怎么用、何时停

将问题落到一个候选的具体片段，指出“哪项原假设→什么风险/新可能→如何改变下一步”。有实质finding可写既有ART/perspective-review或当前比较说明，复用引用，不强制另写一份报告。无增量可直接继续，不补全覆盖表。

卡中问题是可选提示，不要求逐题回答。没有事实时标推断/unknown，不假装进行了测试；多张卡引用同材料仍是一条证据链。用户决定重要方向，Agent可提出修改而不擅自接受/淘汰。

新证据和反例按[方法维护](../methods/MAINTENANCE.md)限定调整；采用状态记录可用资格，效果依据单独保留。卡片不能授权spawn、专家接管、remember或新增定时任务。
