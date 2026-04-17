# VULGUS

*A word game for the common people.*

VULGUS is a daily puzzle game in the style of NYT Connections, themed around swearing, mild profanity, and the cultural history of "bad" language. Players are given 16 words and must sort them into four hidden categories of four — with categories chosen to teach the nuance, register, and history of how humans curse.

The name comes from the Latin for *the common people* — the root of the English word *vulgar*.

**Tagline:** *Sort the sweary. Skip the slurs.*

## Contents

```
vulgus/
├── README.md                              ← this file
├── docs/
│   └── VULGUS_GDD_v0.1.docx              ← Game Design Document
├── dictionary/
│   ├── vulgus_lexicon.json               ← CANONICAL lexicon (schema v0.2)
│   ├── VULGUS_Dictionary_v0.1.xlsx       ← legacy, read-only reference
│   ├── VULGUS_Dictionary_v0.2.xlsx       ← generated review artefact
│   └── curation/                          ← hand-authored definitions/PoS
├── scripts/
│   ├── migrate_lexicon.py                 ← v0.1 xlsx → v0.2 JSON (one-time)
│   ├── build_xlsx.py                      ← v0.2 JSON → v0.2 xlsx
│   ├── generate_puzzles.py                ← xlsx → dart puzzle files
│   └── export_etymologies.py              ← dart files → CSV
└── prototype/
    └── index.html                         ← Playable single-file web prototype
```

## Quick start

Open the prototype directly in any browser:

```bash
open prototype/index.html     # macOS
xdg-open prototype/index.html # Linux
start prototype/index.html    # Windows
```

No build step, no install — it's self-contained with Tailwind via CDN.

## What's built

- **GDD (Word doc).** 11 sections covering gameplay, content/filtering strategy, Bauhaus visual system, monetisation, MVP scope, and risks.
- **Dictionary (JSON + Excel).** 147 pre-reviewed words across 23 categories, now with length, part-of-speech, plain-English definition, first-attested year, register, flat tag set, Wordle-eligibility flag, and licence metadata per entry. Canonical source is `dictionary/vulgus_lexicon.json`; the v0.2 xlsx is regenerated from the JSON. Schema designed to be portable to other word games (e.g. Wordle, crossword, trivia).
- **Prototype (HTML).** One playable puzzle with 16 tiles, category-colour solve banners, a live etymology strip under the grid, 4-lives mechanic, "one away" nudge, and a Bauhaus-shape share grid.

## Design pillars

- **Playful, not mean.** Celebrates language; never punches down.
- **Educational by stealth.** Teaches etymology and register through play.
- **Daily, snackable, shareable.** One puzzle a day, 3–5 minutes.
- **Design-led.** Bauhaus aesthetic — primary colours, geometric shapes, confident typography.

## Content & filtering

Hard rule: plenty of rude, zero abuse. See the GDD's section 5 for the full editorial pipeline. Data sources: LDNOOBW, Surge-AI profanity list, Ofcom severity ratings, Green's Dictionary of Slang, OED/Etymonline. Every word passes through two reviewers before it ships.

## Palette

| Token | Hex | Role |
|---|---|---|
| Primary (red) | `#b7102a` | Hard category / brand accent |
| Tertiary (blue) | `#006482` | Medium category / headings |
| Secondary container (mustard) | `#ffd167` | Easy category / highlights |
| On-surface (near-black) | `#1b1b1b` | Trickiest category / body |
| Surface (off-white) | `#f9f9f9` | Background |

## Next steps

- Author the first 10 launch puzzles using the Dictionary's Puzzle Builder sheet.
- Port the prototype to Flutter for iOS/Android.
- Expand the dictionary (Shakespearean and Australian are still thin).
- Design the full onboarding flow and the "mild mode" toggle.

## License

TBD — see LICENSE when added.
