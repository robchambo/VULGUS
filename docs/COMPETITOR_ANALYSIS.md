# Competitor Analysis — "Connect"-Style Word Games

*Scope: daily word-grouping / connection puzzles in the lineage of NYT Connections, plus the broader daily-puzzle field that competes for the same attention slot. NYT is referenced as the category leader but is excluded from the "what to copy" analysis because its scale, brand, and bundle (Wordle + Crossword + Spelling Bee + Strands) are not reproducible.*

*Compiled April 2026. Updated 2026-04-26 with **Section 6: etymology-quiz / word-origin daily** — companion analysis for the VULGUS app #2 (separate-app, family-brand model locked in the launch-readiness plan). Section 6 also includes the detailed mobile-ads playbook (eCPM by format, retention effects, the rewarded-vs-interstitial trade-off) that earlier sections only touch on.*

---

## 1. The competitive set

### 1a. Direct Connections-style (group 16 → 4 of 4)

| Game | Hook | Platform | Model |
|---|---|---|---|
| **PuzzGrid** | Based on BBC "Only Connect"; thousands of user-submitted grids; timer; harder red herrings | Web | Free, ad-supported |
| **Red Herring** | Tighter focus on misleading overlaps between groups | iOS / web | Free w/ ads |
| **Connections Unlimited** (.org / .io) | Unlimited replays + archive of past NYT puzzles | Web | Free, ad-supported |
| **Sports Connections / connectionssports.net** | Sports-trivia twist on the NYT format | Web | Free, ad-supported |
| **Harmonies / Pop Singers Connections / Spotle** | Music-themed groupings | Web | Free, ad-supported |
| **Connect Word: Association Game** (Hit Apps) | Generic mobile clone | iOS / Android | Free w/ ads + IAP |
| **Connections Word Game** (multiple devs: Wixot, Megarama, etc.) | Generic mobile clones, often "unlimited" | iOS / Android | Free w/ aggressive ads |
| **Connections for Kids** | Age-appropriate categories, classroom positioning | Web / printable | Free / TPT paid |

### 1b. Adjacent daily puzzles competing for the same 5-minute slot

| Game | Mechanic | Notable feature | Model |
|---|---|---|---|
| **Knotwords** (Zach Gage / Jack Schlesinger) | Logic + words; arrange letters so every row & column is a valid word | Beautiful minimal UI; press darling | Free core, $4.99/yr or $11.99 lifetime for Twist daily, hints, stats, themes |
| **Puzzmo** (Zach Gage, Hearst-owned) | Hub of ~10 indie-designed daily puzzles | Leaderboards, groups, archive, social layer | Free + Puzzmo Plus: $3.99/mo or $39.99/yr |
| **Quartiles** (Apple News+) | Build words from letter segments; daily | Bundled into Apple News+ subscription | Subscription bundle |
| **Contexto** | Guess a hidden word using semantic distance | "Closeness" feedback creates very different rhythm | Free, ad-supported |
| **Crosswordle** | Mini crossword solved by swapping letters in 6 moves | Hybrid logic / word | Free |
| **Phrazle** | Wordle for phrases (6 attempts) | Higher difficulty ceiling | Free, ad-supported |
| **Strands** (NYT) | Word-search + secret theme + "spangram" | Listed for context only — NYT-owned | NYT Games sub |
| **Heardle** (Spotify, killed 2023) | Guess the song from intro clips | Acquired by Spotify in 2022, shut down May 2023 — a cautionary tale about platform dependency | Was free |

---

## 2. Feature comparison — what successful Connections-likes ship

| Feature | NYT Connections | Puzzmo | Knotwords | Generic mobile clones | PuzzGrid |
|---|:-:|:-:|:-:|:-:|:-:|
| One puzzle / day | ✅ | ✅ | ✅ + archive | ❌ unlimited | ❌ unlimited |
| 4-lives mechanic | ✅ | n/a | n/a | ✅ | ❌ |
| "One away" nudge | ✅ | n/a | n/a | partial | ❌ |
| Color-coded difficulty | ✅ | n/a | n/a | usually copied | ❌ |
| Shuffle button | ✅ | n/a | n/a | ✅ | ❌ |
| Streak tracking | ✅ | ✅ | ✅ | rarely | ❌ |
| Leaderboards / groups | ❌ | ✅ | ❌ | ❌ | ❌ |
| Archive of past puzzles | sub-only | sub-only | sub-only | ✅ free | ✅ free |
| Spoiler-safe share artifact | ✅ emoji grid | ✅ stats card | ✅ | mostly | ❌ |
| Hints (paid) | partial | partial | ✅ | ✅ | ❌ |
| Editorial curation | high | high | high | none — random/generated | community-submitted |

