# VULGUS Launch Readiness Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

## Context

VULGUS is at `v0.1.0+1` — a Bauhaus-styled daily word game (Connections-style: 16 tiles → 4 categories of 4, 4 lives, etymology reveal, share grid). The codebase has shipped: a fresh Flutter scaffold, an 11-screen onboarding flow, the full game port (50 puzzles, 302-word lexicon, share-grid generation), Firebase auth + Firestore wiring, a settings screen with notifications, and a signed Android release APK that Rob can sideload.

Two distinct drivers force a launch-readiness pass right now:

1. **Toolchain & dependency staleness.** A `flutter pub outdated` check on 2026-04-26 surfaced 11 direct dependencies with major-version upgrades waiting (firebase_core 3→4, firebase_auth 5→6, cloud_firestore 5→6, go_router 14→17, flutter_local_notifications 18→21, google_sign_in 6→7, google_fonts 6→8, flutter_riverpod 2→3, permission_handler 11→12, timezone 0.10→0.11, flutter_lints 4→6) plus a Flutter SDK update. Riverpod 3 is a breaking migration; google_sign_in 7 rewrites the API around Credential Manager. Shipping a public launch on a stale toolchain locks in technical debt that compounds with every subsequent feature.

2. **Launch-readiness gaps surfaced by the competitor analysis** (`docs/COMPETITOR_ANALYSIS.md` on `claude/competitor-analysis-word-games-BR5Tj`): the share artifact is the marketing, web-first launch is the playbook for daily word games (Wordle, Connections, Heardle, Contexto, Spotle all launched as a free browser page first), and editorial cadence must be decoupled from app-store review windows. Operational gaps complete the picture — no Crashlytics yet, no analytics events instrumented, no App Check, no Firestore rules verified by tests, no privacy policy, no Play data-safety form.

The goal of this plan is a clean, public-facing **v1**: a playable web URL at `vulgus.app`, a signed Play Store `.aab` ready for submission, a TestFlight-ready iOS build deferred to a later plan (needs Mac + Apple Developer account), with the editorial pipeline able to publish tomorrow's puzzle without an app release.

## Decisions resolved (by user, before coding)

These six decisions were resolved before this plan was written. The first three shape the phase boundaries below; the fourth shapes the lexicon roadmap on the in-flight dictionary expansion branch; the fifth introduces Phase 7 (vulgar switch); the sixth is folded into Phase 5 (closeness feedback).

1. **Defer Riverpod 2 → 3 migration.** Stay on `flutter_riverpod ^2.6.1`. Riverpod 3 deprecates `StateNotifier` in favour of code-gen `Notifier`/`AsyncNotifier`, which would touch `GameController` and every provider — too much scope churn for a launch pass. Riverpod 2 is still maintained. The migration becomes its own follow-up plan.
2. **Add Flutter Web build target this pass.** Ship a Flutter Web build hosted on Firebase Hosting. The competitor analysis is unambiguous: web-first is the only realistic path to the share-link → click → play viral loop in this category. Mobile apps remain channel #2. Default to the free Firebase `*.web.app` URL until a custom domain is registered (`vulgus.app` is **not yet registered** — flagged below).
3. **Daily puzzles delivered as static JSON on Firebase Hosting.** Editorial publishes by dropping `puzzles/<YYYY-MM-DD>.json` and running `firebase deploy --only hosting`. CDN-cached, zero per-read cost, identical contract on web and mobile, decoupled from app releases.
4. **App #2 format = etymology quiz / word-origin daily** (separate app, not a tab). Strongest USP fit — the format the NYT structurally cannot ship. Lexicon schema must support First Attested year, Region, Source, and distractor relationships as first-class fields (already in the schema being designed on `claude/expand-puzzle-dictionary-tI41m`). **Implication:** that branch currently targets Wordle as the second-game stress-test; it needs revising to target etymology quiz before merge. Does not change anything about this launch-readiness plan — VULGUS-Connections still ships as app #1.
5. **Vulgar switch ships as v1 architecture.** Binary toggle (Tame / Filthy), default tame, per-account synced via Firestore, applies to both VULGUS apps via the shared severity-filter on the lexicon. Resolves the brand/audience tension: tame default protects app-store rating + recruit funnel; filthy opt-in carries the differentiator that the original VULGUS positioning was built on. Phase 7 ships the infrastructure even if the filthy puzzle library starts empty — editorial fills it post-launch. Paywall on filthy unlock is a v1.1 monetisation lever, not v1.
6. **Closeness feedback for wrong guesses = hits counter** ("2 right" / "3 right (one away)"). Easier than NYT's "one away"-only — chosen for new-player retention. The hybrid pattern (default "one away" only, opt-in "Assist mode" toggle in Settings) is parked as a v1.1 candidate to revisit once retention data exists. Share grid stays spoiler-safe regardless — closeness feedback only affects the in-game wrong-guess UX, not the share artifact.

