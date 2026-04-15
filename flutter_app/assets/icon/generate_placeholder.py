"""Generate the VULGUS placeholder app icon.

Writes assets/icon/app_icon.png — 1024×1024 PNG.
Red Bauhaus background, off-white bold "V" centred, no rounding
(the Android launcher handles masking).

Re-run this script whenever you want to regenerate the placeholder.
Kat: replace app_icon.png with a proper design, then run
     `flutter pub run flutter_launcher_icons` to re-emit all densities.
"""
from pathlib import Path

from PIL import Image, ImageDraw, ImageFont

SIZE = 1024
BG = (0xB7, 0x10, 0x2A, 0xFF)
FG = (0xF9, 0xF9, 0xF9, 0xFF)

out = Path(__file__).parent / "app_icon.png"

img = Image.new("RGBA", (SIZE, SIZE), BG)
draw = ImageDraw.Draw(img)

candidates = [
    r"C:\Windows\Fonts\arialbd.ttf",
    r"C:\Windows\Fonts\segoeuib.ttf",
    r"C:\Windows\Fonts\arial.ttf",
]
font = None
for path in candidates:
    try:
        font = ImageFont.truetype(path, size=780)
        break
    except OSError:
        continue
if font is None:
    font = ImageFont.load_default()

text = "V"
bbox = draw.textbbox((0, 0), text, font=font)
tw = bbox[2] - bbox[0]
th = bbox[3] - bbox[1]
x = (SIZE - tw) // 2 - bbox[0]
y = (SIZE - th) // 2 - bbox[1]
draw.text((x, y), text, font=font, fill=FG)

img.save(out, format="PNG", optimize=True)
print(f"Wrote {out} ({img.size[0]}x{img.size[1]})")
