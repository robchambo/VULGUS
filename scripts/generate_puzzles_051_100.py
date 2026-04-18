#!/usr/bin/env python3
"""Generate VULGUS puzzle dart files 051-100.

Reads the dictionary JSON, validates hand-designed puzzle groupings,
and writes dart source files matching the existing pattern.
Re-runnable: overwrites targets each run.
"""

from __future__ import annotations
import argparse
import json, os, re, sys

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
JSON_PATH = os.path.join(REPO, 'dictionary', 'vulgus_lexicon.json')
DATA_DIR = os.path.join(REPO, 'flutter_app', 'lib', 'game', 'data')

# Puzzle definitions: (id, title, [(cat_id, label, letter, tiles, etymology_override?)])
# Letter controls colour + difficulty: Y easy, B medium, R hard, K trickiest.
# etymology_override: string to use, or None to pull from first tile's dict entry.
PUZZLES = [
    (51, 'Down Under', [
        ('oz-fools', 'Australian fools', 'Y',
         ['DILL', 'NONG', 'GALOOT', 'DROPKICK'],
         'Australian English insults for the dim — from herb names to rugby metaphors.'),
        ('oz-rogues', 'Australian rogues', 'B',
         ['BLUDGER', 'LARRIKIN', 'YOBBO', 'RATBAG'], None),
        ('oz-surprise', 'Surprise words', 'R',
         ['STREWTH', 'CRIKEY', 'GOOD GRIEF', 'HOLY TOLEDO'],
         'Exclamations of shock — Australian, British, American, and baseball-booth.'),
        ('oz-obscure', 'Deep-cut Australian', 'K',
         ['DAG', 'WOWSER', 'MONG', 'BOGAN'],
         'Deep-cut Australianisms: dried sheep dung, a killjoy, a dullard, and an uncultured suburbanite.'),
    ]),
    (52, 'Shakespeare\'s Insult Kit', [
        ('shakes-animal', 'Shakespeare\'s animal insults', 'Y',
         ['HEDGE-PIG', 'GUDGEON', 'SCUT', 'PUTTOCK'],
         'The Bard loved animal metaphors for contempt — hedgehogs, gullible fish, rabbit tails, and greedy kites.'),
        ('shakes-fool', 'Shakespeare\'s fools', 'B',
         ['CLOTPOLE', 'FUSTILUGS', 'CULLION', 'MOONCALF'],
         'Shakespearean insults for the dim and the coarse — thick-headed, fat, villainous, and moon-born.'),
        ('shakes-rogue', 'Shakespeare\'s rogues', 'R',
         ['JACKANAPES', 'LEWDSTER', 'STRUMPET', 'VIPER'],
         'Shakespeare\'s words for scoundrels, lechers, harlots, and venomous snakes.'),
        ('shakes-adj', 'Shakespeare\'s modifiers of contempt', 'K',
         ['PRIBBLING', 'CANKER', 'LOUT', 'POLTROON'],
         'Adjectives and epithets from the plays — petty, diseased, clumsy, and cowardly.'),
    ]),
    (53, 'Sailor Talk', [
        ('naut-insult', 'Nautical insults', 'Y',
         ['BILGE RAT', 'LANDLUBBER', 'SWAB', 'SCURVY'],
         'Pirate-era insults for the useless, the inexperienced, and the generally unwashed.'),
        ('naut-rogue', 'Nautical rogues', 'B',
         ['BUCCANEER', 'FREEBOOTER', 'SCALLYWAG', 'WRETCH'],
         'Words for sea-going scoundrels — from Caribbean meat-smokers to wretched deckhands.'),
        ('naut-action', 'Nautical punishments', 'R',
         ['KEELHAUL', 'BILGE', 'BARNACLE', 'SCUPPER'],
         'Things done to or found on the worst sailors — dragged under the keel, stuck in filth, or sunk.'),
        ('naut-cross', 'Also nautical (surprisingly)', 'K',
         ['PLONK', 'DRECK', 'GUFF', 'TRIPE'],
         'Words with unexpected naval or dockside connections — cheap wine, filth, hot air, and stomach lining.'),
    ]),
    (54, 'Victorian Villains', [
        ('vic-gent', 'Victorian gentlemen villains', 'Y',
         ['CAD', 'BOUNDER', 'ROTTER', 'BLIGHTER'],
         'The Victorian gentleman\'s vocabulary for a man who lets the side down.'),
        ('vic-street', 'Victorian street insults', 'B',
         ['GUTTERSNIPE', 'WASTREL', 'BLACKGUARD', 'COVE'],
         'Victorian words for the low, the idle, and the morally suspect.'),
        ('vic-coward', 'Words for coward', 'R',
         ['CRAVEN', 'POLTROON', 'RECREANT', 'DASTARD'],
         'Pre-Victorian words for cowardice — from Old French, Italian, and Anglo-Norman.'),
        ('vic-overlap', 'Also Victorian (surprisingly)', 'K',
         ['MOONCALF', 'HUMBUG', 'TOERAG', 'DOSSER'],
         'Victorian-era words that survived: a dreamer, a fraud, a tramp\'s foot-wrapping, and a rough sleeper.'),
    ]),
    (55, 'Celtic Thunder', [
        ('celtic-anger', 'Celtic anger words', 'Y',
         ['BANJAXED', 'GOWL', 'ROASTER', 'BLETHER'],
         'Irish and Scots words for being broken, being a fool, being ridiculous, and talking nonsense.'),
        ('celtic-scot', 'Scottish insults', 'B',
         ['NYAFF', 'TEUCHTER', 'BAWBAG', 'MINGER'],
         'Scottish English: an insignificant person, a rural yokel, anatomy, and an ugly one.'),
        ('celtic-irish', 'Irish rogues', 'R',
         ['GOMBEEN', 'GOBSHITE', 'EEJIT', 'FECKIN'],
         'Irish English: a moneylender, a loudmouth, an idiot, and the national minced oath.'),
        ('celtic-cross', 'Celtic crossovers', 'K',
         ['GOWK', 'BAMPOT', 'NUMPTY', 'NARK'],
         'Words shared across Celtic regions — a cuckoo/fool, a crazy person, a useless one, and a killjoy.'),
    ]),
    (56, 'Food Fight', [
        ('food-fruit', 'Fruity insults', 'Y',
         ['LEMON', 'BANANA', 'TURNIP', 'NOODLE'],
         'Calling someone a fruit or vegetable — implying they\'re useless, bonkers, thick, or soft in the head.'),
        ('food-nut', 'Nutty insults', 'B',
         ['NUTCASE', 'FRUITCAKE', 'CRUMPET', 'SAUSAGE'],
         'Food words repurposed to mean crazy, silly, attractive, or daft.'),
        ('food-brit', 'British food slang', 'R',
         ['PICKLE', 'PLONK', 'PORKY', 'TRIPE'],
         'British food words as insults or slang — in trouble, cheap wine, lies, and rubbish.'),
        ('food-hidden', 'Hidden food insults', 'K',
         ['GOOBER', 'PEANUT', 'CRUMBS', 'BALONEY'],
         'Words that are both foods and euphemisms — a fool, something small, biscuit bits, and sliced nonsense.'),
    ]),
    (57, 'Creature Feature', [
        ('animal-farm', 'Farmyard insults', 'Y',
         ['DONKEY', 'COW', 'PIG', 'TOAD'],
         'The barnyard provides endless contempt — stubborn, unpleasant, greedy, and revolting.'),
        ('animal-pest', 'Pest insults', 'B',
         ['WEASEL', 'RAT', 'SNAKE', 'VIPER'],
         'Small, unwanted creatures pressed into service as character assessments.'),
        ('animal-bird', 'Bird-based insults', 'R',
         ['DRONGO', 'GALAH', 'MAGPIE', 'GOWK'],
         'Avian insults — a slow racehorse-bird, a pink cockatoo, a chatterer, and a cuckoo.'),
        ('animal-hidden', 'Secretly animal-based', 'K',
         ['BERK', 'TURKEY', 'GUDGEON', 'PUTTOCK'],
         'Berk (Cockney: Berkeley Hunt), Turkey (a theatrical flop), Gudgeon (a gullible fish), Puttock (a greedy kite).'),
    ]),
    (58, 'Kiddie Cusses', [
        ('kid-poo', 'Playground poo words', 'Y',
         ['DOODOO', 'BOOGER', 'POOPYHEAD', 'STINKER'],
         'The schoolyard scatological lexicon — bodily functions as the height of wit.'),
        ('kid-mean', 'Playground meanies', 'B',
         ['MEANIE', 'BRATS', 'TWERP', 'NINNY'],
         'What children call each other — mean, badly behaved, small, and silly.'),
        ('kid-butt', 'Playground insults', 'R',
         ['BUTTHEAD', 'WEENIE', 'TATTLE', 'PICKLE'],
         'Slightly edgier playground words — anatomy, feebleness, telling tales, and being in trouble.'),
        ('kid-cross', 'Adult words kids stole', 'K',
         ['DORK', 'KOOK', 'BOOB', 'SAUSAGE'],
         'Words that crossed from adult slang into playground use — a fool, a weirdo, a mistake, and a silly sausage.'),
    ]),
    (59, 'Stage Fright', [
        ('theatre-perf', 'Theatrical performers', 'Y',
         ['HAM', 'LUVVIE', 'MUGGER', 'SCENERY CHEWER'],
         'Theatre insults for the over-actor — hamming it up, being precious, pulling faces, and eating the set.'),
        ('theatre-fail', 'Theatrical failures', 'B',
         ['FLOP', 'CORPSE', 'HACK', 'UPSTAGE'],
         'Things that go wrong on stage — a bomb, forgetting lines, lazy work, and stealing focus.'),
        ('theatre-cross', 'Theatrical crossovers', 'R',
         ['POLTROON', 'JACKANAPES', 'RAPSCALLION', 'KNAVE'],
         'Words equally at home in Shakespeare and in theatrical insult — cowards, ape-men, rascals, and rogues.'),
        ('theatre-hidden', 'Secretly theatrical', 'K',
         ['BIMBO', 'HAMPTON', 'RASPBERRY', 'BRAHMS'],
         'Cockney rhyming slang meets theatre — bimbo from Italian for baby, Hampton Wick, raspberry tart, Brahms and Liszt.'),
    ]),
    (60, 'Rhyming Slang', [
        ('cockney-easy', 'Cockney basics', 'Y',
         ['BARMY', 'DIPPY', 'NAFF', 'NUTTY'],
         'Cockney-adjacent British slang — off your head, silly, unfashionable, and crazy.'),
        ('cockney-body', 'Cockney body parts', 'B',
         ['HAMPTON', 'KHYBER', 'COBBLERS', 'PLATES'],
         'Cockney rhyming slang for anatomy: Hampton Wick, Khyber Pass, cobbler\'s awls, plates of meat.'),
        ('cockney-action', 'Cockney actions', 'R',
         ['RASPBERRY', 'BRAHMS', 'PORKY', 'PLONK'],
         'Raspberry tart (fart), Brahms and Liszt (drunk), porky pies (lies), plonk (cheap wine).'),
        ('cockney-cross', 'Secretly Cockney', 'K',
         ['BERK', 'NARK', 'BLOKE', 'GEEZER'],
         'Words most people don\'t realise are Cockney — Berkeley Hunt, copper\'s nark, bloke, and geezer.'),
    ]),
    (61, 'Medieval Mayhem', [
        ('med-villain', 'Medieval villains', 'Y',
         ['ROGUE', 'MISCREANT', 'CHURL', 'KNAVE'],
         'Medieval words for the dishonest, the faithless, the rude, and the rascal.'),
        ('med-coward', 'Medieval cowards', 'B',
         ['CAITIFF', 'CRAVEN', 'DASTARD', 'RECREANT'],
         'Old French-derived words for the spineless — captured, cowardly, base, and surrendered.'),
        ('med-insult', 'Medieval insults', 'R',
         ['CUR', 'WASTREL', 'VARLET', 'SCOUNDREL'],
         'Words for the low-born and the wicked — a mutt, a spendthrift, a servant-rogue, and a villain.'),
        ('med-shake', 'Medieval meets Shakespeare', 'K',
         ['CULLION', 'CANKER', 'JACKANAPES', 'PUTTOCK'],
         'Where medieval contempt meets the Bard — a base wretch, a disease, an ape, and a greedy kite.'),
    ]),
    (62, 'Scatological Studies', [
        ('scat-mild', 'Mild filth words', 'Y',
         ['CRAP', 'CRUD', 'GUFF', 'DRECK'],
         'The gentler end of the scatological spectrum — still rude, but grandma-adjacent.'),
        ('scat-food', 'Food-grade filth', 'B',
         ['TRIPE', 'DRIVEL', 'PIFFLE', 'GUBBINS'],
         'Words that bridge food waste and verbal waste — organ meat, dribble, trifle, and odds and ends.'),
        ('scat-nonsense', 'Scatological nonsense', 'R',
         ['TWADDLE', 'CODSWALLOP', 'HOGWASH', 'BILGE'],
         'Words for nonsense with surprisingly earthy etymologies.'),
        ('scat-hidden', 'Secretly scatological', 'K',
         ['CRAPPER', 'DOODOO', 'BOOGER', 'TOERAG'],
         'Thomas Crapper the plumber, baby talk, nasal excavation, and a tramp\'s foot-wrapping.'),
    ]),
    (63, 'Words for Stupid', [
        ('stupid-easy', 'Obviously stupid', 'Y',
         ['CLOD', 'CLOT', 'DUNCE', 'CHUMP'],
         'Blunt monosyllables for the dim — lumps of earth, lumps of blood, a schoolman, and a block.'),
        ('stupid-heavy', 'Heavy stupid', 'B',
         ['GALOOT', 'BOOR', 'OAFS', 'YOKEL'],
         'Words implying physical bulk or rural thickness matched by mental emptiness.'),
        ('stupid-food', 'Edibly stupid', 'R',
         ['NOODLE', 'TURNIP', 'LEMON', 'DILL'],
         'Foods that double as insults for the dim — limp, dense, a dud, and herb-brained.'),
        ('stupid-shakes', 'Shakespearean stupid', 'K',
         ['CLOTPOLE', 'MOONCALF', 'FUSTILUGS', 'GUDGEON'],
         'The Bard\'s fools — clot-headed, moon-born, fat and stale, and gullible as a fish.'),
    ]),
    (64, 'Lazy Bones', [
        ('lazy-brit', 'British laziness', 'Y',
         ['SLACKER', 'SKIVER', 'SHIRKER', 'DOSSER'],
         'British English has a rich vocabulary for avoiding work.'),
        ('lazy-work', 'Workplace wasters', 'B',
         ['JOBSWORTH', 'LAYABOUT', 'SPIV', 'WASTREL'],
         'The office, the street corner, and the black market — British words for the professionally idle.'),
        ('lazy-oz', 'Australian laziness', 'R',
         ['BLUDGER', 'LARRIKIN', 'YOBBO', 'DRONGO'],
         'Australian words for those who won\'t pull their weight — or pull anything at all.'),
        ('lazy-hidden', 'Secretly about laziness', 'K',
         ['PONCE', 'LOUT', 'YOKEL', 'CRASS'],
         'Words that conceal their lazy origins — a sponger, a stooping idler, a country bumpkin, and a crude bore.'),
    ]),
    (65, 'The -Head Crew', [
        ('head-classic', 'Classic -heads', 'Y',
         ['BONEHEAD', 'MEATHEAD', 'KNUCKLEHEAD', 'BUTTHEAD'],
         'The compound-head insult: your skull is made of bone, meat, knuckle, or worse.'),
        ('head-extended', 'Extended head family', 'B',
         ['CHUCKLEHEAD', 'LUNKHEAD', 'POOPYHEAD', 'CLOTPOLE'],
         'The -head suffix extended — laughing heads, heavy heads, childish heads, and Shakespearean clot-heads.'),
        ('head-hidden', 'Slang words for head', 'R',
         ['BONCE', 'NOODLE', 'TURNIP', 'LEMON'],
         'Slang words for the head itself — a marble, a noodle, a root vegetable, and a citrus dud.'),
        ('head-body', 'Other body-part compounds', 'K',
         ['GOBSHITE', 'TOERAG', 'RATBAG', 'BAWBAG'],
         'When -head isn\'t enough, try other anatomy — mouth, feet, rats, and below the belt.'),
    ]),
    (66, 'Minced Oaths II', [
        ('minced-god', 'Minced "God"', 'Y',
         ['GOLLY', 'GOSH', 'GOOD GRIEF', 'CRIPES'],
         'Euphemisms for invoking the Almighty — each a syllable or two away from blasphemy.'),
        ('minced-damn', 'Minced "damn"', 'B',
         ['DANG', 'DARN', 'DRAT', 'DAGNABBIT'],
         'The d-word family of avoidances — all circling "damn" without quite landing on it.'),
        ('minced-hell', 'Minced "hell"', 'R',
         ['HECK', 'HELLFIRE', 'TARNATION', 'CRIMINY'],
         'Hellish euphemisms — heck for hell, hellfire direct, and two that smuggle "damnation" in disguise.'),
        ('minced-jesus2', 'Minced "Jesus" (round 2)', 'K',
         ['JEEZ', 'JIMINY', 'JEEPERS', 'CHEESE AND RICE'],
         'From short clips to full phonetic rewrites — all ducking the second commandment.'),
    ]),
    (67, 'Proper Rotters', [
        ('rotter-easy', 'Easy rogues', 'Y',
         ['ROTTER', 'BLIGHTER', 'STINKER', 'WRETCH'],
         'Mild British words for a person who\'s let you down — rotting, blighting, stinking, and wretched.'),
        ('rotter-strong', 'Stronger rogues', 'B',
         ['BLACKGUARD', 'SCOUNDREL', 'MISCREANT', 'ROGUE'],
         'Victorian and medieval vocabulary for serious villainy.'),
        ('rotter-sneak', 'Sneaky rogues', 'R',
         ['SNAKE', 'VIPER', 'WEASEL', 'SPIV'],
         'Animal and underworld metaphors for the untrustworthy — slithering, venomous, sneaky, and dodgy.'),
        ('rotter-archaic', 'Archaic rogues', 'K',
         ['STRUMPET', 'LEWDSTER', 'MOUNTEBANK', 'RAPSCALLION'],
         'Archaic words for moral degenerates — a harlot, a lecher, a charlatan, and a rascal.'),
    ]),
    (68, 'Sounds Rude', [
        ('rude-sound', 'Rude-sounding words', 'Y',
         ['KNOB', 'TOSSER', 'TWATS', 'PRATS'],
         'Words that sound exactly as rude as they are — no euphemism needed.'),
        ('rude-mild', 'Milder than they sound', 'B',
         ['NITWIT', 'DIPSTICK', 'PLONKER', 'PILLOCK'],
         'They sound devastating but are technically quite mild — nit-picker, oil-checker, and regional fools.'),
        ('rude-surprise', 'Ruder than they sound', 'R',
         ['BERK', 'NAFF', 'COBBLERS', 'RASPBERRY'],
         'Innocent-sounding words with surprisingly vulgar Cockney origins.'),
        ('rude-ancient', 'Ancient rudeness', 'K',
         ['SCUT', 'CANKER', 'FUSTILUGS', 'PRIBBLING'],
         'Shakespearean and medieval words that sound perfectly innocent but meant something cutting.'),
    ]),
    (69, 'Work-Shy', [
        ('workshy-brit', 'British work-dodgers', 'Y',
         ['SKIVER', 'SHIRKER', 'LAYABOUT', 'SLACKER'],
         'Four ways to say someone avoids work — cutting, ducking, lying about, and being slack.'),
        ('workshy-posh', 'Posh idlers', 'B',
         ['CAD', 'BOUNDER', 'WASTREL', 'PLEB'],
         'Upper-class words for those who waste their privilege — or who never had any.'),
        ('workshy-aus', 'Antipodean work-dodgers', 'R',
         ['BLUDGER', 'DAG', 'WOWSER', 'NONG'],
         'Australian English for the idle, the daggy, the puritanical, and the thick.'),
        ('workshy-cockney', 'Cockney work-dodgers', 'K',
         ['DOSSER', 'PONCE', 'GIMP', 'GEEZER'],
         'London street slang for the homeless, the sponger, the lame, and the old man.'),
    ]),
    (70, 'Absolute Nonsense', [
        ('non-short', 'Short nonsense', 'Y',
         ['TOSH', 'GUFF', 'TRIPE', 'BILGE'],
         'One-syllable dismissals — each means your words are worth less than nothing.'),
        ('non-vic', 'Victorian nonsense', 'B',
         ['POPPYCOCK', 'BALDERDASH', 'HUMBUG', 'CLAPTRAP'],
         'The Victorian era produced the finest words for calling something rubbish.'),
        ('non-modern', 'Modern nonsense', 'R',
         ['DRIVEL', 'PIFFLE', 'GUBBINS', 'HOGWASH'],
         'More recent additions to the nonsense vocabulary — dribble, trifle, gadgets, and pig-water.'),
        ('non-us', 'American nonsense', 'K',
         ['MALARKEY', 'BALONEY', 'BUNKUM', 'FLAPDOODLE'],
         'American English\'s finest contributions to calling something a load of rubbish.'),
    ]),
    (71, 'Anatomy Lesson', [
        ('anat-brit', 'British anatomy', 'Y',
         ['ARSE', 'BUM', 'KNOB', 'BONCE'],
         'British English body-part slang — the rear, the bottom, the rounded bit, and the head.'),
        ('anat-cockney', 'Cockney anatomy', 'B',
         ['HAMPTON', 'KHYBER', 'COBBLERS', 'RASPBERRY'],
         'Cockney rhyming slang for anatomy and actions: Hampton Wick, Khyber Pass, cobbler\'s awls, raspberry tart.'),
        ('anat-insult', 'Anatomy-based insults', 'R',
         ['KNACKERS', 'BOLLOCKS', 'TOSSER', 'WANKER'],
         'When the insult IS the body part — or what you do with it.'),
        ('anat-hidden', 'Secretly anatomical', 'K',
         ['PILLOCK', 'SCHMUCK', 'PUTZ', 'DORK'],
         'Words that originally referred to anatomy before settling into "idiot" — all four trace to body parts.'),
    ]),
    (72, 'Lost in Translation', [
        ('yiddish2', 'Yiddish imports', 'Y',
         ['SCHMUCK', 'KLUTZ', 'PUTZ', 'NIMROD'],
         'Yiddish-origin American English — each word travelled from Eastern Europe to New York.'),
        ('french-loan', 'French-origin insults', 'B',
         ['POLTROON', 'MOUNTEBANK', 'RAPSCALLION', 'CRASS'],
         'Insults borrowed from French and Italian — cowards, charlatans, rascals, and the crude.'),
        ('celtic-loan', 'Celtic imports', 'R',
         ['GOMBEEN', 'NYAFF', 'TEUCHTER', 'BANJAXED'],
         'Irish and Scottish Gaelic words adopted into English — a usurer, a nobody, a rustic, and broken.'),
        ('oz-loan', 'Australian imports', 'K',
         ['DROPKICK', 'MONG', 'WOWSER', 'DAG'],
         'Australian slang that never quite made it to the rest of the world.'),
    ]),
    (73, 'Ruddy Hell', [
        ('mild-intensify', 'Mild intensifiers', 'Y',
         ['RUDDY', 'BLOOMING', 'FLIPPING', 'BLASTED'],
         'British substitute intensifiers — each standing in for something much stronger.'),
        ('strong-intensify', 'Strong intensifiers', 'B',
         ['BLOODY', 'DAMN', 'WICKED', 'FECKIN'],
         'The real thing — intensifiers that actually pack a punch.'),
        ('exclam-mild', 'Mild exclamations', 'R',
         ['CRUMBS', 'STREWTH', 'PHOOEY', 'SNIT'],
         'Exclamations of surprise from the gentler end of the spectrum.'),
        ('exclam-strong', 'Strong exclamations', 'K',
         ['HOLY TOLEDO', 'BEJESUS', 'SAKES', 'EGAD'],
         'When crumbs won\'t cut it — from American holy-somethings to archaic British oaths.'),
    ]),
    (74, 'Con Artists', [
        ('con-classic', 'Classic frauds', 'Y',
         ['MOUNTEBANK', 'SNOLLYGOSTER', 'SPIV', 'PONCE'],
         'Words for the professional deceiver — climbing on benches, politicking, dealing, and sponging.'),
        ('con-brit', 'British frauds', 'B',
         ['GOMBEEN', 'JOBSWORTH', 'NARK', 'CRASS'],
         'British and Irish words for the petty cheat — usurers, rule-followers, snitches, and the crude.'),
        ('con-arch', 'Archaic frauds', 'R',
         ['KNAVE', 'ROGUE', 'MISCREANT', 'CAITIFF'],
         'Medieval and early modern words for the wicked — from servant to outright villain.'),
        ('con-sneak', 'Sneaky animals', 'K',
         ['SNAKE', 'WEASEL', 'VIPER', 'MAGPIE'],
         'Animals pressed into service as metaphors for human deceit — slithering, stealing, and chattering.'),
    ]),
    (75, 'Thick as a Plank', [
        ('thick-brit', 'British thick words', 'Y',
         ['PLONKER', 'MUPPET', 'WALLY', 'TWIT'],
         'British English words for someone who is not the sharpest tool in the shed.'),
        ('thick-us', 'American thick words', 'B',
         ['DOOFUS', 'NIMROD', 'DINGBAT', 'CHUMP'],
         'American English equivalents — from 1960s slang to biblical inversions.'),
        ('thick-food2', 'Edibly thick', 'R',
         ['BANANA', 'LEMON', 'CRUMPET', 'NOODLE'],
         'Fruits, nuts, and baked goods — all meaning someone is soft in the head.'),
        ('thick-arch', 'Archaically thick', 'K',
         ['DUNCE', 'CLOD', 'CLOT', 'GUDGEON'],
         'Old words for the dim — a medieval scholar, a lump of earth, a blood clot, and a gullible fish.'),
    ]),
    (76, 'Pub Quiz', [
        ('pub-anatomy2', 'Pub body talk', 'Y',
         ['KNOB', 'PRATS', 'TWATS', 'BONCE'],
         'The coarser end of pub vocabulary — anatomy and the rounded bit on top.'),
        ('pub-mild', 'Pub mild insults', 'B',
         ['NITWIT', 'TWIT', 'TWERP', 'NINNY'],
         'The milder end of pub banter — fools, featherweights, and lightweights.'),
        ('pub-animal', 'Pub animal insults', 'R',
         ['DONKEY', 'TOAD', 'RAT', 'CUR'],
         'When pub insults go zoological — stubborn, slimy, sneaky, and mangy.'),
        ('pub-cockney2', 'Pub Cockney', 'K',
         ['BRAHMS', 'PORKY', 'NAFF', 'DIPPY'],
         'Cockney slang overheard at the bar — drunk, lying, unfashionable, and silly.'),
    ]),
    (77, 'Military Manoeuvres II', [
        ('mil-acro2', 'Military acronyms', 'Y',
         ['SNAFU', 'FUBAR', 'TARFU', 'CHARLIE FOXTROT'],
         'The military alphabet soup of disaster — each hiding profanity behind official-sounding letters.'),
        ('mil-insult2', 'Military insults', 'B',
         ['POGUE', 'SAD SACK', 'SHIRKER', 'SLACKER'],
         'What soldiers call those who avoid the fight — rear-echelon, pathetic, dodging, and slack.'),
        ('mil-chaos2', 'Military chaos words', 'R',
         ['GOAT ROPE', 'CLUSTER', 'BOHICA', 'BUSTED'],
         'Military words for an operation gone sideways — animal husbandry, munitions, bending over, and broken.'),
        ('mil-cross', 'Medieval military vocabulary', 'K',
         ['CRAVEN', 'DASTARD', 'CAITIFF', 'MISCREANT'],
         'Medieval military vocabulary for cowardice that crossed into civilian use.'),
    ]),
    (78, 'Double Meaning', [
        ('double-food', 'Food or insult?', 'Y',
         ['PICKLE', 'SAUSAGE', 'FRUITCAKE', 'NUTCASE'],
         'Words that could appear on a menu or in a rant — in trouble, silly, crazy, and certifiable.'),
        ('double-animal', 'Animal or insult?', 'B',
         ['TOAD', 'DONKEY', 'RAT', 'WEASEL'],
         'Zoo creatures that double as character assessments — ugly, stubborn, sneaky, and treacherous.'),
        ('double-theatre', 'Theatre or insult?', 'R',
         ['HAM', 'FLOP', 'CORPSE', 'UPSTAGE'],
         'Stage terminology that doubles as everyday contempt — overact, fail, freeze, and steal focus.'),
        ('double-hidden', 'Hidden doubles', 'K',
         ['CRUMPET', 'PLONK', 'LEMON', 'TURNIP'],
         'Innocent-sounding food words with a second life as insults — attractive, cheap, dud, and thick.'),
    ]),
    (79, 'Hissing Contempt', [
        ('hiss-s', 'S-words of contempt', 'Y',
         ['SNAKE', 'STINKER', 'SCOUNDREL', 'SHIRKER'],
         'Sibilant insults — the hissing S making each one sound extra contemptuous.'),
        ('hiss-sc', 'Sc-words of contempt', 'B',
         ['SCURVY', 'SCALLYWAG', 'SCUT', 'SCUPPER'],
         'The SC- opening adds a scraping, scratching quality to already unpleasant words.'),
        ('hiss-soft', 'Soft hissing', 'R',
         ['SWAB', 'SPIV', 'SKIVER', 'SNIT'],
         'Quieter sibilants — a mop, a black-marketeer, a dodger, and a sulk.'),
        ('hiss-hidden', 'Secret hissers', 'K',
         ['STRUMPET', 'SNOLLYGOSTER', 'SCHMUCK', 'SNAFU'],
         'The S-word hall of fame — a medieval harlot, a 19th C politician, a Yiddish anatomical term, and a military acronym.'),
    ]),
    (80, 'Grand Tour', [
        ('tour-brit', 'Best of British', 'Y',
         ['BLOODY', 'BLIMEY', 'MUPPET', 'BOLLOCKS'],
         'The essential British quartet — an intensifier, a surprise, a fool, and nonsense.'),
        ('tour-us', 'Best of American', 'B',
         ['DAGNABBIT', 'DOOFUS', 'MALARKEY', 'JACKASS'],
         'The essential American quartet — an oath, a fool, nonsense, and an animal insult.'),
        ('tour-oz', 'Best of Australian', 'R',
         ['DRONGO', 'BLUDGER', 'RATBAG', 'STREWTH'],
         'The essential Australian quartet — a fool, a layabout, a scoundrel, and an exclamation.'),
        ('tour-celtic2', 'Best of Celtic', 'K',
         ['EEJIT', 'BANJAXED', 'GOBSHITE', 'FECKIN'],
         'The essential Irish quartet — a fool, broken, a loudmouth, and the national intensifier.'),
    ]),
    (81, 'Bard\'s Best', [
        ('bard-insult', 'Shakespearean insults', 'Y',
         ['JACKANAPES', 'FUSTILUGS', 'LEWDSTER', 'CULLION'],
         'The Bard\'s choicest insults — an ape-man, a fat slob, a lecher, and a base wretch.'),
        ('bard-animal', 'Shakespearean animals', 'B',
         ['HEDGE-PIG', 'GUDGEON', 'PUTTOCK', 'VIPER'],
         'Shakespeare\'s bestiary of contempt — a hedgehog, a gullible fish, a greedy kite, and a venomous snake.'),
        ('bard-adj', 'Shakespearean modifiers', 'R',
         ['PRIBBLING', 'CANKER', 'LOUT', 'MOONCALF'],
         'Adjectives and nouns of Shakespearean scorn — petty, diseased, clumsy, and moon-born.'),
        ('bard-survive', 'Shakespeare\'s survivors', 'K',
         ['KNAVE', 'ROGUE', 'SCOUNDREL', 'VARLET'],
         'Shakespearean words that survived into modern English — we still call people these today.'),
    ]),
    (82, 'Potty Mouth', [
        ('potty-mild', 'Mild potty words', 'Y',
         ['CRAP', 'CRUD', 'DOODOO', 'DRECK'],
         'The softer end of scatological vocabulary — what you say when children are present.'),
        ('potty-strong', 'Strong potty words', 'B',
         ['CRAPPER', 'BOLLOCKS', 'TOSSER', 'KNACKERS'],
         'The stronger end — anatomy-adjacent and action-based.'),
        ('potty-nonsense', 'Potty-to-nonsense pipeline', 'R',
         ['TRIPE', 'GUBBINS', 'PIFFLE', 'TWADDLE'],
         'Words that bridged waste and worthlessness — from actual filth to metaphorical rubbish.'),
        ('potty-cross', 'Potty crossovers', 'K',
         ['GUFF', 'BILGE', 'TOSH', 'HOGWASH'],
         'Words that sound clean but have scatological or filthy origins.'),
    ]),
    (83, 'Aussie Rules', [
        ('aussie-fool', 'Aussie fools', 'Y',
         ['DILL', 'NONG', 'DRONGO', 'GALAH'],
         'Australian words for the dim — an herb, a nothing, a slow racehorse, and a pink cockatoo.'),
        ('aussie-rogue', 'Aussie rogues', 'B',
         ['RATBAG', 'LARRIKIN', 'DROPKICK', 'YOBBO'],
         'Australian words for troublemakers — scoundrels, hooligans, failures, and louts.'),
        ('aussie-adj', 'Aussie descriptors', 'R',
         ['BLUDGER', 'DAG', 'WOWSER', 'MONG'],
         'Australian descriptors — a freeloader, a daggy person, a killjoy, and a dullard.'),
        ('aussie-shared', 'Shared with Britain', 'K',
         ['GALOOT', 'PALOOKA', 'BOGAN', 'STREWTH'],
         'Words shared between Australian and British/American English — a clumsy oaf, a loser, an uncultured person, and an exclamation.'),
    ]),
    (84, 'Old Blighty', [
        ('blighty-mild', 'Mild British', 'Y',
         ['BLIMEY', 'CRIKEY', 'STREWTH', 'CRUMBS'],
         'The gentlest British exclamations — from "God blind me" to biscuit crumbs.'),
        ('blighty-mid', 'Mid-range British', 'B',
         ['PLONKER', 'PILLOCK', 'NITWIT', 'WALLY'],
         'Britain\'s favourite fools — a plonk, a pill, a nit-wit, and a wally.'),
        ('blighty-strong', 'Strong British', 'R',
         ['TOSSER', 'WANKER', 'MINGER', 'GOBSHITE'],
         'Britain at full volume — action-based, ugly, and loud.'),
        ('blighty-posh', 'Posh British', 'K',
         ['CAD', 'BOUNDER', 'BLACKGUARD', 'GUTTERSNIPE'],
         'The upper-class British insult — gentlemen villains and street urchins.'),
    ]),
    (85, 'Pirate\'s Life', [
        ('pirate-easy', 'Easy pirate words', 'Y',
         ['SCURVY', 'LANDLUBBER', 'SWAB', 'BARNACLE'],
         'The pirate basics — diseased, land-bound, mopping, and encrusted.'),
        ('pirate-rogue', 'Pirate rogues', 'B',
         ['BUCCANEER', 'FREEBOOTER', 'SCALLYWAG', 'RAPSCALLION'],
         'Words for sea-going scoundrels — from Caribbean meat-smokers to free-booting plunderers.'),
        ('pirate-punish', 'Pirate punishments', 'R',
         ['KEELHAUL', 'SCUPPER', 'BILGE', 'BILGE RAT'],
         'Things pirates did to each other — dragged under the hull, sunk, and bilge-dwelling.'),
        ('pirate-cross', 'Pirate crossovers', 'K',
         ['CUR', 'WRETCH', 'WEASEL', 'RAT'],
         'Animal insults equally at home at sea or on land — strays, wretches, sneaks, and vermin.'),
    ]),
    (86, 'The Insult Alphabet', [
        ('alpha-b', 'B insults', 'Y',
         ['BIMBO', 'BOOB', 'BOOR', 'BRATS'],
         'The letter B brings the blunt force — beauty without brains, a mistake, a lout, and bad children.'),
        ('alpha-c', 'C insults', 'B',
         ['CHURL', 'CLOD', 'CUR', 'CLOT'],
         'The letter C cuts — a rude peasant, a lump, a mongrel, and a blood clot.'),
        ('alpha-d', 'D insults', 'R',
         ['DASTARD', 'DUNCE', 'DIPPY', 'DOSSER'],
         'The letter D delivers — a cowardly villain, a scholar turned fool, a silly one, and a rough sleeper.'),
        ('alpha-g', 'G insults', 'K',
         ['GUTTERSNIPE', 'GOWL', 'GOWK', 'GIMP'],
         'The letter G gets grim — a street urchin, a Celtic howler, a cuckoo fool, and a lame one.'),
    ]),
    (87, 'Sounds Like Swearing', [
        ('sounds-brit', 'Sounds British-sweary', 'Y',
         ['RUDDY', 'BLOOMING', 'BLASTED', 'CRIKEY'],
         'Intensifiers and exclamations that sound like swearing but technically aren\'t.'),
        ('sounds-us', 'Sounds American-sweary', 'B',
         ['SHOOT', 'FUDGE', 'SUGAR', 'HECK'],
         'American phonetic stand-ins — shoot for sh*t, fudge for f**k, and so on.'),
        ('sounds-arch', 'Sounds archaic-sweary', 'R',
         ['ZOUNDS', 'GADZOOKS', 'CONSARN', 'SAKES'],
         'Archaic words that were once genuine blasphemy — God\'s wounds, God\'s hooks, and consarnit.'),
        ('sounds-celtic2', 'Sounds Celtic-sweary', 'K',
         ['FECKIN', 'BANJAXED', 'BAWBAG', 'GOWL'],
         'Celtic words that sound much worse than their dictionary definitions might suggest.'),
    ]),
    (88, 'Mixed Metaphors', [
        ('meta-animal', 'Animal metaphors', 'Y',
         ['DONKEY', 'TOAD', 'MAGPIE', 'CUR'],
         'Animals as character types — stubborn, repulsive, chattering, and mangy.'),
        ('meta-food', 'Food metaphors', 'B',
         ['FRUITCAKE', 'SAUSAGE', 'PICKLE', 'BANANA'],
         'Food as personality types — crazy, silly, in trouble, and bonkers.'),
        ('meta-body2', 'Body metaphors', 'R',
         ['BONEHEAD', 'LUNKHEAD', 'MEATHEAD', 'BUTTHEAD'],
         'The head made of something other than brain — bone, lunk, meat, and butt.'),
        ('meta-nature', 'Shakespearean nature', 'K',
         ['CANKER', 'HEDGE-PIG', 'MOONCALF', 'PUTTOCK'],
         'Shakespearean nature metaphors for human failing — disease, prickly, lunar, and a greedy kite.'),
    ]),
    (89, 'Rogue\'s Gallery II', [
        ('rogue-easy2', 'Loveable rogues', 'Y',
         ['RAPSCALLION', 'SCALLYWAG', 'ROGUE', 'LARRIKIN'],
         'The kind of rogues you\'d cast in a heist movie — rascals with charm.'),
        ('rogue-dark', 'Dark rogues', 'B',
         ['BLACKGUARD', 'MISCREANT', 'CAITIFF', 'DASTARD'],
         'Rogues with no redeeming qualities — black-hearted, faithless, wretched, and cowardly.'),
        ('rogue-sea', 'Sea rogues', 'R',
         ['BUCCANEER', 'FREEBOOTER', 'WRETCH', 'SWAB'],
         'Rogues of the high seas — meat-smokers, plunderers, wretches, and swabs.'),
        ('rogue-celtic2', 'Celtic rogues', 'K',
         ['ROASTER', 'GOMBEEN', 'BLETHER', 'NYAFF'],
         'Celtic words for people you\'d cross the street to avoid — a fool, a usurer, a babbler, and a nobody.'),
    ]),
    (90, 'Proper Nouns in Disguise', [
        ('propn-people', 'Named after people', 'Y',
         ['DUNCE', 'NIMROD', 'CRAPPER', 'YAHOO'],
         'Duns Scotus, the biblical hunter, Thomas Crapper, and Swift\'s savages — real names turned insults.'),
        ('propn-places', 'Named after places', 'B',
         ['BUNKUM', 'COCKAMAMIE', 'BOHICA', 'CATTYWAMPUS'],
         'Buncombe County NC, Decalcomania, military acronym, and frontier crooked — all place-adjacent.'),
        ('propn-char', 'Named after characters', 'R',
         ['POLTROON', 'JACKANAPES', 'MUPPET', 'GEEZER'],
         'Italian couch potatoes, Jack Napes the monkey, Jim Henson\'s felt, and a Cockney disguise.'),
        ('propn-eponym', 'Eponymous insults', 'K',
         ['SNOLLYGOSTER', 'MOUNTEBANK', 'BERK', 'STRUMPET'],
         'Words that trace to specific origins — a 19th C politician, a bench-climber, Berkeley Hunt, and a medieval harlot.'),
    ]),
    (91, 'Softer Side', [
        ('soft-brit', 'Soft British', 'Y',
         ['CRIKEY', 'CRUMBS', 'BLOOMING', 'RUDDY'],
         'British words safe for daytime television — surprise and mild intensification.'),
        ('soft-us2', 'Soft American', 'B',
         ['SHUCKS', 'PHOOEY', 'GOSH', 'DARN'],
         'American words safe for grandma — gentle surprise and mild disappointment.'),
        ('soft-phrase', 'Soft phrases', 'R',
         ['GOOD GRIEF', 'HOLY MOLY', 'MERCY ME', 'FOR PETE\'S SAKE'],
         'Full phrases that sound like they\'re about to swear but never do.'),
        ('soft-minced', 'Softest minced oaths', 'K',
         ['GEE', 'HECK', 'RATS', 'SHOOT'],
         'The absolute softest — each barely a whisper of the word it\'s standing in for.'),
    ]),
    (92, 'Cross-Cultural Fools', [
        ('cc-brit2', 'British fools', 'Y',
         ['WALLY', 'MUPPET', 'PLONKER', 'NITWIT'],
         'The British fool hall of fame — each affectionate enough to use on friends.'),
        ('cc-us2', 'American fools', 'B',
         ['DOOFUS', 'KLUTZ', 'GOOBER', 'DWEEB'],
         'American fool vocabulary — the clumsy, the nutty, the nerdy, and the weedy.'),
        ('cc-celtic3', 'Celtic fools', 'R',
         ['EEJIT', 'NUMPTY', 'BAMPOT', 'GOWK'],
         'Celtic fool vocabulary — the Irish idiot, the Scottish useless, the crazy, and the cuckoo.'),
        ('cc-oz2', 'Australian fools', 'K',
         ['GALAH', 'DRONGO', 'DILL', 'GALOOT'],
         'Australian fool vocabulary — a cockatoo, a slow horse, an herb, and a clumsy oaf.'),
    ]),
    (93, 'Verbal Venom', [
        ('venom-mild', 'Mild venom', 'Y',
         ['STINKER', 'ROTTER', 'BLIGHTER', 'TOERAG'],
         'The mildest poison — you\'re rotten, blighted, stinking, and foot-wrapping.'),
        ('venom-strong', 'Strong venom', 'B',
         ['TOSSER', 'MINGER', 'TWATS', 'PRATS'],
         'British strong venom — action-based, appearance-based, and anatomical.'),
        ('venom-ancient', 'Ancient venom', 'R',
         ['BLACKGUARD', 'CAITIFF', 'CULLION', 'CHURL'],
         'Medieval poison — the black guard, the captive wretch, the base knave, and the rude peasant.'),
        ('venom-celtic2', 'Celtic venom', 'K',
         ['BAWBAG', 'GOWL', 'ROASTER', 'TEUCHTER'],
         'Celtic poison — Scottish anatomy, Irish howling, being made a fool of, and Highland snobbery.'),
    ]),
    (94, 'The Full English', [
        ('fe-breakfast', 'Breakfast insults', 'Y',
         ['SAUSAGE', 'CRUMPET', 'BANANA', 'LEMON'],
         'Foods you might find at breakfast that are also insults — silly, attractive, bonkers, and a dud.'),
        ('fe-mild', 'Full English mild', 'B',
         ['CRIKEY', 'BLIMEY', 'STREWTH', 'GOOD GRIEF'],
         'Exclamations over the morning newspaper — surprise, shock, and mild disbelief.'),
        ('fe-insult', 'Full English insults', 'R',
         ['PLEB', 'LOUT', 'YOKEL', 'OAFS'],
         'Words for the uncultured — commoners, boors, country folk, and clumsy lumps.'),
        ('fe-strong', 'Full English strong', 'K',
         ['BLOODY', 'BUGGER', 'WANKER', 'BOLLOCKS'],
         'What actually gets said over the Full English — the four horsemen of British swearing.'),
    ]),
    (95, 'Workplace Woes', [
        ('work-lazy', 'Workplace layabouts', 'Y',
         ['SKIVER', 'SHIRKER', 'SLACKER', 'HACK'],
         'Four ways to describe the colleague who coasts — cutting corners, ducking, and hacking it.'),
        ('work-petty', 'Workplace petty tyrants', 'B',
         ['JOBSWORTH', 'NARK', 'GRIPE', 'SNIT'],
         'The office killjoy, the tattler, the complainer, and the sulker.'),
        ('work-strong', 'What you call them privately', 'R',
         ['TOSSER', 'PLONKER', 'MUPPET', 'TWIT'],
         'What British workers actually call difficult colleagues — behind their backs.'),
        ('work-celtic3', 'Celtic workplace', 'K',
         ['NYAFF', 'BLETHER', 'ROASTER', 'GOWL'],
         'Celtic words for the colleague who talks too much, achieves too little, and howls about it.'),
    ]),
    (96, 'Desperately Seeking Synonyms', [
        ('syn-fool', 'Synonyms for fool', 'Y',
         ['NITWIT', 'NINNY', 'TWERP', 'DUNCE'],
         'Four ways to say fool — no wit, a baby, a small thing, and a medieval scholar.'),
        ('syn-rogue2', 'Synonyms for rogue', 'B',
         ['RAPSCALLION', 'SCALLYWAG', 'KNAVE', 'VARLET'],
         'Four progressively more archaic words for the same loveable rogue.'),
        ('syn-nonsense', 'Synonyms for nonsense', 'R',
         ['HOGWASH', 'CODSWALLOP', 'POPPYCOCK', 'BALDERDASH'],
         'Four Victorian-adjacent words meaning exactly the same thing — your words are rubbish.'),
        ('syn-coward2', 'Synonyms for coward', 'K',
         ['CRAVEN', 'POLTROON', 'RECREANT', 'CAITIFF'],
         'Four medieval French-origin words for the spineless — each more obscure than the last.'),
    ]),
    (97, 'Across the Pond', [
        ('pond-brit', 'British side', 'Y',
         ['BLOKE', 'PLONKER', 'NAFF', 'MINGER'],
         'Words Americans don\'t use — a man, a fool, unfashionable, and ugly.'),
        ('pond-us', 'American side', 'B',
         ['DOOFUS', 'DINGBAT', 'KOOK', 'WEENIE'],
         'Words Brits don\'t use — a fool, a scatterbrain, a weirdo, and a weakling.'),
        ('pond-shared', 'Shared across the pond', 'R',
         ['JACKASS', 'CRAP', 'DAMN', 'HECK'],
         'Words both nations agree on — a donkey-person, waste, condemnation, and its softened form.'),
        ('pond-confused', 'Means different things', 'K',
         ['KNOB', 'TOSSER', 'BERK', 'PLEB'],
         'Words that cause transatlantic confusion — anatomy vs handle, action vs unknown, and Cockney secrets.'),
    ]),
    (98, 'Historical Layers', [
        ('hist-medieval', 'Medieval layer', 'Y',
         ['KNAVE', 'CHURL', 'ROGUE', 'VARLET'],
         'The oldest layer of English insults — servants, peasants, and scoundrels.'),
        ('hist-victorian', 'Victorian layer', 'B',
         ['BOUNDER', 'ROTTER', 'CAD', 'COVE'],
         'The Victorian gentleman\'s insult vocabulary — each implying a failure of breeding or character.'),
        ('hist-modern', 'Modern layer', 'R',
         ['MUPPET', 'PLONKER', 'WALLY', 'NUMPTY'],
         'Late 20th century British additions — TV puppets, wine bottles, and Scottish uselessness.'),
        ('hist-future', 'Internet layer', 'K',
         ['JANKY', 'SALTY', 'SHOOK', 'TRIPPIN'],
         'The newest layer — 21st century slang for broken, bitter, shocked, and overreacting.'),
    ]),
    (99, 'Last Orders', [
        ('last-best', 'All-time best insults', 'Y',
         ['MUPPET', 'NUMPTY', 'EEJIT', 'DRONGO'],
         'The Mount Rushmore of English-language fool-words — British, Scottish, Irish, and Australian.'),
        ('last-strong', 'All-time strongest', 'B',
         ['WANKER', 'GOBSHITE', 'BOLLOCKS', 'BLOODY'],
         'The heavy artillery — British swearing at its most concentrated.'),
        ('last-arch', 'All-time best archaic', 'R',
         ['ZOUNDS', 'FUSTILUGS', 'SNOLLYGOSTER', 'CATTYWAMPUS'],
         'The words that deserve resurrection — God\'s wounds, a fat slob, a 19th C conman, and crooked.'),
        ('last-mild', 'All-time mildest', 'K',
         ['DRAT', 'SHUCKS', 'GEE', 'CRUMBS'],
         'So mild they barely register — but each one is technically a minced oath.'),
    ]),
    (100, 'Grand Finale III', [
        ('gf-brit', 'British hall of fame', 'Y',
         ['BLOODY', 'BOLLOCKS', 'MUPPET', 'CRIKEY'],
         'The four pillars of British expression — an intensifier, nonsense, a fool, and surprise.'),
        ('gf-world', 'World hall of fame', 'B',
         ['EEJIT', 'DRONGO', 'SCHMUCK', 'DOOFUS'],
         'A fool from every corner — Irish, Australian, Yiddish, and American.'),
        ('gf-arch', 'Archaic hall of fame', 'R',
         ['ZOUNDS', 'BALDERDASH', 'JACKANAPES', 'POLTROON'],
         'The archaics that deserve to live forever — an oath, nonsense, an ape-man, and a coward.'),
        ('gf-new', 'New additions hall of fame', 'K',
         ['FUSTILUGS', 'BANJAXED', 'KEELHAUL', 'GUTTERSNIPE'],
         'The best words from the expanded dictionary — a fat slob, broken, dragged under the hull, and a street urchin.'),
    ]),
]

