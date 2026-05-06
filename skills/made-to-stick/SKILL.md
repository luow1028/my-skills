---
name: made-to-stick
description: "Knowledge from 'Made to Stick' by Chip & Dan Heath. Use for crafting memorable messages, persuasive communication, idea design, storytelling, and overcoming the Curse of Knowledge. Includes AI-TECH v4.0 extension for inference/optimization tech blogs."
when_to_use: "sticky ideas, memorable message, persuasive communication, make ideas stick, SUCCESs framework, curse of knowledge, storytelling, how to communicate effectively, idea design, message clarity, audience engagement, convince people, pitch ideas, presentation skills, tech blog review, inference blog, optimization blog"
---

# Made to Stick: Why Some Ideas Survive and Others Die
**Author**: Chip Heath & Dan Heath | **Year**: 2007 | **Chapters**: 6 + Intro + Epilogue

## How to Use This Skill

- **Without arguments** — loads core frameworks (the SUCCESs checklist)
- **With a topic** — e.g. `/made-to-stick surprise` → finds and explains that concept
- **With chapter** — e.g. `/made-to-stick ch03` → dives into Concreteness
- **For tech blog review** — use the AI-TECH v4.0 extension below

---

## Core Frameworks & Mental Models

### The SUCCESs Framework
Six principles that make ideas sticky:

1. **Simple** — Find the core. Commander's Intent: one crisp statement of the ultimate goal.
2. **Unexpected** — Break "guessing machines." Open knowledge gaps with counterintuitive facts.
3. **Concrete** — Ground abstractions in sensory, human-scale reality.
4. **Credible** — Anti-authorities, testable credentials, vivid details.
5. **Emotional** — Appeal to self-interest, identity, or empathy for individuals (not groups).
6. **Stories** — Challenge Plots, Connection Plots, Creativity Plots.

### The Curse of Knowledge
Once you know something, you can't imagine not knowing it. The SUCCESs framework is the cure.

### Key Decision Rules
- **If** audience is overwhelmed → find the core + Commander's Intent
- **If** message is abstract → use schemas, analogies, concrete details
- **If** nobody cares → use Gap Theory or appeal to identity
- **If** nobody believes → use anti-authorities or testable credentials
- **If** idea isn't remembered → add sensory hooks (Velcro Theory)

---

## AI-TECH v4.0 Extension (Inference/Optimization Blog Review)

For AI inference, quantization, and optimization tech blogs, apply **5-Dimension Consistency Check BEFORE SUCCESs**:

### Pre-SUCCESs: 5 Dimensions of Consistency

1. **Goal vs. Content（指挥官意图）** — 文章是否围绕核心目标？如果目标是"加速推理"，是否跑题到训练？
2. **Speed vs. Accuracy Loop（速度-精度闭环）** ⚠️ CRITICAL — 低精度优化中速度从不免费。声称"INT4 实现 3x 加速"时，是否说明精度影响？**任何隐藏精度代价的性能声明都必须标记。**
3. **Claim vs. Evidence（声明-证据）** — 声称"降低显存"时，是否有前后对比数据？
4. **Narrative Loop（好奇心缺口）** — 开篇制造的悬念，结尾是否解答？
5. **Hardware-Software Loop（软硬件闭环）** — 是否明确指出利用了哪些硬件原语？

### SUCCESs 审查清单（AI 推理定制版）

**S — Simple**
- 受众校准：假设读者懂 LLM，但不假设了解特定量化格式细节
- 强制聚焦**单一最重要结论**：是降低 TTFT？提高 Tokens/sec？还是让大模型跑在单卡上？

**U — Unexpected**
- 突破认知模式：反直觉的发现（如"以为计算是瓶颈，profiling 发现完全受限于显存带宽"）
- 反标题党：意外感直接导向核心优化技术

**C — Concrete**
- 性能翻译（人话）：不说"内存效率提升40%"，而说"70B 模型从需要 4 卡变成 2 卡"
- 感官锚点：火焰图、注意力可视化、实际代码片段

**C — Credible**
- 基准透明度（严格）：模型名及大小、序列长度、batch size、精度格式、硬件型号、软件版本、校准数据集
- 可测试凭证：链接到 HuggingFace、Docker 镜像或 GitHub 脚本

**E — Emotion**
- 开发者身份认同：唤醒"AI Optimizer"身份——"break the memory wall"、"榨干硅片每一分性能"
- 痛点连接：GPU 实例高成本、生产环境 OOM 的挫败感

**S — Stories**
- 排障旅程：团队如何发现问题？为什么选择这个方案？
- Challenge Plot："我们如何克服量化导致的严重精度退化"

### 审查输出格式

1. **AI Consistency Report** — 标记五维一致性断裂（尤其 Speed vs. Accuracy Loop）
2. **SUCCESs Scorecard** — 六原则逐一评分（Pass/Fail/N/A）
3. **Idea Clinic** — Before（抽象算法）→ After（具体部署影响）改写示例
4. **Strategic Directives** — 3 条高度具体的行动建议

## Chapter Index

| # | Title | Key Frameworks |
|---|-------|----------------|
| [ch00](chapters/ch00-introduction.md) | What Sticks? | SUCCESs, Curse of Knowledge |
| [ch01](chapters/ch01-simple.md) | Simple | Commander's Intent, Inverted Pyramid, Schemas |
| [ch02](chapters/ch02-unexpected.md) | Unexpected | Gap Theory, Surprise Brow, Post-dictability |
| [ch03](chapters/ch03-concrete.md) | Concrete | Velcro Theory, Computing in Context |
| [ch04](chapters/ch04-credible.md) | Credible | Anti-authorities, Sinatra Test, Testable Credentials |
| [ch05](chapters/ch05-emotional.md) | Emotional | Mother Teresa Principle, Identity Model, WIIFY |
| [ch06](chapters/ch06-stories.md) | Stories | Challenge/Connection/Creativity Plots, Flight Simulators |
| [ch07](chapters/ch07-epilogue.md) | Epilogue | Sticky Advice, Fight Sticky with Stickier |

## Topic Index

- **Abstraction** → ch01, ch03
- **Analogies** → ch01
- **Anti-authorities** → ch04
- **Attention** → ch02
- **Commander's Intent** → ch01
- **Concrete** → ch03
- **Credibility** → ch04
- **Curiosity** → ch02
- **Curse of Knowledge** → ch00
- **Decision Paralysis** → ch01
- **Emotion** → ch05
- **Identity Model** → ch05
- **Inverted Pyramid** → ch01
- **Memory** → ch03
- **Post-dictability** → ch02
- **Schemas** → ch01
- **Stories** → ch06
- **Surprise** → ch02
- **WIIFY** → ch05

## Supporting Files

- [glossary.md](glossary.md) — all key terms with definitions
- [patterns.md](patterns.md) — techniques and methods
- [cheatsheet.md](cheatsheet.md) — quick reference and decision rules