## Out of scope (deferred to other plans)

- **Riverpod 2 → 3 migration** — own plan, post-launch.
- **App #2 (etymology-quiz daily) build** — own plan, post-launch. The dictionary expansion plan on `claude/expand-puzzle-dictionary-tI41m` is the schema-and-lexicon precursor; it needs revising from its current Wordle-target to an etymology-quiz target before merge. Lexicon work feeds it; this plan only ships VULGUS-Connections as app #1.
- **Real Kat-designed launcher icon** — placeholder Bauhaus V is good enough for v1; swap and rerun `flutter_launcher_icons` later.
- **iOS release build** — needs Mac + Apple Developer account; separate plan.
- **Monetisation (paid archive, themed packs, ad-free unlock)** — competitor analysis is explicit: no ads at launch. Free daily forever as the v1 stance. Paid archive deferred to v1.1.
- **Backend puzzle-authoring tooling** — manual JSON drop is sufficient for solo editorial pace at v1 scale.
- **CI release pipeline** — manual `flutter build` + `firebase deploy` for v1.
- **Marketing comms / launch fandom selection** — operational, not a code change. Tracked in the project memory but not built here.
- **Hybrid "Assist mode" closeness feedback (option c)** — v1.1 review item once retention data exists. v1 ships hits-counter (option b) for everyone; if data shows the hits counter is too easy for purists, add an Assist-mode toggle in Settings that flips closeness feedback back to NYT-style "one away"-only.

## Phase 1 — Toolchain & dependency upgrade pass

**Goal:** Get on the latest stable Flutter SDK and bump every direct dep to its latest version, except Riverpod (deferred). Each major bump gets its own commit so a regression bisects cleanly.

**Sequencing rule:** do the low-risk minors first (no migration cost — confidence builders), then the medium-risk majors with stable APIs, then the heavy migrations last.

- [ ] **Step 1: Snapshot the test baseline**
  - Run `flutter test` and confirm all current tests pass before touching anything. Capture pass count.
  - Run `flutter analyze` and capture any pre-existing warnings.

- [ ] **Step 2: Flutter SDK upgrade**
  - `flutter upgrade` to the latest stable.
  - Re-run `flutter test` and `flutter analyze`. Fix any new lints from the SDK bump only.
  - Commit: `chore(flutter): upgrade Flutter SDK`.

