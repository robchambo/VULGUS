class Etymology {
  final String meta;
  final String note;
  const Etymology({required this.meta, required this.note});
}

const etymologies = <String, Etymology>{
  'NIMROD':     Etymology(meta: 'eponymous · Bugs Bunny',   note: 'Biblical mighty hunter — inverted to mean "fool" after Bugs Bunny sarcastically called Elmer Fudd a Nimrod.'),
  'DOOFUS':     Etymology(meta: 'US · 1960s',               note: 'US college slang of uncertain origin; a harmless, lovable fool.'),
  'MUPPET':     Etymology(meta: 'UK · 1980s',               note: "From Jim Henson's Muppets; adopted as a gentle British insult meaning clueless person."),
  'WALLY':      Etymology(meta: 'UK · 1960s',               note: '1960s British slang for a fool; possibly from the name Walter, or a cry heard at a 1965 festival.'),
  'SUGAR':      Etymology(meta: 'global · 20th C',          note: 'Polite stand-in for a stronger s-word; popularised as a minced oath in the early 1900s.'),
  'FUDGE':      Etymology(meta: 'global · 17th C',          note: 'Originally "to fake or bungle"; euphemism for the f-word by the 19th century.'),
  'SHOOT':      Etymology(meta: 'US · 19th C',              note: 'American minced oath for a stronger s-word; in use since the mid-1800s.'),
  'CRIKEY':     Etymology(meta: 'UK/AU · 19th C',           note: 'Minced oath for "Christ"; popular in Britain and Australia since the 1830s.'),
  'BOLLOCKS':   Etymology(meta: 'UK · Old English',         note: 'From Old English beallucas (testicles); by the 1860s meant "nonsense". Sex Pistols made it famous in 1977.'),
  'ARSE':       Etymology(meta: 'UK · Old English',         note: 'From Old English ærs, cognate with German Arsch. Standard British form of American "ass".'),
  'BUM':        Etymology(meta: 'UK · 14th C',              note: "Middle English, probably onomatopoeic. A mild British anatomical word, common in children's speech."),
  'BLIMEY':     Etymology(meta: 'UK · 19th C',              note: '"God blind me!" — a minced oath used as an exclamation of surprise.'),
  'TOSH':       Etymology(meta: 'UK · 19th C',              note: 'British slang for rubbish; origin disputed. Often paired with "utter".'),
  'CODSWALLOP': Etymology(meta: 'UK · 20th C',              note: "Possibly from Hiram Codd's 1872 bottle plus \"wallop\" (beer) — worthless fizzy water, hence nonsense."),
  'POPPYCOCK':  Etymology(meta: 'US · 19th C',              note: 'From Dutch pappekak — "soft dung". Sounds polite; originally was anything but.'),
  'BALDERDASH': Etymology(meta: '16th C',                   note: 'Originally a 16th-century frothy drink mix; by the 1670s it meant senseless talk.'),
  // Mini-puzzle demo words (onboarding)
  'GOSH':       Etymology(meta: 'global · 18th C',          note: 'Minced oath for "God" — polite substitute used since the 1750s to avoid taking the Lord\'s name in vain.'),
  'HECK':       Etymology(meta: 'UK · 19th C',              note: 'Minced oath for "hell" — Scottish/northern English softening that went global via the 19th-century working class.'),
  'KNACKERED':  Etymology(meta: 'UK · 19th C',              note: 'From "knacker" (horse slaughterer); something knackered is fit only for the knacker\'s yard.'),
  'NAFF':       Etymology(meta: 'UK · 1960s',               note: 'British slang for tacky or uncool. Popularised by Polari gay slang and cemented by Princess Anne.'),
  'GOBSMACKED': Etymology(meta: 'UK · 1980s',               note: 'Literally smacked in the gob (mouth) — a 1980s northern English coinage for utter astonishment.'),
};
