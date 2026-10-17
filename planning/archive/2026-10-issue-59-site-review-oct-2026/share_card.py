# Build the 1200x630 share card: the hero look (dimmed photo, forest overlay, white logo).
import sys
from PIL import Image, ImageEnhance
src, logo_path, out = sys.argv[1:4]
W, H = 1200, 630
im = Image.open(src).convert("RGB")
# centre-crop to 1200:630 at "center 40%" like the CSS background-position
w, h = im.size
target = W / H
if w / h > target:
    nw = int(h * target); x0 = (w - nw) // 2; box = (x0, 0, x0 + nw, h)
else:
    nh = int(w / target); y0 = int((h - nh) * 0.4); box = (0, y0, w, y0 + nh)
im = im.crop(box).resize((W, H), Image.LANCZOS)
im = ImageEnhance.Brightness(im).enhance(0.45)
im = ImageEnhance.Color(im).enhance(0.7)
overlay = Image.new("RGB", (W, H), (26, 46, 31))
im = Image.blend(im, overlay, 0.45)
logo = Image.open(logo_path).convert("RGBA")
lw = int(W * 0.42); lh = int(logo.size[1] * lw / logo.size[0])
logo = logo.resize((lw, lh), Image.LANCZOS)
im.paste(logo, ((W - lw) // 2, (H - lh) // 2), logo)
for q in (82, 78, 74, 70, 66):
    im.save(out, "JPEG", quality=q, optimize=True, progressive=True)
    import os
    if os.path.getsize(out) <= 150_000:
        break
print(out, os.path.getsize(out), "bytes, q", q)
