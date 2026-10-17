// Phone (390x844, mobile emulation, 2x) and desktop (1440x900) measurements and
// screenshots of the built site over the Chrome DevTools protocol.
// usage: node cdp_check.cjs <outdir> [base-url]
const { spawn } = require('child_process');
const fs = require('fs');
const CH = '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome';
const PORT = 9333;
const OUTDIR = process.argv[2];
const BASE = process.argv[3] || 'http://127.0.0.1:8477';
fs.mkdirSync(OUTDIR, { recursive: true });
const chrome = spawn(CH, ['--headless=new', '--disable-gpu', '--hide-scrollbars', `--remote-debugging-port=${PORT}`,
  `--user-data-dir=${OUTDIR}/profile`, 'about:blank'], { stdio: 'ignore' });
const sleep = ms => new Promise(r => setTimeout(r, ms));
async function wsUrl() {
  for (let i = 0; i < 60; i++) {
    try { const r = await fetch(`http://127.0.0.1:${PORT}/json/version`); return (await r.json()).webSocketDebuggerUrl; }
    catch (e) { await sleep(250); }
  }
  throw new Error('chrome did not come up');
}
(async () => {
  const ws = new WebSocket(await wsUrl());
  await new Promise(r => (ws.onopen = r));
  let id = 0; const pending = new Map(); const listeners = [];
  ws.onmessage = ev => {
    const m = JSON.parse(ev.data);
    if (m.id && pending.has(m.id)) { const { res, rej } = pending.get(m.id); pending.delete(m.id); m.error ? rej(new Error(JSON.stringify(m.error))) : res(m.result); }
    else if (m.method) listeners.slice().forEach(l => l(m));
  };
  const send = (method, params = {}, sessionId) => new Promise((res, rej) => { const i = ++id; pending.set(i, { res, rej }); ws.send(JSON.stringify({ id: i, method, params, sessionId })); });
  const waitEvent = (method, sessionId) => new Promise(res => { const l = m => { if (m.method === method && m.sessionId === sessionId) { listeners.splice(listeners.indexOf(l), 1); res(m.params); } }; listeners.push(l); });
  const { targetId } = await send('Target.createTarget', { url: 'about:blank' });
  const { sessionId } = await send('Target.attachToTarget', { targetId, flatten: true });
  await send('Page.enable', {}, sessionId); await send('Runtime.enable', {}, sessionId);
  const pages = [['/', 'home'], ['/project/', 'work'], ['/project/watershed_restoration_fish_passage/', 'restoration'],
    ['/project/aquatic_monitoring_assessment/', 'monitoring'], ['/project/open_source_software/', 'oss'], ['/contact/', 'contact']];
  const measure = `(() => {
    document.querySelectorAll('.nge-reveal').forEach(e => e.classList.add('visible'));
    const q = s => document.querySelector(s);
    const h = q('.site-header');
    const links = [...document.querySelectorAll('.site-links a.link')];
    const pills = [...document.querySelectorAll('.nge-pipeline-tools a')];
    const bodyEl = q('.nge-problem-text') || q('.post-body p') || q('.nge-contact-desc');
    return JSON.stringify({
      scrollWidth: document.documentElement.scrollWidth, clientWidth: document.documentElement.clientWidth,
      headerH: h ? Math.round(h.getBoundingClientRect().height) : null,
      navRows: links.length ? new Set(links.map(a => Math.round(a.getBoundingClientRect().top))).size : null,
      pillMinH: pills.length ? Math.round(Math.min(...pills.map(a => a.getBoundingClientRect().height))) : null,
      bodyFont: bodyEl ? getComputedStyle(bodyEl).fontSize : null,
      bodyColor: bodyEl ? getComputedStyle(bodyEl).color : null,
      h1: document.querySelectorAll('h1').length,
      docH: document.documentElement.scrollHeight
    });
  })()`;
  const results = [];
  for (const [mobile, w, hgt, tag] of [[true, 390, 844, 'phone'], [false, 1440, 900, 'desktop']]) {
    await send('Emulation.setDeviceMetricsOverride', { width: w, height: hgt, deviceScaleFactor: mobile ? 2 : 1, mobile }, sessionId);
    for (const [path, name] of pages) {
      const loaded = waitEvent('Page.loadEventFired', sessionId);
      await send('Page.navigate', { url: BASE + path }, sessionId);
      await loaded; await sleep(500);
      const { result } = await send('Runtime.evaluate', { expression: measure, returnByValue: true }, sessionId);
      const m = JSON.parse(result.value); m.page = path; m.view = tag; results.push(m);
      await sleep(300);
      const full = !mobile && ['home', 'oss', 'work'].includes(name);
      let shot;
      if (full) {
        const lm = await send('Page.getLayoutMetrics', {}, sessionId);
        const H = Math.min(Math.ceil(lm.cssContentSize.height), 4500);
        shot = await send('Page.captureScreenshot', { format: 'png', captureBeyondViewport: true, clip: { x: 0, y: 0, width: w, height: H, scale: 1 } }, sessionId);
      } else shot = await send('Page.captureScreenshot', { format: 'png' }, sessionId);
      fs.writeFileSync(`${OUTDIR}/${name}_${tag}.png`, Buffer.from(shot.data, 'base64'));
    }
  }
  fs.writeFileSync(`${OUTDIR}/measure.json`, JSON.stringify(results, null, 1));
  for (const r of results) console.log(`${r.view.padEnd(7)} ${r.page.padEnd(46)} scrollW ${r.scrollWidth}/${r.clientWidth}  header ${r.headerH}px  navRows ${r.navRows}  pillMinH ${r.pillMinH}  body ${r.bodyFont} ${r.bodyColor}  h1 ${r.h1}`);
  ws.close(); chrome.kill();
})().catch(e => { console.error(e); chrome.kill(); process.exit(1); });