LETTER_TO_COLOUR = {
    'Y': ('AppColors.secondaryContainer', 'Difficulty.easy'),
    'B': ('AppColors.tertiary', 'Difficulty.medium'),
    'R': ('AppColors.primary', 'Difficulty.hard'),
    'K': ('AppColors.onSurface', 'Difficulty.trickiest'),
}


def _read_json(path):
    with open(path, encoding='utf-8') as f:
        data = json.load(f)
    words_by_key = {}
    valid_words = set()
    for w in data['words']:
        word = w['word'].strip()
        if not word:
            continue
        ship = (w.get('ship') or '').upper()
        if ship not in ('YES', 'MAYBE'):
            continue
        key = word.lower()
        words_by_key[key] = w
        valid_words.add(word.upper())
    return words_by_key, valid_words


def _existing_groups():
    groups = set()
    for i in range(1, 51):
        p = os.path.join(DATA_DIR, f'vulgus_{i:03d}.dart')
        if not os.path.exists(p):
            continue
        body = open(p, encoding='utf-8').read()
        for m in re.findall(r'tiles:\s*\[(.*?)\]', body, re.DOTALL):
            t = tuple(sorted(re.findall(r"'([^']+)'", m)))
            if len(t) == 4:
                groups.add(t)
    return groups


