// ============================================================
// plymouth_animation.pde  —  BRUNHILDE SYSTEM
// メイン：setup / draw
// ============================================================

// ─── デバッグ設定 ────────────────────────────────────────────
// true にするとマウス座標・クロスヘア・フェーズ固定が有効になる

// デバッグ中に固定するフェーズ（0〜4）
// フェーズを固定したい場合は DEBUG_FIX_PHASE = true にする
// 0〜4 キーでも実行中に切り替え可能
boolean DEBUG_FIX_PHASE = true;
int DEBUG_FIXED_PHASE = 0; // ← ここを変えてフェーズ切り替え

void keyPressed() {
    // D キー：デバッグ表示オン/オフ
    if (key == 'd' || key == 'D') {
        DEBUG_MODE = !DEBUG_MODE;
    }
    // 0〜4 キー：フェーズ直接切替
    if (key >= '0' && key <= '4') {
        DEBUG_FIX_PHASE = true;
        DEBUG_FIXED_PHASE = key - '0';
        ePhase = DEBUG_FIXED_PHASE;
        phaseStartTime = gTime;
    }
    // F キー：フェーズ固定オン/オフ
    if (key == 'f' || key == 'F') {
        DEBUG_FIX_PHASE = !DEBUG_FIX_PHASE;
    }
}

void setup() {
    size(1920, 1080);
    frameRate(TARGET_FPS);

    // 色初期化（color()はsetup内でないと使えない）
    initColors();

    // フォント
    fontOrbitron = createFont("Orbitron-Regular", FONT_LG);
    fontOrbitronSm = createFont("Orbitron-Regular", FONT_SM);

    // 各モジュール初期化
    initPhase();
    initSolomon();
    initIsland();
    initWelleShield();
    initLogWindows();
    initBlackout();

    phaseStartTime = 0;
    gTime = 0;
}

void draw() {
    gTime = frameCount / float(TARGET_FPS);

    // フェーズ進行（デバッグ固定中はスキップ）
    if (DEBUG_MODE && DEBUG_FIX_PHASE) {
        ePhase = DEBUG_FIXED_PHASE;
    } else {
        updatePhase();
    }

    // ─── 背景 ───
    background(COL_BG);
    drawRadarBackground();

    // ─── 中央演出（重ね描き） ───
    if (ePhase <= 3) {
        drawSolomon(); // Phase 0〜3：SOLOMONシンボル（フェーズに応じてα変化）
    }
    if (ePhase >= 1 && ePhase <= 3) {
        drawIsland(); // Phase 1〜3：島の線画＋半球
    }
    if (ePhase >= 2 && ePhase <= 3) {
        drawWelleShield(); // Phase 2〜3：ヴェルシールド
    }

    // ─── フローティングウィンドウ ───
    drawLogWindows();

    // ─── ブラックアウト ───
    drawBlackout();

    // ─── AUX POWERウィンドウ（暗転後） ───
    if (ePhase >= 4) {
        drawAuxPanel();
    }

    // ─── フレーム書き出し ───
    if (EXPORT_FRAMES) {
        saveFrame("frames/frame-####.png");
    }

    // ─── デバッグオーバーレイ ───
    if (DEBUG_MODE) {
        drawDebugOverlay();
    }
}

// ─── デバッグオーバーレイ ────────────────────────────────────
// マウス座標・中心からのオフセット・現フェーズを表示
void drawDebugOverlay() {
    pushStyle();

    // 十字カーソル
    stroke(255, 255, 0, 200);
    strokeWeight(1);
    line(mouseX - 16, mouseY, mouseX + 16, mouseY);
    line(mouseX, mouseY - 16, mouseX, mouseY + 16);
    ellipse(mouseX, mouseY, 6, 6);

    // 座標ラベル（マウスの右下に追従）
    float cx = WIN_W / 2.0;
    float cy = WIN_H / 2.0;
    int offX = mouseX - int(cx);
    int offY = mouseY - int(cy);

    String coordAbs = "ABS  x:" + mouseX + "  y:" + mouseY;
    String coordOffset = "OFF  x:" + (offX >= 0 ? "+" : "") + offX +
                         "  y:" + (offY >= 0 ? "+" : "") + offY;
    String phaseInfo = "PHASE:" + ePhase + "  t:" + nf(gTime, 1, 2);

    // ラベル背景
    int lx = mouseX + 14;
    int ly = mouseY + 6;
    // 画面右端をはみ出さないよう補正
    if (lx + 220 > WIN_W)
        lx = mouseX - 234;
    if (ly + 58 > WIN_H)
        ly = mouseY - 62;

    noStroke();
    fill(0, 0, 0, 180);
    rect(lx - 4, ly - 14, 228, 60, 3);

    textFont(fontOrbitronSm);
    textSize(11);
    textAlign(LEFT, TOP);
    fill(255, 255, 0, 230);
    text(coordAbs, lx, ly);
    text(coordOffset, lx, ly + 18);
    fill(68, 200, 255, 200);
    text(phaseInfo, lx, ly + 36);

    // 画面中心マーク
    stroke(255, 255, 0, 80);
    strokeWeight(1);
    line(cx - 20, cy, cx + 20, cy);
    line(cx, cy - 20, cx, cy + 20);

    // 左上にヒント
    noStroke();
    fill(0, 0, 0, 160);
    rect(8, 8, 310, 28, 3);
    textSize(10);
    fill(255, 255, 0, 200);
    textAlign(LEFT, CENTER);
    text("D:表示切替  F:固定切替  0〜4:フェーズ  中心:" + int(cx) + "," +
             int(cy),
         14, 22);

    popStyle();
}

// ─── レーダー背景 ───────────────────────────────────────────
void drawRadarBackground() {
    pushStyle();
    noFill();
    strokeWeight(1);

    // 同心円（スキャンライン効果）
    int rings = 8;
    for (int i = 1; i <= rings; i++) {
        float r = (WIN_W * 0.6 / rings) * i;
        // 奇数リングをわずかに明るく
        if (i % 2 == 1) {
            stroke(68, 170, 255, 50);
        } else {
            stroke(68, 170, 255, 25);
        }
        ellipse(WIN_W / 2.0, WIN_H / 2.0, r * 2, r * 2);
    }

    // スキャンライン（回転する放射線）
    float scanAngle = (gTime * TWO_PI * 0.3) % TWO_PI; // 0.3回転/秒
    float maxR = WIN_W * 0.6;
    for (int i = 0; i < 3; i++) {
        float a = scanAngle - i * 0.15;
        float alp = map(i, 0, 3, 80, 10);
        stroke(68, 170, 255, alp);
        strokeWeight(1.5 - i * 0.4);
        line(WIN_W / 2.0, WIN_H / 2.0, WIN_W / 2.0 + cos(a) * maxR,
             WIN_H / 2.0 + sin(a) * maxR);
    }

    // 十字線（中心）
    stroke(68, 170, 255, 35);
    strokeWeight(1);
    line(WIN_W / 2.0 - 40, WIN_H / 2.0, WIN_W / 2.0 + 40, WIN_H / 2.0);
    line(WIN_W / 2.0, WIN_H / 2.0 - 40, WIN_W / 2.0, WIN_H / 2.0 + 40);

    popStyle();
}