**Pattern:** the table-stakes feature set is now well-defined. Where successful apps differentiate is *not* in mechanics — it's in **content quality, brand voice, and the share artifact**.

---

## 3. Marketing & distribution patterns

### What worked — the viral playbook

1. **Web-first, no install.** Every breakout daily puzzle of the past five years (Wordle, Connections, Heardle, Contexto, Spotle, Crosswordle) launched as a free browser page. Mobile apps came later, often as ports. App-store-first launches almost always die in obscurity unless there's a media partner pushing them.

2. **The shareable emoji/icon grid is the single most valuable marketing asset.** Wordle's grid was added by a user (Elizabeth S on Twitter) before the NYT bought it; it 10x'd traffic. Connections inherited the pattern. The grid must be:
   - **Spoiler-safe** (no answer leaked)
   - **Visually distinct** (recognisable in a feed at a glance)
   - **Brag-friendly** (shows skill, not just completion)
   - **One-tap copy** (anything more breaks the loop)

3. **Same puzzle for everyone, every day.** The collective "did you do today's?" conversation only works if the puzzle is shared. Unlimited-play clones lose this entirely — they are infinite-content products, not social rituals.

4. **Niche / themed variants beat generic clones.** Themed Wordle clones with a built-in fandom — Heardle (music), Taylordle (Swifties), Swordle (Star Wars), Poeltl (NBA), Sportle, Spotle — break out because they recruit through existing communities. Generic "Connections Word Game" mobile clones languish in the App Store long-tail. **A pre-existing audience to recruit from is worth more than a clever mechanic.**

5. **Designer / curator brand drives press.** Zach Gage products (Knotwords, Puzzmo, Good Sudoku, Really Bad Chess) get reviewed on MacStories, 9to5Mac, Touch Arcade by name. Anonymous studio clones get nothing. A named designer or editor with a public POV is a marketing asset.

6. **Distribution partnerships > paid UA for sustainability.** Puzzmo's growth is via Hearst — it ships in 50+ Hearst-owned newspaper sites and is licensed to Postmedia, Vox, The Skimm, Digg. Heardle was acquired by Spotify. Going DTC on the App Store and buying TikTok ads is the *expensive* path; a media partner is the *cheap* one.

7. **TikTok / short-form video for paid UA, if you do go paid.** TikTok is now #1 for global mobile-game UA growth; >60% of TikTok users are mobile gamers; playable ads convert. Word games in particular over-index on casual older demographics on Facebook, younger on TikTok — a split-channel strategy.

### What didn't work

- **Aggressive interstitial ads in mobile clones** — depresses retention, kills word-of-mouth, signals low quality. Generic Connections clones on the Play Store consistently get 1–2★ for ad volume.
- **"Unlimited" framing as the headline value prop** — it cannibalises the daily-ritual social hook. It's fine as a paid extra; it's a poison-pill as the core proposition.
- **Single-mechanic apps without a content engine** — the mechanic is now commoditised. Without sustained editorial output, players churn in 2–3 weeks.
- **Heavy paywall day-one** — Puzzmo's "free core, paid archive/extras" works; a paywall on the daily puzzle doesn't.

---

## 4. Business models — what monetises

