import re, os, sys
root = sys.argv[1]
pages = ["index.html", "project/index.html", "project/watershed_restoration_fish_passage/index.html", "project/aquatic_monitoring_assessment/index.html", "project/open_source_software/index.html", "contact/index.html"]
for pg in pages:
    html = open(os.path.join(root, pg), encoding="utf-8").read()
    refs = set(re.findall(r'(?:src|href)="([^"]+\.(?:css|js|png|jpe?g|svg|ico|woff2?))"', html)) | set(re.findall(r"url\('([^']+)'\)", html))
    total = os.path.getsize(os.path.join(root, pg)); n = 1
    for r in refs:
        if r.startswith("http"): continue
        path = os.path.join(root, r.lstrip("/")) if r.startswith("/") else os.path.join(root, os.path.dirname(pg), r)
        if os.path.isfile(path): total += os.path.getsize(path); n += 1
    print("%-58s %7.0f KB  %2d files" % ("/" + pg.replace("index.html", ""), total / 1024, n))