- [ ] **Step 3: Low-risk minor bumps (single commit)**
  - `timezone: ^0.10.0` → `^0.11.0`
  - `google_fonts: ^6.2.1` → `^8.0.2`
  - `flutter_lints: ^4.0.0` → `^6.0.0` (expect new lints to surface — fix them in this commit too, don't disable rules)
  - `permission_handler: ^11.3.1` → `^12.0.1`
  - `flutter pub upgrade --major-versions` for these only (or pubspec edit + `pub get`).
  - Re-run `flutter test`, `flutter analyze`, smoke-test on device.
  - Commit: `chore(deps): bump low-risk minor dependencies`.

- [ ] **Step 4: Firebase suite bump (single commit)**
  - `firebase_core: ^3.6.0` → `^4.7.0`
  - `firebase_auth: ^5.3.1` → `^6.4.0`
  - `cloud_firestore: ^5.5.0` → `^6.3.0`
  - Read each package's CHANGELOG for breaking changes.
  - Re-run any existing Firebase init code in `main.dart`.
  - Verify Firestore rules tests still pass; verify auth flow still signs in.
  - Commit: `chore(firebase): bump firebase_core, firebase_auth, cloud_firestore to v4/v6/v6`.

- [ ] **Step 5: go_router 14 → 17**
  - Three breaking-change boundaries (15, 16, 17). Walk the migration guide.
  - Likely changes: `redirect` signature, `GoRoute.builder` typing, `ShellRoute` API.
  - Update `flutter_app/lib/core/router.dart`.
  - Re-run `flutter_app/test/core/router_test.dart`.
  - Commit: `chore(router): migrate go_router 14 → 17`.

- [ ] **Step 6: flutter_local_notifications 18 → 21**
  - Three breaking-change boundaries (19, 20, 21). Timezone init API changed; iOS notification settings changed.
  - Update `flutter_app/lib/notifications/notification_service.dart`.
  - Verify scheduling on Android device with timezone `Europe/London`.
  - Commit: `chore(notifications): migrate flutter_local_notifications 18 → 21`.

- [ ] **Step 7: google_sign_in 6 → 7 (highest-risk single bump)**
  - Major API rewrite — Android moves to Credential Manager, iOS to ASAuthorization. Old `signIn()` patterns are gone.
  - Update `flutter_app/lib/auth/auth_service.dart`.
  - Verify the sign-in flow on Android device + Web (Phase 3 will hit the web path).
  - Commit: `chore(auth): migrate google_sign_in 6 → 7 (Credential Manager)`.

- [ ] **Step 8: Verification gate**
  - Full test suite green.
  - Manual smoke on Android: launch → onboarding → game → solve → share → settings → sign in → sign out.
  - `flutter analyze` reports zero new warnings.
  - Stop and review before moving to Phase 2.

## Phase 2 — Daily-puzzle delivery (decision 3)

**Goal:** Replace the bundled puzzle data files with a remote-fetched static JSON model so editorial cadence is independent of app releases.

- [ ] **Step 1: Define the JSON schema**
  - Create `dictionary/puzzle.schema.json` (JSON Schema draft 7).
  - Fields mirror the existing `Puzzle` Dart model: `id`, `date` (YYYY-MM-DD), `categories[4]` each with `name`, `difficulty` (easy/medium/hard/trickiest), `tiles[4]`, optional `etymology` per tile.
  - Add a `schemaVersion: 1` discriminator for forward compatibility.

- [ ] **Step 2: Migrate existing 50 puzzles to JSON**
  - One-shot script `scripts/dart_puzzles_to_json.py` reads `flutter_app/lib/game/data/vulgus_*.dart`, emits one JSON file per puzzle to `puzzles/2026-MM-DD.json`.
  - Date assignment: today + N days for puzzle 050+ (TBD with Rob — flag).
  - Validate every output against the schema.
  - Commit: `feat(puzzles): export 50 bundled puzzles to JSON corpus`.

- [ ] **Step 3: PuzzleRepository abstraction in Flutter**
  - New: `flutter_app/lib/game/data/puzzle_repository.dart` — `abstract class PuzzleRepository { Future<Puzzle> forDate(DateTime); }`
  - New: `RemotePuzzleSource` — HTTPS GET `https://vulgus.app/puzzles/<date>.json`, JSON-parse into `Puzzle`.
  - New: `BundledPuzzleSource` — keeps the existing dart-data path for offline / dev / first-launch fallback.
  - New: `CachingPuzzleRepository` — wraps both; tries network with a 2s timeout, falls back to cache then to bundled.
  - Cache layer: `shared_preferences` keyed `puzzle.<date>` storing the raw JSON + `etag` + `lastFetched`.

- [ ] **Step 4: Wire the repository into GameController**
  - Replace direct imports of `vulgus_*.dart` files with `puzzleRepositoryProvider.forDate(today)`.
  - Loading state: brief "preparing today's puzzle" while the network call resolves; falls back to cached/bundled silently if offline.

- [ ] **Step 5: Firebase Hosting setup**
  - `firebase init hosting` in `flutter_app/`.
  - `firebase.json` rewrite: serve `/puzzles/**` from `dictionary/puzzles/` with 1-hour cache header (`Cache-Control: public, max-age=3600`).
  - Set up `vulgus.app` custom domain on Firebase Hosting console (manual; flag for Rob).
  - Deploy: `firebase deploy --only hosting`.
  - Smoke-test: `curl https://vulgus.app/puzzles/2026-04-27.json` returns the expected JSON.

- [ ] **Step 6: Editorial workflow doc**
  - New: `dictionary/PUBLISHING.md` — how to author and publish tomorrow's puzzle. Three-step recipe: edit JSON → validate against schema → `firebase deploy --only hosting`.

- [ ] **Step 7: Verification**
  - Today's puzzle renders identically to before, byte-for-byte (same lexicon, same categories).
  - Airplane-mode test: app falls back to bundled data without crashing.
  - Manual override: editing JSON locally and re-deploying changes tomorrow's puzzle without rebuilding the app.

## Phase 3 — Flutter Web target (decision 2)

**Goal:** Ship `vulgus.app` as the playable web surface, sharing the same codebase as mobile.

- [ ] **Step 1: Enable web platform**
  - `flutter create --platforms web .` from `flutter_app/`.
  - Verify `web/index.html`, `web/manifest.json`, `web/icons/` are generated.

- [ ] **Step 2: Plugin compatibility audit**
  - flutter_riverpod, go_router, shared_preferences, google_fonts, firebase_core, firebase_auth, cloud_firestore — web-supported.
  - permission_handler — partial web support; gate calls behind `kIsWeb` checks, no-op on web.
  - flutter_local_notifications — no web support; gate scheduling behind `kIsWeb`, never schedule on web v1.
  - google_sign_in 7 web — uses Sign in with Google web SDK; verify after Phase 1 step 7.
  - Crashlytics (Phase 4) — uses `firebase_crashlytics` which has limited web support; may need a JS-fallback.

- [ ] **Step 3: Platform-aware shims**
  - New: `flutter_app/lib/core/platform.dart` — `isWeb`, `supportsNotifications`, `supportsHaptics` flags.
  - Audit `notification_service.dart`, `share_text.dart`, etc. for code that needs gating.

- [ ] **Step 4: Firebase Web config**
  - Add web app to Firebase project console.
  - Generate `firebase_options.dart` with `flutterfire configure` to include the web entry.
  - Update `web/index.html` with the Firebase web SDK script tags only if needed (FlutterFire mostly handles this).

- [ ] **Step 5: Font loading on web**
  - Verify Space Grotesk + Manrope load via `google_fonts` on web — they may need preloading via `<link>` tags in `web/index.html` to avoid FOUT on first render.

- [ ] **Step 6: Web build + deploy**
  - `flutter build web --release` (default HTML renderer; CanvasKit is heavier and worse for SEO).
  - `firebase deploy --only hosting` deploys the build output to `vulgus.app`.
  - The `/puzzles/**` rewrite from Phase 2 still serves correctly.

- [ ] **Step 7: Web-specific UX adjustments**
  - "Install the app" CTA on web (links to Play Store + future App Store) instead of "enable notifications".
  - Web share: `navigator.clipboard.writeText` for the share grid (replaces native iOS/Android share sheet).
  - Detect mobile-web vs desktop-web for layout breakpoints — desktop should max-width the game board.

- [ ] **Step 8: Verification**
  - Open `https://vulgus.app` in Chrome desktop, Safari iOS, Chrome Android.
  - Full onboarding → game → share → sign-in → settings cycle on each.
  - Lighthouse score ≥ 80 for performance and ≥ 90 for accessibility.
  - Share grid copies to clipboard; pasted preview is recognisable at 200px.

## Phase 4 — Operational launch readiness

**Goal:** Crash visibility, analytics, abuse protection, and security rule guarantees.

- [ ] **Step 1: Firebase Crashlytics**
  - Add `firebase_crashlytics` dep.
  - Wire `FlutterError.onError` and `PlatformDispatcher.instance.onError` in `main.dart`.
  - Run-once smoke: throw an uncaught exception behind a debug-only button; confirm Crashlytics dashboard shows the crash within 5 minutes.

- [ ] **Step 2: Firebase Analytics**
  - Add `firebase_analytics` dep.
  - Instrument these events (no PII):
    - `puzzle_loaded` (props: date, source=remote/cached/bundled)
    - `puzzle_solve` (props: date, lives_remaining, time_to_solve_s)
    - `puzzle_fail` (props: date, lives_used)
    - `share_tap` (props: surface=end_modal/web)
    - `onboarding_step_complete` (props: step_index)
    - `onboarding_complete`
    - `account_created` (props: provider=email/google)
    - `notification_permission_decision` (props: granted/denied)
  - Verify in DebugView during a real device session.

- [ ] **Step 3: Firebase App Check**
  - Enable in Firebase Console: Play Integrity for Android, reCAPTCHA Enterprise for web. iOS deferred.
  - `firebase_app_check` dep + `FirebaseAppCheck.instance.activate(...)` in `main.dart`.
  - Set Firestore to **enforce** App Check after smoke-testing in monitor-only mode for a day. Flag this as a deferred toggle in the verification step — don't enforce in the same commit that ships the change.

- [ ] **Step 4: Firestore rules audit + tests**
  - Re-read `firestore.rules`. Confirm `request.auth.uid == resource.data.userId` is enforced on every doc that has user data.
  - Add `firestore.rules.spec.js` (or Dart equivalent) using `@firebase/rules-unit-testing`: cross-user read/write must fail; same-user must succeed.
  - Add composite indexes for any expected queries (currently none; flag if Phase 4 step 2 analytics adds any).

- [ ] **Step 5: Privacy policy**
  - Static HTML at `vulgus.app/privacy` deployed via the same Firebase Hosting setup as the puzzles.
  - Content covers: what's collected (email, anonymous analytics, crash logs), what's shared (none), retention, contact email.
  - Link from the settings screen "About" section.

- [ ] **Step 6: Verification**
  - Crashlytics dashboard shows test crash.
  - Analytics DebugView shows test events firing in order during a real session.
  - App Check denies an unsigned request from `curl` against the Firestore REST endpoint.
  - Rules tests are green in CI.

## Phase 5 — Game UX polish: closeness feedback + share artifact

**Goal:** Two related game-UX changes that compound the launch surface. The closeness feedback ships the (b) hits-counter pattern resolved by user (decision #6); share artifact polish verifies the marketing surface per the competitor analysis.

### 5a. Closeness feedback (hits counter)

- [ ] **Step 1: Compute hit count per guess in `GameController`**
  - In `flutter_app/lib/game/game_controller.dart`, when a wrong guess is submitted, count how many of the 4 selected tiles belong to the same target category (the maximum match across categories).
  - Add the result to the existing `Guess` record / state so the UI can render it.
  - Pure-Dart logic — testable in `game_controller_test.dart` without widgets.

- [ ] **Step 2: Render the hits counter in the wrong-guess feedback**
  - In `flutter_app/lib/game/widgets/daily_tile_grid.dart` (or sibling), display "2 right" / "3 right (one away)" / "1 right" in the existing wrong-guess feedback strip.
  - Match Bauhaus visual language — no rounded badges; clean typographic weight per `DESIGN.md`.
  - For "0 right" — show nothing or a neutral "not even close" message; pick whichever reads better in playtest.

- [ ] **Step 3: Tests**
  - Update `flutter_app/test/game/game_controller_test.dart` with hit-count assertions: 0, 1, 2, 3 right, plus the 3 = "one away" boundary.
  - Update `flutter_app/test/game/widgets/daily_tile_grid_test.dart` to assert the hits-counter renders.

- [ ] **Step 4: Verify share artifact unchanged**
  - The share grid (Bauhaus shape grid) must remain spoiler-safe and identical to before — closeness feedback only changes the in-game UX, not the post-game share output.
  - Re-run `share_text_test.dart`; should pass without modification.

### 5b. Share artifact polish (the marketing)

- [ ] **Step 5: Thumbnail-legibility test**
  - Render the share grid PNG/text at 200×200, 400×400, 800×800.
  - Eyeball at each size: is it instantly recognisable as VULGUS, not Connections?
  - Tweak shape/colour weights if not.

- [ ] **Step 6: Spoiler-safe verification**
  - Walk through 5 random shared grids from solved puzzles. Confirm none of them leak any of the four answer words.

- [ ] **Step 7: One-tap copy**
  - Mobile: native share sheet (already wired).
  - Web: `navigator.clipboard.writeText` with a "Copied!" toast.
  - Verify on iOS Safari (clipboard API is gated behind user gesture on Safari — the tap counts).

- [ ] **Step 8: Share text format**
  - Lock format: `VULGUS #001 · 3/4 lives · vulgus.app/p/001\n\n[shape grid]\n\n#vulgus`.
  - Hashtag is optional but adds discoverability without being cringe.

- [ ] **Step 9: Verification**
  - Paste into WhatsApp, iMessage, Twitter, Bluesky, Slack — confirm the grid renders consistently in each.

## Phase 6 — Editor voice & metadata

**Goal:** Per the competitor analysis, a named editor with public taste is a marketing asset that the NYT cannot replicate. Wire the persona at the surface level.

- [ ] **Step 1: Editor signature line in the puzzle footer**
  - End-modal footer reads: `Today's puzzle by — [Editor Name]`.
  - Sourced from the puzzle JSON (`editor` field added to schema in Phase 2).
  - Falls back to a static string if the field is missing.

- [ ] **Step 2: Etymology footnote in share text**
  - Optional one-liner appended to the share artifact: the lead etymology of one of today's words.
  - Already partially in the prototype — port to the Flutter share-text builder.

- [ ] **Step 3: Decision parking**
  - Real name vs. persona vs. anonymised — flag for Rob to decide outside this plan. Default to `VULGUS` until decided so nothing blocks the launch.

- [ ] **Step 4: Verification**
  - Signature line renders on game-end modal.
  - Share text includes the etymology hook.
  - Both fields are sourced from the JSON, not hard-coded.

## Phase 7 — Vulgar switch (binary tonal toggle, default tame)

**Goal:** Ship the cross-cutting tonal toggle as v1 architecture, even if the spicy puzzle library starts small. Default tame protects the app-store rating and surface; filthy-mode opt-in is the recruit hook for etymology-Twitter and comedy-podcast adjacencies.

**Why now (not v1.1):** the *infrastructure* (settings UI, lexicon severity-filter, per-account synced state) is cheap if built before any users exist. Retrofitting it later means adding a setting to existing accounts and risking a default-state migration. The *content* (filthy-mode puzzles) can scale up post-launch independently — the switch can ship with an empty filthy library and the editorial backlog fills in over weeks. This is the cheap-now / awkward-later choice.

**Confirmed shape (2026-04-26):**
- **Binary toggle** at v1 (Tame / Filthy). 3-position slider deferred to v1.1 once usage data exists.
- **Default tame.** App-store screenshots show the tame surface.
- **Per-account, synced via Firestore** so the setting follows the user across web + mobile.
- **Same editorial bar** at every level — filthy is the *best* version of that puzzle, not just a rude version. Don't let filthy mode become the dumping ground for weak-but-rude entries.

- [ ] **Step 1: Lexicon severity model audit**
  - The lexicon already has a `Severity` field (1–5) per word. Confirm every word in the current 302-word lexicon has it populated. The dictionary expansion plan is upgrading the schema; verify alignment.
  - Define the cut: tame mode allows severity ≤ 3; filthy mode allows severity 1–5. (Adjust thresholds based on a content review with Rob.)

- [ ] **Step 2: Puzzle JSON schema — add tonal mode tag**
  - Extend `dictionary/puzzle.schema.json` (Phase 2 step 1) with a `mode` field: `"tame" | "filthy"`.
  - Each daily puzzle is published in both modes — same date, two files: `puzzles/<YYYY-MM-DD>.tame.json` and `puzzles/<YYYY-MM-DD>.filthy.json`. App fetches whichever the user's setting selects.
  - For the existing 50-puzzle backlog (currently all PG-toned), generate `tame.json` only. Filthy variants are authored post-launch.

- [ ] **Step 3: User settings model**
  - Extend the user document in Firestore with `tonalMode: "tame" | "filthy"` (default `"tame"`).
  - Surface in the settings screen as a single toggle: "Filthy mode" (off by default).
  - Hide behind a one-time "Are you sure?" confirmation on first enable — gives a moment for context-setting copy ("VULGUS gets significantly more vulgar from here. Adults only.").

- [ ] **Step 4: Filter the home feed**
  - `PuzzleRepository.forDate(today)` (Phase 2 step 3) reads the user's `tonalMode` and fetches the matching variant.
  - If filthy mode is selected but no filthy variant exists for today (e.g. early days when the library is sparse), gracefully fall back to the tame variant with a small banner: "Today's puzzle isn't in filthy mode yet — playing tame."

- [ ] **Step 5: Settings UX — non-paywalled at v1**
  - The toggle is free at v1. Paywalled filthy unlock is a v1.1 monetisation lever, considered separately.
  - Place the toggle in the existing settings screen under a clearly-labelled "Tone" section.

- [ ] **Step 6: App Store / Play Store listing implications**
  - Screenshots: tame mode only. The store listing represents the default state.
  - App rating: should still qualify for 12+ (App Store) / Teen (Play Store) at the surface. Filthy mode pushes it to 17+ / Mature, but Apple/Google rate based on what content is *accessible*, including via opt-in toggles. Worth a careful read of the current 17+ guidelines before submission — may need to bump the rating regardless.
  - Action item: review Apple's "Objectionable Content" guidelines (1.1) and Play's "Adult Content" policy before Phase 8 submission.

- [ ] **Step 7: Verification**
  - Toggle persists across app restarts and across web ↔ mobile sessions.
  - Tame default holds for new users.
  - Today's puzzle changes in real time when the toggle flips (or with one refresh).
  - Filthy fallback to tame works gracefully when no filthy variant exists.
  - Editorial workflow doc (`dictionary/PUBLISHING.md`, Phase 2 step 6) is extended with a "publishing a filthy variant" recipe.

**Estimated effort:** 1.5–2 dev-days for infrastructure. Editorial cost (authoring filthy variants of past puzzles + ongoing daily) is separate and continuous, not in this estimate.

## Phase 8 — Store listing groundwork

**Goal:** Build the artefacts needed for Play Store submission. Submission itself is gated on Kat's icon + screenshots and is a separate user action.

- [ ] **Step 1: Switch from APK to App Bundle for release**
  - `flutter build appbundle --release` — reuses the keystore from the existing Android Release plan.
  - Verify the `.aab` is signed (`bundletool` or upload to Play Console internal testing track).

- [ ] **Step 2: Play Store data-safety form draft**
  - Document what's collected (email, analytics events, crash logs), what's shared (nothing with third parties), data deletion path (delete account → all user data wiped within 30 days).
  - Save as `docs/play-store-data-safety.md` for paste-into-console.

- [ ] **Step 3: Privacy policy URL**
  - Already deployed in Phase 4 step 5; record `https://vulgus.app/privacy` as the URL for the Play Console listing.

- [ ] **Step 4: ASO keyword research**
  - Run the `aso-optimizer` skill in parallel to surface keyword opportunities. Output goes into `docs/aso-keywords.md` — not committed in this plan, used at submission time.

- [ ] **Step 5: Out of scope confirmation**
  - This plan does NOT submit to the Play Store, NOT generate marketing screenshots, NOT ship iOS, NOT wire monetisation. Each is its own follow-up.

## Critical files

- `flutter_app/pubspec.yaml` — version bumps in Phase 1.
- `flutter_app/lib/main.dart` — Crashlytics + Analytics + App Check wiring in Phase 4.
- `flutter_app/lib/core/router.dart` — go_router 17 migration in Phase 1.
- `flutter_app/lib/auth/auth_service.dart` — google_sign_in 7 migration in Phase 1.
- `flutter_app/lib/notifications/notification_service.dart` — flutter_local_notifications 21 migration in Phase 1.
- `flutter_app/lib/game/data/*.dart` — replaced/superseded by `puzzle_repository.dart` in Phase 2.
- `flutter_app/lib/game/data/puzzle_repository.dart` — NEW in Phase 2.
- `flutter_app/lib/core/platform.dart` — NEW in Phase 3.
- `flutter_app/web/index.html` — NEW in Phase 3.
- `flutter_app/firebase.json` — extended for Hosting in Phase 2 / 3.
- `flutter_app/firestore.rules` — audited in Phase 4.
- `dictionary/puzzle.schema.json` — NEW in Phase 2; extended in Phase 7 for `mode` field.
- `dictionary/puzzles/*.json` — NEW in Phase 2 (50 files migrated from dart); split into `<date>.tame.json` / `<date>.filthy.json` in Phase 7.
- `dictionary/PUBLISHING.md` — NEW in Phase 2; extended in Phase 7 with the filthy-variant publishing recipe.
- `flutter_app/lib/settings/settings_screen.dart` — add tonal-mode toggle in Phase 7.
- `flutter_app/lib/auth/user_model.dart` — add `tonalMode` field in Phase 7.
- `flutter_app/lib/game/game_controller.dart` — hits-counter computation in Phase 5a.
- `flutter_app/lib/game/game_state.dart` — add hit-count to `Guess` record in Phase 5a.
- `flutter_app/lib/game/widgets/daily_tile_grid.dart` — render hits counter in Phase 5a.
- `docs/play-store-data-safety.md` — NEW in Phase 8.

## Open decisions still parked (non-blocking for the build)

- **Editor name / persona** — defaults to `VULGUS` if not chosen; can be swapped in the JSON anytime.
- **Domain** — `vulgus.app` is **NOT yet registered** (confirmed 2026-04-26). Two paths:
  1. Register `vulgus.app` (~$15/yr at Cloudflare/Namecheap; `.app` is a Google-owned TLD with HSTS-preload required). Strongest brand match with the app name; recommended before public launch.
  2. Ship Phase 2/3 to the free Firebase default URL (`vulgus-<project-id>.web.app`) and migrate to `vulgus.app` later — Firebase Hosting supports adding a custom domain to an existing site without redeploying.
  Until decided, all Phase 2/3 build artefacts use the Firebase default URL. Hard-coded references to `vulgus.app` in share text (Phase 5 step 4) and remote puzzle base URL (Phase 2 step 3) come from a single config constant so the swap is one-line.
- **Launch fandom** — competitor analysis recommends picking one (British comedy podcasts vs. etymology Twitter). Operational, not code.
- **Puzzle date assignment for the 50-puzzle backlog** — what's puzzle 001's launch date? Affects the JSON migration in Phase 2 step 2.

## End-to-end verification

After all phases:

- `flutter test` green on stable SDK.
- `flutter analyze` reports zero warnings.
- `https://vulgus.app` plays today's puzzle in Chrome, Safari, Firefox.
- Signed Android `.aab` exists at `build/app/outputs/bundle/release/`.
- Today's puzzle loads from `puzzles/<today>.json`; offline mode falls back to bundled.
- Crashlytics dashboard shows test crash; Analytics shows test events.
- Firestore rules unit tests deny cross-user reads.
- App Check denies unsigned requests (in monitor mode for v1; enforce after a day).
- Share artifact one-tap copies on web + mobile, recognisable at 200px.
- Editor signature renders in end-modal footer.
- Privacy policy live at `vulgus.app/privacy`.
- Vulgar switch toggle persists across web ↔ mobile sessions; tame default holds for new users; filthy fallback to tame works when no filthy variant is published.
- Hits-counter renders correctly for 1/2/3-right wrong guesses; 3-right shows the "one away" qualifier; share grid is unchanged.

## Estimated effort

~7.5–8.5 working days for a single developer:

- Phase 1: 1 day (mostly mechanical; google_sign_in 7 and flutter_local_notifications 21 are the time-sinks).
- Phase 2: 1 day.
- Phase 3: 1.5 days.
- Phase 4: 1 day.
- Phase 5: 1 day (closeness feedback ~0.5 day + share artifact polish ~0.5 day).
- Phase 6: 0.5 day.
- Phase 7: 1.5–2 days (vulgar-switch infrastructure; editorial filthy-variant authoring is separate).
- Phase 8: 0.5 day.

Phases 1, 4, 8 are largely mechanical. Phases 2, 3, 7 are the substantive build work. Phases 5, 6 are polish that compound the marketing surface.