| Model | Example | Notes |
|---|---|---|
| **Freemium subscription** ($3–4/mo, $30–40/yr) | Puzzmo Plus, Knotwords, NYT Games | Works when there's editorial output and an archive worth paying for. The dominant successful model. |
| **One-time IAP unlock** ($10–12) | Knotwords lifetime | Works for premium-feel indies with a designer brand. Higher LTV if retained. |
| **Bundle into a larger sub** | Quartiles in Apple News+ | Distribution play; the puzzle exists to retain the larger sub. Not viable solo. |
| **Platform / publisher licensing** | Puzzmo → Hearst, Postmedia | Highest-leverage model if you can land it. Effectively a B2B SaaS. |
| **Acquisition** | Wordle → NYT ($1–3M+), Heardle → Spotify | Aspirational outcome rather than a model. Drives founder-friendly behaviour during build. |
| **Pure ads (free clone)** | Most App Store Connections clones | Race to the bottom. Low LTV, no defensibility, rotates as policies change. |

**Implication:** if VULGUS targets >$0 revenue, the realistic paths are (a) freemium archive/extras around a free daily, or (b) a publisher partnership where VULGUS is the daily puzzle for a media brand whose audience matches the editorial voice (LADbible, Vice, The Spinoff, The Guardian's irreverent wing, a comedy-podcast network).

---

## 5. What makes the successful ones different — and what it means for VULGUS

The non-NYT winners share a small set of traits. None of them is "better mechanics."

1. **A point of view the NYT cannot or will not adopt.**
   - Knotwords: minimal logic-puzzle aesthetic, Apple-design sensibility.
   - Puzzmo: indie puzzle-designer collective with personality.
   - Heardle / Spotle / Sportle: explicit fandom angle.
   *VULGUS already has this — "playful, never punches down" profanity + etymology is a defensible POV the NYT structurally can't ship.*

2. **A named curator/editor with public taste.** Zach Gage's name sells a Knotwords download. A "VULGUS editor" persona — visible voice in the share text, footer notes, social — is worth more than a logo.

3. **A share artifact that's visually distinct, not a Wordle/Connections lookalike.** The Bauhaus shape grid in the prototype is the right instinct. It needs to be (a) instantly recognisable as VULGUS, not Connections, (b) spoiler-safe, (c) one-tap copy, (d) legible at thumbnail size on Twitter/IG/WhatsApp.

4. **Web-first launch, mobile-second.** A free public-URL daily puzzle is the only realistic way to get organic shares. The Flutter port is the right Step 2 — but the marketing surface should be a permanent web entry point that updates daily.

5. **Editorial cadence and pipeline > clever code.** Connections-style games live or die on puzzle quality. The dictionary work and 2-reviewer pipeline already in the GDD is the real moat; it should be the headline pitch when courting partners or press.

6. **A built-in audience to recruit from.** Themed-clone winners borrow a fandom. VULGUS doesn't have a single fandom but it has multiple adjacent ones: comedy podcast listeners, etymology nerds, swearing-as-craft writers (Mohr, Bergen, McWhorter readers), British comedy fans. **Pick one or two for launch and seed there**, rather than aiming generically at "Connections fans."

7. **Restraint on monetisation.** Free daily, free streak, free share. Paywall the archive, themed week packs (Shakespearean swears, Aussie pack), and gift codes. Avoid interstitial ads — they're inconsistent with the design-led brand.

   **Cross-cutting product lever — the vulgar switch.** Confirmed direction (2026-04-26): a binary tonal toggle in user settings (tame by default, filthy mode opt-in), per-account and synced across web + mobile. The switch resolves the brand/audience tension that otherwise forces a single tonal commitment: app-store screenshots show the tame surface, etymology-Twitter recruits know the spicy mode is one tap away. Same editorial bar at every level — filthy mode must be the *best* version of that puzzle, not just the rude version. Worth shipping as v1 architecture (settings toggle + lexicon severity-filter), even if the spicy puzzle library starts small and grows post-launch. Paywall on filthy mode unlock is a viable v1.1 monetisation lever once the content backlog supports it.

### Concrete recommendations for VULGUS

- **Lead with the shareable Bauhaus grid.** Make it the centre of the launch screenshot, the press kit, and the share text. Tighten it until it's recognisable on Twitter at 200px.
- **Establish the editor voice early.** Name a (real or persona) editor; sign each puzzle with a one-line etymology footnote — that's already in the prototype and is a marketing asset, not a UX detail.
- **Launch on the web first under vulgus.app or similar; treat the Flutter app as channel #2.** The web URL is the shareable thing.
- **Pick a launch fandom.** Two viable options: (a) British comedy / podcast Twitter (No Such Thing As A Fish, Off Menu, The Rest Is History adjacency); (b) etymology / linguistics nerd Twitter (Mark Forsyth, John McWhorter readers). Either gets you to organic 10k DAU faster than a generic launch.
- **Monetisation v1: free daily forever, $2.99/mo or $19.99/yr for archive + themed packs + ad-free if/when ads are added.** Don't ship ads at launch.
- **Long shot worth pursuing: a publisher partnership.** Vice, LADbible, The Spinoff, The Guardian's culture vertical, or a comedy podcast network as a distribution + co-marketing partner. This is the Puzzmo/Hearst model and the highest-leverage growth path.

### What to *not* copy from competitors

- Don't copy NYT Connections' purple-yellow-green-blue palette — the Bauhaus palette is a differentiator, keep it.
- Don't ship "unlimited mode" as the headline. It nukes the daily ritual.
- Don't ship interstitial ads in v1.
- Don't ship without the spoiler-safe share artifact polished — it is the marketing.

---

## 6. Etymology-quiz / word-origin daily — companion analysis for VULGUS app #2

*Added 2026-04-26 after the launch-readiness plan locked etymology-quiz as the second app in the VULGUS family. The analysis is tighter than sections 1–5 because the niche is much smaller, and adds a detailed mobile-ads playbook because that question came up explicitly during the brief.*

### 6a. The competitive set

#### Direct (etymology-as-game)

| App | Hook | Platform | Model |
|---|---|---|---|
| **Orijinz Daily** (Entspire LLC) | Read the origin → guess the word/phrase. Includes a "Con Game" variant (multiple plausible origins, pick the real one — NPR's *Says You* style). Originated as a Parent's Choice-awarded card game; press from NYT and *People*. | iOS / Android / web / Mac / PC | One free puzzle/day; card-game expansions sold separately |
| **EtymologyExplorer** | Visual etymology trees, cross-language cognate search, Word of the Day notification. Exploration tool, not a quiz primarily. 4.8★ / 1.5k ratings. | iOS / Android | Freemium — $3.99/mo · $19.99/yr · $59.99 lifetime · $1.49 supporter |
| **Etymology Dictionary Offline** | Reference + bundled quiz feature. | iOS | Free + small premium |

#### Adjacent — the data backbone and the daily-content layer

| Property | What it is | Why it matters |
|---|---|---|
| **Etymonline app** (Online Etymology Dictionary, Douglas Harper) | Dominant reference. 4.9★, 100k+ Android downloads. Premium = ad-free + offline. | Players will fact-check anything you ship against this. Worth attribution; partnership conceivable. |
| **Word of the Day** (helium) | Daily vocab + 1-min mini-quiz. 7M+ downloads, 2025 Best Mobile App award. Spaced-repetition retention loop. | The proven daily-ritual mechanic in this audience — 1-minute commitment, streak-tracked. |
| **Vocabulary.com / Anki / Quizlet / Memrise** | Vocab-as-quiz, education-coded. | Adjacent audience; education brand association makes them poor recruiting grounds for etymology-Twitter. |
| **Elevate** | Gamified brain training (vocab subset). Apple App of Year. | Reference for retention loops, not a competitor for share-of-voice. |

#### Aspirational — the brand moat in etymology content

- **Susie Dent's *Something Rhymes With Purple*** (with Gyles Brandreth) — Purple Plus Club paid tier. The etymology-celebrity model. Competitor for *attention*, not downloads. Susie Dent has also presented *Susie Dent's Guide to Swearing* on Channel 4 — directly adjacent to VULGUS's tonal positioning.
- **Mark Forsyth** (*The Etymologicon*, @inkyfool) — adjacent text brand.
- **NYT Games** ($4.99/mo · $39.99/yr) — Wordle, Connections, Strands, Spelling Bee, Crossword bundle. Free daily, paywall on archive + hints. The category anchor.

### 6b. Feature comparison

| Feature | Orijinz Daily | EtymologyExplorer | Etymonline | Word of the Day | NYT Games | **VULGUS-Etymology** (proposed) |
|---|:-:|:-:|:-:|:-:|:-:|:-:|
| One puzzle/day | ✅ | partial (WOTD only) | ❌ | ✅ | ✅ | ✅ |
| Multiple-choice quiz format | ✅ | ❌ | ❌ | ✅ | ❌ | ✅ |
| "Guess the era" / region | ❌ | ❌ | ❌ | ❌ | ❌ | ★ gap |
| Distractor relationships (etymological cousins) | ❌ | partial | ❌ | ❌ | ❌ | ★ gap |
| Spoiler-safe share grid | ❌ | ❌ | ❌ | partial | ✅ | ★ gap |
| Streak / lives | ❌ | ❌ | ❌ | partial | ✅ | ✅ |
| Editorial voice | weak | weak | strong (Harper) | weak | strong | ★ gap to fill |
| Adult / playful tone | family | neutral | neutral | neutral | family | ★ gap (matches VULGUS family voice) |
| Archive of past puzzles | free | premium | n/a | free | premium | (TBD) |
| Subscription | ❌ | ✅ | ✅ | ✅ | ✅ | $3.99/mo recommended |

**The empty quadrants:** era / region guessing as a daily mechanic, an adult-playful tone, and a strong editorial voice are simultaneously absent across every existing competitor. Those are your three differentiators.

### 6c. Pricing landscape — what etymology / word-quiz audiences will pay

| Price point | Example | Notes |
|---|---|---|
| **$4.99/mo · $39.99/yr** | NYT Games | The market anchor |
| **$3.99/mo · $19.99/yr · $59.99 lifetime** | EtymologyExplorer | Undercuts NYT; the lifetime tier matters for the design-led indie crowd |
| **One-time IAP for ad-free + offline** | Etymonline | Reference-style monetisation; not a quiz model |
| **Podcast/community sub** | Susie Dent's Purple Plus Club | Audience overlap is direct |
| **Free + ads only** | Wordle clones | 1-2★ review sink; brand-corrosive |

**Recommended for VULGUS-Etymology:** **$3.99/mo · $24.99/yr · $49.99 lifetime.** Below NYT's anchor, in line with EtymologyExplorer, with a lifetime tier as the indie-respect signal.

### 6d. How mobile ads actually work in this category

Detailed because earlier sections didn't cover ad mechanics in depth, and the "no ads at launch" decision deserves the data behind it.

**Networks:** Google AdMob (~28% of mobile-game ad supply) + AppLovin (~24%) ≈ 52% combined. Integrate one; mediate the other later. Side networks (Unity Ads, ironSource, Vungle) come in via mediation.

**eCPM by format** (US/UK premier markets, 2025–26 data):

| Format | eCPM | Effect on retention |
|---|---|---|
| Banner | $0.50–$1.30 | Low harm, low revenue. Mostly noise. |
| Interstitial (every level) | $3–$10 | **Drives 15–25% of new players to abandon in their first session.** |
| Interstitial (every 3–4 levels) | $3–$10 | Tolerable; the standard trade-off. |
| **Rewarded video** (opt-in for hints / extra life) | **$10–$50** | **Increases 30-day retention to 53–68% — 3.5–5× baseline.** The single best tool in the puzzle-game ad design kit. |
| Offerwalls | Highest | Niche; suspicious users; not a fit for an editorial brand. |

**The playbook the data points at — for v1.1, not launch:**

1. **Never interstitial mid-puzzle.** This is the rule the bottom-feeder Wordle clones break and pay for in 1–2★ reviews.
2. **Heavy rewarded video for hints** — "watch an ad to reveal one wrong distractor" / "watch to see the era". Free-tier playable, doesn't kneecap retention, and rewarded eCPM is 10–50× banner eCPM.
3. **At most one optional interstitial after the daily play** — between the end-modal and the "see archive" CTA. Tolerable.
4. **Premium tier removes ads entirely** + unlocks archive + hint-bank. Same shape as NYT Games and EtymologyExplorer; the audience already understands this model.

**Why "no ads at launch" is correct for both VULGUS apps:**

- Banner / interstitial at launch tank retention before any retention exists to lose.
- Brand-tier word games (NYT, Knotwords, Puzzmo) all keep their core ads-free.
- Rewarded video has no purchase at launch because there's no archive / hint-bank to gate behind it. Add when those exist (v1.1+).

### 6e. Positioning — the white space

Two axes that matter: **Tone** (family-neutral ↔ playful-adult) and **Engagement model** (reference ↔ daily ritual).

```
                Daily ritual
                     |
        Word of      |  NYT Games
        the Day      |  (Wordle / Connections)
                     |
   Orijinz Daily ---- *  ←  empty quadrant — VULGUS-Etymology lives here
                     |
   ──────────────────+──────────────────  Tone
        Family       |       Playful-adult
                     |
   EtymologyExplorer |  (Susie Dent's swearing
   Etymonline        |   guides — content, not app)
                     |
                Reference / exploration
```

**The upper-right quadrant — daily ritual + playful-adult tone — is empty.** This is the same positioning Section 5 identified for VULGUS-Connections, which strengthens the family-brand argument: both apps share the defensible POV.

### 6f. Concrete recommendations for VULGUS-Etymology

- **Differentiate on era / region guessing**, not just "guess the word from the origin" (which Orijinz already does well). The "this entered English in: 1300s · 1500s · 1700s · 1900s" mechanic is unclaimed.
- **Distractor relationships matter.** Wrong answers should be etymological cousins, not random words — that's the equivalent of the "interesting wrong groupings" insight Connections gets right.
- **Carry the Bauhaus visual identity over from VULGUS-Connections.** Every existing etymology app is generic-looking. Visual distinction at thumbnail size is half the marketing.
- **Name a single editor.** Susie Dent's brand exists because she has a face. Etymonline has Douglas Harper's name on the masthead. NYT Games doesn't — but they're NYT. You're not, so you need a face.
- **Free daily forever; archive + hints + ad-free behind a $3.99/mo · $24.99/yr · $49.99 lifetime paywall.**
- **Partnership long-shot worth pursuing:** Etymonline (Douglas Harper, solo operation) for either licensing the data formally or co-branding the daily quiz. Lower probability than the Hearst/Puzzmo angle but the audience overlap is exact.

### Cross-cutting: the vulgar switch applies to both VULGUS apps

The tonal toggle defined in Section 5 (tame default, filthy opt-in, per-account, synced) is a family-level product feature, not specific to VULGUS-Connections. VULGUS-Etymology benefits from it equally — a tame distractor pool stays family-friendly while filthy mode unlocks 17+-grade etymologies (the Susie Dent's *Guide to Swearing* register). Same lexicon filter, same severity ratings, same per-account synced setting. The shared settings are an additional argument for one Firebase project, multiple apps (the architecture call already locked in the launch-readiness plan).

### What to *not* copy from etymology competitors

- Don't copy Etymonline's UX. It's a reference app — ledger-like, dense, optimised for lookups. The opposite of a 90-second daily ritual.
- Don't ship without distractor relationships — multiple-choice with random distractors is what makes generic vocab apps feel disposable.
- Don't go family-neutral to widen the audience. The competitor analysis already establishes the playful-adult tone as the defensible position. Section 5's "POV the NYT structurally can't ship" applies to both VULGUS apps.

---

## Sources

- [Beebom — 8 Best Games Like NYT Connections](https://beebom.com/puzzle/games-like-nyt-connections/)
- [Stylecaster — 10 Games Like NYT's Connections](https://stylecaster.com/lists/games-like-connections/)
- [Spellby — 7 Best Games Like Connections](https://spellby.com/tips/games-like-connections)
- [Crosswordle Blog — 25 Best Wordle Alternatives](https://crosswordle.com/blog/wordle-alternatives)
- [Thinky Games — Daily puzzle games beyond Wordle/Connections](https://thinkygames.com/features/tired-of-wordle-and-connections-try-these-6-fun-daily-puzzle-games-that-will-get-you-thinking/)
- [Game Developer — Puzzmo co-creator Zach Gage interview](https://www.gamedeveloper.com/design/puzzmo-co-creator-zach-gage-on-building-newspaper-games-that-can-last-forever)
- [Axios — Hearst launches Puzzmo](https://www.axios.com/2023/10/20/puzzmo-hearst-zach-gage-new-york-times)
- [Editor & Publisher — Puzzmo mobile launch](https://www.editorandpublisher.com/stories/puzzmo-launches-mobile-app-exclusively-for-iphone,255847)
- [Game Developer — The rise of newspaper games](https://www.gamedeveloper.com/design/the-rise-of-newspaper-games)
- [MacStories — Knotwords review](https://www.macstories.net/reviews/knotwords-a-new-word-game-from-zach-gage-and-jack-schlesinger/)
- [9to5Mac — Knotwords for iOS and Mac](https://9to5mac.com/2022/04/28/knotwords-for-ios-and-mac-clever-logic-puzzle/)
- [Slate — Wordle creator on why it went viral](https://slate.com/culture/2022/01/wordle-game-creator-wardle-twitter-scores-strategy-stats.html)
- [Wikipedia — Wordle](https://en.wikipedia.org/wiki/Wordle)
- [The Spinoff — emoji grid origin](https://thespinoff.co.nz/media/13-01-2022/those-coloured-boxes-on-twitter-are-new-zealands-fault)
- [Startup Spells — Spotify acquisition of Heardle](https://startupspells.com/p/spotify-acquisition-heardle-wordle-clone)
- [Udonis — Word Game Marketing & UA](https://www.blog.udonis.co/mobile-marketing/mobile-games/word-game-marketing)
- [AppFollow — Mobile game UA with TikTok ads](https://appfollow.io/blog/exploring-mobile-game-user-acquisition-with-tiktok-ads)
- [Comprehensive list of Wordle variants (GitHub gist)](https://gist.github.com/maxspero/0a2f536b9561d829caf6bd994a34193d)

### Sources added 2026-04-26 for Section 6 (etymology niche + ads playbook)

- [Orijinz Daily — Apple App Store](https://apps.apple.com/us/app/orijinz-daily/id6477123796)
- [Orijinz Daily — Google Play](https://play.google.com/store/apps/details?id=com.app.entspirellc&hl=en_US)
- [Orijinz product page (Entspire)](https://www.entspire.com/orijinz-words-phrases)
- [EtymologyExplorer — Apple App Store](https://apps.apple.com/us/app/etymologyexplorer/id1189423897)
- [Etymonline app — Google Play](https://play.google.com/store/apps/details?id=com.etymonline.app&hl=en_US)
- [Etymonline app — Apple App Store](https://apps.apple.com/us/app/etymonline-english-dictionary/id813629612)
- [Word of the Day · Vocabulary — Apple App Store](https://apps.apple.com/us/app/word-of-the-day-vocabulary/id987136347)
- [NYT Games — Apple App Store](https://apps.apple.com/us/app/nyt-games-wordle-crossword/id307569751)
- [NYT Games subscription pricing context](https://www.subscriptioninsider.com/type-of-subscription-business/subscription-apps/wordle-now-available-in-the-new-york-times-crossword-app)
- [Susie Dent — Wikipedia](https://en.wikipedia.org/wiki/Susie_Dent)
- [Tenjin — Ad Monetization in Mobile Games Benchmark 2025](https://tenjin.com/blog/ad-mon-gaming-2025/)
- [MAF.ad — Mobile Ads eCPM data](https://maf.ad/en/blog/mobile-ads-ecpm/)
- [Udonis — eCPMs for Rewarded / Interstitial / Banner](https://www.blog.udonis.co/mobile-marketing/mobile-apps/ecpms)
- [Mistplay — Rewarded ads & player retention](https://business.mistplay.com/resources/rewarded-advertising-player-retention)
- [iion — Interstitial vs Rewarded for gaming apps](https://www.iion.io/blog/interstitial-ads-vs-rewarded-ads-which-one-performs-better-for-gaming-apps)
- [Adjust — 10 best practices for rewarded video](https://www.adjust.com/blog/understanding-rewarded-video-ads/)
- [AppLixir — Rewarded vs interstitial differences](https://www.applixir.com/blog/rewarded-video-ads-vs-interstitial-ads-the-difference-explained/)
- [MonetizeMore — App ad revenue benchmarks 2026](https://www.monetizemore.com/blog/how-much-ad-revenue-can-apps-generate/)
