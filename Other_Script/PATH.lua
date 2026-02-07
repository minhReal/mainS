javascript:(function() {
    const IDs = ['sn-ui', 'sn-cross', 'sn-ctrl', 'sn-style'];
    IDs.forEach(id => document.getElementById(id)?.remove());

    const state = {
        x: window.innerWidth / 2,
        y: window.innerHeight / 2,
        crossSize: 30,
        ctrlScale: 1.0,
        moveInterval: null,
        path: '',
        xpath: '',
        lastEl: null
    };

    const style = document.createElement('style');
    style.id = 'sn-style';
    style.innerHTML = `
        :root { --accent: #f38ba8; --bg: rgba(17, 18, 27, 0.9); }
        #sn-cross { position: fixed; pointer-events: none; z-index: 2147483647; transform: translate(-50%, -50%); border: 2px solid #ff4757; border-radius: 50%; display: flex; align-items: center; justify-content: center; box-shadow: 0 0 10px rgba(255, 71, 87, 0.5); }
        #sn-cross::after { content: ''; position: absolute; width: 1.5px; height: 100%; background: #ff4757; }
        #sn-cross::before { content: ''; position: absolute; height: 1.5px; width: 100%; background: #ff4757; }

        #sn-ctrl { 
            position: fixed; bottom: 180px; right: 20px; z-index: 2147483647; 
            background: var(--bg); backdrop-filter: blur(10px); padding: 12px; border-radius: 24px; border: 1px solid rgba(255,255,255,0.1);
            transform: scale(var(--ctrl-scale, 1)); transform-origin: bottom right;
            display: flex; flex-direction: column; gap: 10px; align-items: center;
            box-shadow: 0 10px 30px rgba(0,0,0,0.5); touch-action: none;
        }

        .dpad { display: grid; grid-template-columns: repeat(3, 45px); grid-template-rows: repeat(3, 45px); gap: 5px; }
        .sn-btn { 
            background: #313244; color: white; border: none; border-radius: 12px; display: flex; align-items: center; justify-content: center; 
            font-size: 20px; cursor: pointer; user-select: none; box-shadow: 0 4px 0 #181825; transition: all 0.1s;
        }
        .sn-btn:active { transform: translateY(2px); box-shadow: 0 2px 0 #181825; background: #ff4757; }
        
        #sn-ui { 
            position: fixed; bottom: 0; left: 0; width: 100%; background: #11111b; color: #cdd6f4; padding: 15px; font-family: sans-serif; z-index: 2147483646; 
            border-top: 2px solid var(--accent); box-shadow: 0 -5px 25px rgba(0,0,0,0.6); 
        }

        .slider-box { width: 100%; display: flex; flex-direction: column; gap: 4px; }
        .slider-box label { font-size: 10px; color: #89b4fa; text-transform: uppercase; font-weight: bold; }
        input[type=range] { width: 100%; accent-color: var(--accent); cursor: pointer; }

        .copy-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 8px; margin-top: 10px; }
        .cp-btn { background: #fab387; color: #11111b; border: none; padding: 8px; border-radius: 8px; font-size: 11px; font-weight: bold; cursor: pointer; }
        .attr-input-group { display: flex; gap: 5px; margin-top: 10px; }
        .sn-input { flex: 1; background: #1e1e2e; border: 1px solid #313244; color: white; padding: 8px; border-radius: 8px; font-size: 12px; }
    `;
    document.head.appendChild(style);

    const crosshair = document.createElement('div');
    crosshair.id = 'sn-cross';
    updateCrosshair();
    document.body.appendChild(crosshair);

    const controls = document.createElement('div');
    controls.id = 'sn-ctrl';
    controls.innerHTML = `
        <div class="dpad">
            <div></div><button class="sn-btn" id="v-up">▲</button><div></div>
            <button class="sn-btn" id="v-left">◀</button><button class="sn-btn" id="v-center" style="border-radius:50%; background:#45475a;">●</button><button class="sn-btn" id="v-right">▶</button>
            <div></div><button class="sn-btn" id="v-down">▼</button><div></div>
        </div>
        <div class="slider-box"><label>Control Size</label><input type="range" id="ctrl-sz" min="0.5" max="1.8" step="0.1" value="1.0"></div>
        <div class="slider-box"><label>Pointer Size</label><input type="range" id="ptr-sz" min="10" max="100" value="30"></div>
    `;
    document.body.appendChild(controls);

    const ui = document.createElement('div');
    ui.id = 'sn-ui';
    ui.innerHTML = `
        <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:8px;">
            <span id="v-status" style="color:#a6e3a1; font-size:13px; font-weight:bold;">Classic Logic Ready</span>
            <button onclick="document.querySelectorAll('[id^=sn-]').forEach(e=>e.remove())" style="background:none; border:none; color:#f38ba8; font-size:20px;">✕</button>
        </div>
        <div id="v-path-box" style="font-family:monospace; font-size:11px; background:#1e1e2e; padding:8px; border-radius:6px; word-break:break-all; border:1px solid #313244; max-height:45px; overflow:auto;">...</div>
        <div class="copy-grid">
            <button class="cp-btn" id="c-js">JS Selector</button>
            <button class="cp-btn" id="c-css">CSS Path</button>
            <button class="cp-btn" id="c-xp">XPath</button>
            <button class="cp-btn" id="c-html">HTML</button>
            <button class="cp-btn" id="c-txt">Text</button>
            <button class="cp-btn" id="c-val">Value</button>
        </div>
        <div class="attr-input-group">
            <input id="v-attr-n" class="sn-input" placeholder="Tên thuộc tính (vd: src, href)">
            <button class="cp-btn" id="c-attr" style="background:#89b4fa;">Copy Attr</button>
        </div>
    `;
    document.body.appendChild(ui);

    function updateCrosshair() {
        crosshair.style.left = state.x + 'px';
        crosshair.style.top = state.y + 'px';
        crosshair.style.width = state.crossSize + 'px';
        crosshair.style.height = state.crossSize + 'px';
    }

    function getXPath(el) {
        if (!el) return '';
        if (el.id !== "") return `//*[@id="${el.id}"]`;
        if (el === document.body) return "/html/body";
        let ix = 0, siblings = el.parentNode.childNodes;
        for (let i = 0; i < siblings.length; i++) {
            let sib = siblings[i];
            if (sib === el) return getXPath(el.parentNode) + "/" + el.tagName.toLowerCase() + "[" + (ix + 1) + "]";
            if (sib.nodeType === 1 && sib.tagName === el.tagName) ix++;
        }
    }

    function getCSSPath(el) {
        let path = [];
        while (el && el.nodeType === Node.ELEMENT_NODE) {
            let selector = el.nodeName.toLowerCase();
            if (el.id) { selector += '#' + el.id; path.unshift(selector); break; }
            else {
                let sib = el, nth = 1;
                while (sib = sib.previousElementSibling) if (sib.nodeName === el.nodeName) nth++;
                if (nth !== 1) selector += ":nth-of-type(" + nth + ")";
            }
            path.unshift(selector);
            el = el.parentNode;
        }
        return path.join(" > ");
    }

    // LOGIC QUÉT CŨ: ẨN TÂM -> QUÉT -> HIỆN TÂM -> VẼ OUTLINE
    function scan() {
        crosshair.style.visibility = 'hidden';
        let el = document.elementFromPoint(state.x, state.y);
        crosshair.style.visibility = 'visible';
        
        if (el?.tagName === 'IFRAME') {
            try {
                let r = el.getBoundingClientRect();
                let inner = el.contentDocument.elementFromPoint(state.x - r.left, state.y - r.top);
                if (inner) el = inner;
            } catch(e) {}
        }

        if (state.lastEl) {
            try { state.lastEl.style.outline = ""; } catch(err) {}
        }
        
        if (el && el !== document.body && el !== document.documentElement) {
            el.style.outline = "2px solid #f38ba8";
            state.lastEl = el;
            state.path = getCSSPath(el);
            state.xpath = getXPath(el);
            document.getElementById('v-status').innerText = `<${el.tagName.toLowerCase()}> detected`;
            document.getElementById('v-path-box').innerText = state.path;
        }
    }

    function startMoving(dx, dy) {
        if (state.moveInterval) return;
        state.moveInterval = setInterval(() => {
            state.x += dx * 5;
            state.y += dy * 5;
            updateCrosshair();
            scan();
        }, 16);
    }

    function stopMoving() {
        clearInterval(state.moveInterval);
        state.moveInterval = null;
    }

    function copyToClipboard(text) {
        const t = document.createElement("textarea");
        t.value = text; document.body.appendChild(t);
        t.select(); document.execCommand("copy");
        document.body.removeChild(t);
        const s = document.getElementById('v-status');
        const old = s.innerText; s.innerText = "COPIED!";
        setTimeout(() => s.innerText = old, 1200);
    }

    const bindMove = (id, dx, dy) => {
        const btn = document.getElementById(id);
        btn.onpointerdown = (e) => { e.preventDefault(); startMoving(dx, dy); };
        btn.onpointerup = stopMoving;
        btn.onpointerleave = stopMoving;
    };

    bindMove('v-up', 0, -1); bindMove('v-down', 0, 1);
    bindMove('v-left', -1, 0); bindMove('v-right', 1, 0);

    document.getElementById('v-center').onclick = () => {
        state.x = window.innerWidth / 2; state.y = window.innerHeight / 2;
        updateCrosshair(); scan();
    };

    document.getElementById('ctrl-sz').oninput = (e) => {
        document.documentElement.style.setProperty('--ctrl-scale', e.target.value);
    };

    document.getElementById('ptr-sz').oninput = (e) => {
        state.crossSize = e.target.value; updateCrosshair();
    };

    // --- CÁC NÚT COPY ---
    document.getElementById('c-js').onclick = () => copyToClipboard(`document.querySelector('${state.path}')`);
    document.getElementById('c-css').onclick = () => copyToClipboard(state.path);
    document.getElementById('c-xp').onclick = () => copyToClipboard(state.xpath);
    document.getElementById('c-html').onclick = () => state.lastEl && copyToClipboard(state.lastEl.outerHTML);
    document.getElementById('c-txt').onclick = () => state.lastEl && copyToClipboard(state.lastEl.textContent);
    document.getElementById('c-val').onclick = () => state.lastEl && copyToClipboard(state.lastEl.value || '');
    document.getElementById('c-attr').onclick = () => {
        const a = document.getElementById('v-attr-n').value;
        if(state.lastEl && a) copyToClipboard(state.lastEl.getAttribute(a) || 'None');
    };

    scan();
})();
