# VULGUS Launch-Readiness Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking. **Before writing any code, resolve the three Open Decisions below with the user — they gate Track A and Track B.**

**Goal:** Get VULGUS to a state where it can be launched into a chosen seed audience and ride a working share-loop. Three parallel tracks: (A) public web launch surface, (B) Bauhaus polish + closeness feedback, (C) dictionary content engine for 90 days of daily puzzles.

**Source material (read first):**
- `docs/COMPETITOR_ANALYSIS.md` — competitor analysis on Connections-style word games, including marketing/feature breakdown and concrete recommendations. The plan below operationalises that analysis.
- `README.md` — project overview, palette, design pillars.
- `docs/VULGUS_GDD_v0.1.docx` — full GDD (sections 5 = content/filtering pipeline; section on monetisation).
- `prototype/index.html` — playable single-file reference for the game mechanic.
- `flutter_app/` — production Flutter app (web target already configured at `flutter_app/web/`).

**Background context from prior session (claude.ai/code, branch `claude/competitor-analysis-word-games-BR5Tj`):**
The competitor analysis concluded that for VULGUS the path that works is:
1. Web-first launch (lowest-friction conversion surface for the share loop).
2. A visually-distinct, spoiler-safe share artifact (Bauhaus shape grid — already implemented).
3. Editorial cadence as the moat (puzzle quality + named editor voice).
4. Recruit one or two seed communities deliberately rather than launching at "the world."
5. Free daily, paywall the archive/extras. No interstitial ads in v1.

The web-launch logic in plain terms: web doesn't *acquire* users — it *converts* them. Friends/family group-chat shares are the dominant viral channel, and a one-tap URL beats an app-store install (5+ steps, ~95% drop-off). The seed audience still has to be picked deliberately.

---

## Open Decisions (resolve before coding)

These three answers determine concrete tasks in Tracks A and B. The agent picking up this plan **must surface them to the user before starting**.

1. **Closeness feedback variant.** NYT Connections only shows "one away" (3/4 correct). What does VULGUS show on a wrong guess?
   - **(a)** NYT-equivalent — only "one away". Hardest. Best for purists.
   - **(b)** Hits counter — "2 right" / "3 right (one away)". Easier. Better new-player retention.
   - **(c)** Hybrid — default is "one away" only; an opt-in "Assist" toggle in Settings shows hits.
   - *Recommendation in prior conversation: **(c)** — keeps brand voice but lets new players opt in.*

2. **Web deploy target.**
   - Firebase Hosting (already configured in `firebase.json` — fastest path).
   - Custom domain (vulgus.app or similar) — needs DNS + cert work first.
   - *Recommendation: Firebase Hosting on a `vulgus.web.app` URL for staging, custom domain at launch.*

3. **Dictionary expansion ownership.**
   - Editorial-only track (user-led; agent does not author words).
   - Agent-assisted with user review (agent proposes words via `scripts/suggest_groups.py`, user approves before merge).
   - *Recommendation: agent-assisted with user as second reviewer per the GDD's two-reviewer rule.*

---

## Out of Scope (separate plans)