def _escape_dart(s: str) -> str:
    return s.replace('\\', '\\\\').replace("'", "\\'").replace('$', '\\$')


def _render_category(cat_id, label, letter, tiles, etymology):
    colour, diff = LETTER_TO_COLOUR[letter]
    tile_list = ', '.join(f"'{_escape_dart(t)}'" for t in tiles)
    return (
        "    PuzzleCategory(\n"
        f"      id: '{cat_id}',\n"
        f"      label: '{_escape_dart(label)}',\n"
        f"      etymology: '{_escape_dart(etymology)}',\n"
        f"      color: {colour},\n"
        f"      difficulty: {diff},\n"
        f"      tiles: [{tile_list}],\n"
        "    ),\n"
    )


def _render_puzzle(n, title, categories, words_by_dict):
    lines = [
        "import '../models/difficulty.dart';\n",
        "import '../models/puzzle.dart';\n",
        "import '../models/puzzle_category.dart';\n",
        "import '../../theme/app_colors.dart';\n",
        "\n",
        f"// {title}\n",
        f"const vulgus{n:03d} = Puzzle(\n",
        f"  id: 'VULGUS-{n:03d}',\n",
        "  categories: [\n",
    ]
    for cat_id, label, letter, tiles, etym_override in categories:
        etym = etym_override
        if etym is None:
            # Pull from first tile's dictionary entry
            first = tiles[0].lower()
            entry = words_by_dict.get(first, {})
            etym = entry.get('etymology_note', '') or \
                   f'Part of the {label.lower()} group.'
        lines.append(_render_category(cat_id, label, letter, tiles, etym))
    lines.append("  ],\n);\n")
    return ''.join(lines)


