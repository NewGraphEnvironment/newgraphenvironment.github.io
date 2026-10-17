# Make the HUGO_RELATIVEURLS/UGLYURLS build work as a static file set on the artifact host.
import os, re, sys, glob
P = sys.argv[1]
def fix_href(m, pagedir):
    attr, url = m.group(1), m.group(2)
    if re.match(r'^(https?:|mailto:|#|data:)', url) or not url.endswith('/'):
        return m.group(0)
    rel = os.path.normpath(os.path.join(pagedir, url))
    rel = '' if rel == '.' else rel
    for cand in (rel + '.html' if rel else 'index.html', os.path.join(rel, 'index.html') if rel else 'index.html'):
        if os.path.isfile(os.path.join(P, cand)):
            new = os.path.relpath(os.path.join(P, cand), os.path.join(P, pagedir))
            return '%s="%s"' % (attr, new)
    return m.group(0)
n = 0
for html in glob.glob(P + '/**/*.html', recursive=True):
    pagedir = os.path.relpath(os.path.dirname(html), P); pagedir = '' if pagedir == '.' else pagedir
    t = open(html, encoding='utf-8').read(); t0 = t
    t = re.sub(r'(href|src)="([^"]+)"', lambda m: fix_href(m, pagedir), t)
    t = re.sub(r' integrity="[^"]*"', '', t)
    up = os.path.relpath(P, os.path.join(P, pagedir)); up = '' if up == '.' else up + '/'
    t = t.replace("url('/img/", "url('" + up + "img/")
    if t != t0: open(html, 'w', encoding='utf-8').write(t); n += 1
for css in glob.glob(P + '/style.main.min.*.css'):
    t = open(css, encoding='utf-8').read(); t2 = t.replace('url(/fonts/', 'url(fonts/').replace('url(/webfonts/', 'url(webfonts/')
    if t2 != t: open(css, 'w', encoding='utf-8').write(t2); n += 1
print('files rewritten:', n)