- Backend puzzle delivery / Firestore puzzle storage (post-launch).
- Full leaderboards / friend groups (Puzzmo-style — post-launch).
- Mild mode / filthy mode toggle (in GDD; not needed for launch).
- iOS / Android app store submissions (web-first; ports are channel #2).
- Paid acquisition / TikTok ads (organic seed launch first).
- Localisation.

---

## Track A — Public web launch surface

**Goal:** A public URL where today's puzzle plays in <3s, with a one-tap share that pastes a recognisable VULGUS grid into iMessage / WhatsApp / Twitter.

### A1. Deploy plumbing
- [ ] Confirm Track A deploy target with user (Open Decision #2).
- [ ] Verify `flutter build web --release` produces a working build.
- [ ] Wire Firebase Hosting (or chosen target) to `flutter_app/build/web/`.
- [ ] Add a CI workflow that deploys to staging on push to a `staging` branch and to production on push to `main`.
- [ ] Test the deployed URL on real iOS Safari + Android Chrome.

### A2. Share loop (the highest-leverage piece)
- [ ] Audit existing `lib/game/share_text.dart` — confirm shape grid renders correctly across guess/wrong/right rows.
- [ ] Wire share button to `navigator.share()` (Web Share API) on supported browsers.
- [ ] Fallback: clipboard copy + toast ("Copied — paste anywhere") on browsers without Web Share API (desktop Chrome, Firefox).
- [ ] Make sure share text includes the public URL so the loop closes.
- [ ] End-to-end manual test: solve on phone → tap share → paste in WhatsApp → click link in second device → playing in <3s.

### A3. Landing surface polish
- [ ] Set page title: `Today's VULGUS — sort the sweary, skip the slurs`.
- [ ] Open Graph image (1200×630) using Bauhaus shapes; will appear when URL is pasted in iMessage/Slack/Twitter.
- [ ] Twitter card meta tags.
- [ ] Favicon audit (already exists at `flutter_app/web/favicon.png` — verify quality).
- [ ] Add a minimal "About VULGUS" route that loads when a stranger lands without context.

### A4. New-user short-circuit
- [ ] Audit the 11+ onboarding screens in `lib/onboarding/screens/` — most are not appropriate for a public-URL first-time visitor.
- [ ] Add a path: "deep-link from share → straight into today's puzzle" (skip onboarding entirely; offer it after the first solve).
- [ ] Decide: do we require account/email at all on web v1? Recommendation: no — anonymous play, optional account for streak persistence later.

---

## Track B — Bauhaus polish + closeness feedback

**Goal:** The game is unmistakably VULGUS at thumbnail size, and new players don't bounce after their second wrong guess.

### B1. Closeness feedback (resolve Open Decision #1 first)
- [ ] Variant chosen: ___
- [ ] Update `lib/game/game_state.dart` and `lib/game/game_controller.dart` to compute hit-count per guess.
- [ ] If variant (b) or (c): add UI for hit-count display (toast or under-grid indicator). Match Bauhaus visual language — no rounded badges.
- [ ] If variant (c): add Settings toggle "Assist mode" with off-by-default. Persist via existing `SharedPreferences` plumbing.
- [ ] Update the share grid logic if hit-count affects what's shown post-game (it shouldn't — share grid stays spoiler-safe).

### B2. Bauhaus polish pass
- [ ] Tile typography review against `staatliche_form/DESIGN.md` style authority referenced in the game-port plan.
- [ ] Solved-banner motion — confirm it's confident and snappy (not bouncy).
- [ ] Share grid kerning + line-height — must be readable at 200px-wide thumbnail in a Twitter/iMessage feed.
- [ ] Colour token audit: every UI surface should map to one of the five tokens in the README palette.
- [ ] Dark-mode pass (or explicit decision: light-mode-only at launch).

### B3. Recognisability test
- [ ] Screenshot the share grid at 200px width. Show to 3 people who haven't seen VULGUS. Can they tell it's not Connections at a glance? If no, iterate.
- [ ] Open Graph preview test: paste the public URL in iMessage, WhatsApp, Slack, Twitter — does the preview look distinctly VULGUS?

---

## Track C — Dictionary content engine

**Goal:** Ship a daily puzzle every day for 90 days post-launch without scrambling. This is editorial work, not code, but it gates launch absolutely. Going dark on day 11 is worse than not launching.

### C1. Dictionary expansion
- [ ] Resolve Open Decision #3 — agent-assisted or editorial-only.
- [ ] Audit current state of `dictionary/VULGUS_Dictionary_v0.1.xlsx` (147 words / 25 categories per README).
- [ ] Use `scripts/suggest_groups.py` and `scripts/expand_lexicon.py` to propose expansion candidates.
- [ ] Fill thin categories called out in README: Shakespearean, Australian.
- [ ] Target: 400 words / 40+ categories.
- [ ] Run `scripts/lint_lexicon.py` after each batch.

### C2. Puzzle authoring
- [ ] Author 90 launch puzzles (use Puzzle Builder sheet in the dictionary workbook).
- [ ] Each puzzle through the GDD-mandated two-reviewer pass before merge.
- [ ] Use `scripts/generate_puzzles.py` / `scripts/generate_puzzles_051_100.py` as scaffolding; do not let the script ship puzzles without editorial review.
- [ ] Migrate puzzles to the runtime format via `scripts/migrate_to_json.py` if/when that's the delivery path.

### C3. Editorial voice
- [ ] Establish a named (real or persona) "VULGUS editor" — one-line voice guideline doc.
- [ ] Each puzzle ships with a one-line editor's note in the etymology strip footer (already wired in prototype). Voice: dry, knowing, never punching down.

---

## Suggested order of operations

1. Resolve all three Open Decisions with the user. ~10 minutes of conversation.
2. Track A in full to a working staging URL. **Do not start B or C until the share loop is proven end-to-end on a real phone.** This is the riskiest piece — if the loop is broken, polish on the rest is wasted.
3. Tracks B and C in parallel until launch-ready.
4. **Pre-launch only:** plan the seed-community recruitment (per `docs/COMPETITOR_ANALYSIS.md` §5 — pick 1-2 niche communities, e.g. British comedy podcast Twitter or etymology nerd circles around Mark Forsyth / John McWhorter readers). Do this *before* the URL goes public; you only get one launch shot per community.

---

## What this plan does *not* attempt to decide

- Brand/launch fandom — needs user input and is upstream of paid effort.
- Whether to ship ads ever — recommendation in competitor analysis is no, but a real call.
- Pricing for the eventual paid tier — set when there's an archive worth paying for.
- App store submissions — out of scope for v1 launch.

---

## Branch / commit conventions

This plan was authored on `claude/competitor-analysis-word-games-BR5Tj` (the branch the competitor analysis was committed to). Local sessions picking up this work should either:
- Continue on that branch, or
- Branch off `main` after the competitor-analysis branch merges.

The competitor analysis at `docs/COMPETITOR_ANALYSIS.md` is the source of truth for the "why" behind this plan — read it before reinterpreting any of the recommendations above.