def _render_library():
    out = ["import '../models/puzzle.dart';\n"]
    for i in range(1, 101):
        out.append(f"import 'vulgus_{i:03d}.dart';\n")
    out.append('\n')
    out.append('const List<Puzzle> puzzleLibrary = [\n')
    for i in range(1, 101):
        out.append(f'  vulgus{i:03d},\n')
    out.append('];\n')
    return ''.join(out)


def main():
    words_by_dict, valid_words = _read_json(JSON_PATH)
    existing = _existing_groups()
    print(f"Loaded {len(valid_words)} valid words, {len(existing)} existing groups.")

    errors = []
    new_groups = set()
    for (n, title, cats) in PUZZLES:
        seen_in_puzzle = set()
        for (cat_id, label, letter, tiles, _etym) in cats:
            if len(tiles) != 4:
                errors.append(f"puzzle {n} category {cat_id}: need 4 tiles, got {len(tiles)}")
            group = tuple(sorted(tiles))
            if group in existing:
                errors.append(f"puzzle {n} category {cat_id}: group collides with existing 001-050: {list(group)}")
            if group in new_groups:
                errors.append(f"puzzle {n} category {cat_id}: group collides with another new puzzle: {list(group)}")
            new_groups.add(group)
            for t in tiles:
                up = t.upper()
                if up not in valid_words:
                    errors.append(f"puzzle {n} category {cat_id}: tile {t!r} not in dictionary")
                if up in seen_in_puzzle:
                    errors.append(f"puzzle {n}: duplicate tile within puzzle: {up}")
                seen_in_puzzle.add(up)

    if errors:
        print("VALIDATION FAILED:")
        for e in errors:
            print(f"  - {e}")
        sys.exit(1)

    # Write puzzle files
    for (n, title, cats) in PUZZLES:
        dart = _render_puzzle(n, title, cats, words_by_dict)
        path = os.path.join(DATA_DIR, f'vulgus_{n:03d}.dart')
        with open(path, 'w', encoding='utf-8') as f:
            f.write(dart)

    # Write library
    lib = _render_library()
    with open(os.path.join(DATA_DIR, 'puzzle_library.dart'), 'w', encoding='utf-8') as f:
        f.write(lib)

    print(f"OK: wrote {len(PUZZLES)} puzzles, 0 collisions, {len(PUZZLES)}/{len(PUZZLES)} passed validation.")

    parser = argparse.ArgumentParser()
    parser.add_argument('--reuse-budget', type=int, default=None)
    args = parser.parse_args()

    if args.reuse_budget:
        counts = _count_word_usage(PUZZLES, DATA_DIR, range(1, 101))
        over = {w: c for w, c in counts.items() if c >= args.reuse_budget}
        if over:
            print(f"\nREUSE WARNING (budget={args.reuse_budget}):")
            for w, c in sorted(over.items(), key=lambda x: -x[1]):
                print(f"  {w}: {c} uses")
        else:
            print(f"\nAll words within reuse budget of {args.reuse_budget}.")


def _count_word_usage(puzzles_list, existing_dart_dir, existing_range):
    """Count per-word usage across existing dart files + new puzzles."""
    counts = {}
    # Count from existing dart files
    for i in existing_range:
        p = os.path.join(existing_dart_dir, f'vulgus_{i:03d}.dart')
        if not os.path.exists(p):
            continue
        body = open(p, encoding='utf-8').read()
        for m in re.findall(r"tiles:\s*\[(.*?)\]", body, re.DOTALL):
            for w in re.findall(r"'([^']+)'", m):
                counts[w] = counts.get(w, 0) + 1
    # Count from new puzzles
    for (n, title, cats) in puzzles_list:
        for (cat_id, label, letter, tiles, _) in cats:
            for w in tiles:
                counts[w] = counts.get(w, 0) + 1
    return counts


if __name__ == '__main__':
    main()
