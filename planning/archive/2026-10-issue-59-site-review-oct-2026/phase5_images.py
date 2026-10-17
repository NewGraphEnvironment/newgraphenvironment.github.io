import os, sys
from PIL import Image
def flat(im):
    if im.mode in ("RGBA", "LA", "P"):
        im = im.convert("RGBA"); bg = Image.new("RGB", im.size, (255, 255, 255)); bg.paste(im, mask=im.split()[-1]); return bg
    return im.convert("RGB")
def save(im, out, q, sub=None, prog=True):
    kw = dict(quality=q, optimize=True, progressive=prog)
    if sub is not None: kw["subsampling"] = sub
    im.save(out, "JPEG", **kw); return os.path.getsize(out)
def fit(im, w):
    if im.size[0] <= w: return im
    return im.resize((w, round(im.size[1] * w / im.size[0])), Image.LANCZOS)
M = "content/project/aquatic_monitoring_assessment/"; R = "content/project/watershed_restoration_fish_passage/"; O = "content/project/open_source_software/"
jobs = [
  ("static/img/snowshoe.JPG", "static/img/snowshoe-1600.jpg", 1600, 70, 2),           # hero, dimmed to 40 %
  (M + "overview_zoomed_out.png", M + "overview_zoomed_out.jpg", 1600, 85, 0),          # map with text: 4:4:4
  (R + "map-lulc-subbasins.png", R + "map-lulc-subbasins.jpg", 1600, 85, 0),
  (M + "dunc_elevations.png", M + "dunc_elevations.jpg", 1080, 85, 0),
  (R + "featured.png", R + "featured.jpg", 891, 82, 2),                                  # hillshade tile
]
for src, out, w, q, sub in jobs:
    im = fit(flat(Image.open(src)), w); n = save(im, out, q, sub)
    print("%-62s %5dx%-5d %8d B  (was %d)" % (out, im.size[0], im.size[1], n, os.path.getsize(src)))
# 200 px square crop of the drone image for the landing-page node
im = flat(Image.open(O + "uav_cover.jpg")); w, h = im.size; s = min(w, h); im = im.crop(((w - s)//2, (h - s)//2, (w - s)//2 + s, (h - s)//2 + s)).resize((200, 200), Image.LANCZOS)
print("static/img/uav_node-200.jpg", save(im, "static/img/uav_node-200.jpg", 80, 2), "B")
