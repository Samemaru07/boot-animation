// ============================================================
// log_window.pde  —  フローティングログウィンドウ
// ============================================================

// ウィンドウ1枚の情報
class LogWindow {
    float x, y, w, h;
    String title;
    String[] lines;    // 現在表示中の行
    String[] allLines; // 流し込む全行（高速スクロール用）
    int scrollPos = 0; // allLinesの何行目まで表示したか
    float scrollTimer = 0;
    float scrollInterval; // 行追加間隔(秒)

    float appearTime;            // 出現タイミング(gTime基準)
    float disappearTime = 99999; // 消滅タイミング(gTime基準)
    float openProgress = 0;      // 展開度合い (0.0 〜 1.0)
    boolean active = false;

    color borderColor;
    boolean redBlink = false; // エラー用赤点滅

    int maxLines; // 表示最大行数

    LogWindow(float x, float y, float w, float h, String title,
              String[] allLines, float appearTime, color borderColor,
              float scrollInterval) {
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        this.title = title;
        this.allLines = allLines;
        this.lines = new String[0];
        this.appearTime = appearTime;
        this.borderColor = borderColor;
        this.scrollInterval = scrollInterval;
        this.maxLines = floor((h - 48) / 18);
    }

    void update() {
        if (gTime < appearTime)
            return;

        active = true;

        // ★変更：展開にかかる時間（秒）。数値を大きくするとよりゆっくり開きます。
        float animDuration = 0.3;
        float animSpeed = 1.0 / (TARGET_FPS * animDuration);

        if (gTime >= disappearTime) {
            openProgress = max(openProgress - animSpeed, 0);
            if (openProgress <= 0)
                active = false;
        } else {
            openProgress = min(openProgress + animSpeed, 1.0);
        }

        if (!active)
            return;

        // 行スクロール
        scrollTimer += 1.0 / TARGET_FPS;
        if (scrollTimer >= scrollInterval && scrollPos < allLines.length) {
            scrollTimer = 0;
            // 行を追加
            String[] tmp = new String[lines.length + 1];
            for (int i = 0; i < lines.length; i++)
                tmp[i] = lines[i];
            tmp[lines.length] = allLines[scrollPos];
            scrollPos++;
            // maxLinesを超えたら古い行を削除
            if (tmp.length > maxLines) {
                lines = subset(tmp, tmp.length - maxLines);
            } else {
                lines = tmp;
            }
        }
    }

    void draw() {
        if (!active || openProgress <= 0)
            return;

        pushStyle();
        pushMatrix();

        // 赤点滅の場合は枠色をオーバーライド
        color bc = borderColor;
        if (redBlink) {
            float blink = (sin(gTime * TWO_PI * 2) + 1) * 0.5;
            bc = lerpColor(color(100, 20, 20), COL_RED, blink);
        }

        float cutSize = 25;     // 左上の欠けの大きさ
        float titleHeight = 26; // タイトルバーの高さ

        // 現在の展開高さ
        float currentH = h * openProgress;

        // ─── クリッピング領域の開始 ───
        // ★変更：枠線の太さ分が切れないように、クリップ領域(縦横)に余裕を持たせる(+10)
        clip(x - 5, y - 5, w + 10, currentH + 10);

        // パネル背景
        fill(red(COL_PANEL_BG), green(COL_PANEL_BG), blue(COL_PANEL_BG),
             alpha(COL_PANEL_BG));
        stroke(red(bc), green(bc), blue(bc), 180);
        strokeWeight(1.5);

        // パネルの形状（左上が欠けた5角形）
        beginShape();
        vertex(x + cutSize, y); // 上辺の開始点
        vertex(x + w, y);       // 右上
        vertex(x + w, y + h);   // 右下
        vertex(x, y + h);       // 左下
        vertex(x, y + cutSize); // 左辺の開始点
        endShape(CLOSE);

        // タイトルバー
        fill(red(bc), green(bc), blue(bc), 60);
        noStroke();

        // タイトルバーの形状（左上が欠けた形）
        beginShape();
        vertex(x + cutSize, y);         // 上辺の開始点
        vertex(x + w, y);               // 右上
        vertex(x + w, y + titleHeight); // 右下
        vertex(x, y + titleHeight);     // 左下
        vertex(x, y + cutSize);         // 左辺の開始点
        endShape(CLOSE);

        // テキスト描画位置の調整（欠けた部分を避ける）
        float textMarginX = cutSize + 10;
        float lineMarginX = textMarginX + 5;

        // タイトルテキスト
        textFont(fontOrbitronSm);
        textSize(FONT_XS);
        textAlign(LEFT, CENTER);
        fill(red(bc), green(bc), blue(bc), 230);
        text("[ " + title + " ]", x + textMarginX, y + 13);

        // ログ行
        textSize(FONT_XS);
        for (int i = 0; i < lines.length; i++) {
            float ly = y + 36 + i * 18;
            // WARNING / ERROR 行は色を変える
            if (lines[i].startsWith("!! ") || lines[i].startsWith("ERR")) {
                fill(red(COL_RED), green(COL_RED), blue(COL_RED), 220);
            } else if (lines[i].startsWith(">> ") ||
                       lines[i].startsWith("OK ")) {
                fill(red(COL_GREEN), green(COL_GREEN), blue(COL_GREEN), 220);
            } else if (lines[i].startsWith("--")) {
                fill(red(COL_TEXT_DIM), green(COL_TEXT_DIM), blue(COL_TEXT_DIM),
                     160);
            } else {
                fill(red(COL_BLUE), green(COL_BLUE), blue(COL_BLUE), 190);
            }
            text(lines[i], x + lineMarginX, ly);
        }

        // カーソル点滅（最終行の後）
        if (lines.length > 0 && scrollPos < allLines.length) {
            float cy = y + 36 + lines.length * 18;
            if ((frameCount / 15) % 2 == 0) {
                fill(red(COL_BLUE), green(COL_BLUE), blue(COL_BLUE), 180);
                text("_", x + lineMarginX, cy);
            }
        }

        // ─── クリッピング領域の終了 ───
        noClip();

        // 展開・格納中のみ、下端にスキャンライン（発光線）を描画
        if (openProgress < 1.0) {
            stroke(red(bc), green(bc), blue(bc), 255);
            strokeWeight(2.0);
            line(x, y + currentH, x + w, y + currentH);
        }

        popMatrix();
        popStyle();
    }
}

// ============================================================
// ウィンドウインスタンス群
// ============================================================
LogWindow[] logWindows;
LogWindow auxWindow;

void initLogWindows() {
    logWindows = new LogWindow[10];

    // ─── Phase 0：SOLOMON 敵情報 ───────────────
    // W1
    logWindows[0] =
        new LogWindow(120, 80, 320, 260, "SOLOMON OUTPUT", solomonLines1(),
                      T_PHASE0 + 0.5, COL_ORANGE, 0.07);
    // W2
    logWindows[1] =
        new LogWindow(1480, 90, 300, 240, "DETECTION SCAN", solomonLines2(),
                      T_PHASE0 + 0.9, COL_ORANGE, 0.09);
    // W3
    logWindows[2] =
        new LogWindow(1560, 400, 280, 220, "THREAT ANALYSIS", solomonLines3(),
                      T_PHASE0 + 1.3, COL_ORANGE, 0.08);
    // W4
    logWindows[3] =
        new LogWindow(80, 480, 310, 200, "SIGNAL TRACE", solomonLines4(),
                      T_PHASE0 + 1.7, COL_ORANGE, 0.06);
    // W5
    logWindows[4] =
        new LogWindow(1500, 700, 320, 200, "SOLOMON ALERT", solomonLines5(),
                      T_PHASE0 + 2.1, COL_RED, 0.10);
    logWindows[4].redBlink = true;

    // ─── Phase 0 後半：CDC（要澄美）認証ログ ───────────────
    logWindows[5] =
        new LogWindow(750, 780, 380, 220, "CDC MAIN CONSOLE",
                      kiyomiKanameLines(), T_PHASE1 - 0.8, COL_GREEN, 0.10);
    logWindows[5].disappearTime = T_PHASE2 - 1.5;

    // ─── Phase 1 後半：CDC（ジェレミー）認証ログ ────────
    logWindows[6] =
        new LogWindow(750, 780, 380, 220, "CDC MAIN CONSOLE",
                      jeremyMarcyLines(), T_PHASE2 - 1.0, COL_GREEN, 0.10);

    // ─── Phase 1：偽装解除シェルログ ──────────────────────
    logWindows[7] =
        new LogWindow(100, 700, 420, 260, "CAMOUFLAGE MIRROR SYS",
                      camouflageLines(), T_PHASE1 + 0.3, COL_BLUE, 0.12);

    // ─── Phase 2：ヴェルシールドステータス ─────────────────
    logWindows[8] =
        new LogWindow(1460, 200, 360, 230, "WELLE SHIELD STATUS",
                      welleShieldLines(), T_PHASE2 + 0.2, COL_BLUE, 0.20);

    // ─── Phase 3：BRUNHILDEエラーログ ────────────────────
    logWindows[9] =
        new LogWindow(680, 760, 560, 220, "BRUNHILDE SYSTEM ERROR",
                      brunhildeErrorLines(), T_PHASE3 + 0.2, COL_RED, 0.15);
    logWindows[9].redBlink = true;

    // ─── Phase 4：AUX POWERウィンドウ（暗転後） ──────────────────────────
    auxWindow = new LogWindow(WIN_W / 2 - 280, WIN_H / 2 - 80, 560, 180,
                              "BRUNHILDE SYSTEM", auxLines(), T_PHASE4 + 0.5,
                              COL_GREEN, 0.25);
}

void drawLogWindows() {
    for (int i = 0; i < logWindows.length; i++) {
        logWindows[i].update();
        logWindows[i].draw();
    }
}

void drawAuxPanel() {
    auxWindow.update();
    auxWindow.draw();
}

void onPhaseChangedLogWindows(int phase) {
    // Phase 3突入でエラーウィンドウ(9)以外をフリーズさせる
    if (phase == 3) {
        for (int i = 0; i < 9; i++) {
            logWindows[i].scrollInterval = 9999; // 実質停止
        }
    }
}

// ============================================================
// ログテキスト
// ============================================================

// W1: SOLOMONからの敵情報（高速ランダム系）
String[] solomonLines1() {
    return new String[]{"INIT SOLOMON v4.7.2",    "SCANNING SECTOR 7-G...",
                        "0xF3A2 0x881C 0xD047",   "ENTITY CLASS: SILICON",
                        "VECTOR: 047.3 / 291.8",  "MASS ESTIM: 2.4e+04 kg",
                        "0xC119 0x3FFA 0xA280",   "SILICON-BASED DETECTED",
                        "COUNT: 03  RISING...",   "0x7B3E 0x0044 0x9F12",
                        "APPROACH VECTOR LOCKED", "ETA: 00:04:17",
                        "0xE901 0x2C7D 0xBB56",   "!! FORMATION ANOMALY",
                        "ADAPTIVE PATTERN SYNC",  "0x5A0F 0xD832 0x1E9C"};
}

// W2: 探知スキャン
String[] solomonLines2() {
    return new String[]{"FREQ SCAN: 0.1~999 THz", "MATCH: FESTUM SIG x3",
                        "RF PATTERN 0xF3..LOCK",  "DEPTH: 12400m",
                        "COORD: 28.7N 132.4E",    "COORD: 28.8N 132.5E",
                        "COORD: 28.6N 132.3E",    "!! CLUSTER DETECTED",
                        "MULTI-CORE SYNC: YES",   "PRIMARY NODE ISOLATE",
                        "0xAA12 PING TIMEOUT",    "REROUTING SIGNAL..."};
}

// W3: 脅威分析
String[] solomonLines3() {
    return new String[]{"THREAT LEVEL: ALPHA",  "COMBAT CLASS: MARK-7",
                        "ASSIMILATION: ACTIVE", "!! MARK-7 HOSTILE",
                        "RANGED ATK POSSIBLE",  "SHIELD PENETRATION: B",
                        "RECOMMEND: INTERCEPT", "FAFNER DISPATCH: PENDING",
                        "ALERT BROADCAST...",   "TYPE-1 ENGAGE RULE"};
}

// W4: シグナルトレース
String[] solomonLines4() {
    return new String[]{
        "TRACE ID: SLM-2047",   "0x0F12 0x9A3C 0x7701",  "NODE DEPTH: LAYER 4",
        "PACKET LOSS: 0.3%",    "0xDE89 0x4401 0xFF00",  "SYNC PULSE DETECTED",
        "INTERVAL: 0.78s",      "SOURCE: UNKNOWN",       "0x12FA 0xCB20 0x3390",
        "SIGNAL STRENGTH: 94%", "JAMMING: NOT DETECTED", "LINK STABLE"};
}

// W5: アラート（赤）
String[] solomonLines5() {
    return new String[]{"!! TYPE-1 ALERT",     "!! INTRUDER DETECTED",
                        "!! PHENEX PERIMETER", "SCRAMBLE ORDER SENT",
                        "CDC NOTIFIED",        "HORN: ACTIVATED",
                        "!! DEFENCE MODE ON",  "FAFNER STANDBY: MARK-ALLES"};
}

// W6: CDC 要澄美 認証ログ
String[] kiyomiKanameLines() {
    return new String[]{
        "LOCATION: CDC MAIN",      "OPERATOR: KIYOMI KANAME",  "--",
        ">> OVERRIDE: CAMOUFLAGE", "INPUT COMMAND CODE:",      "**********",
        "OK  CODE ACCEPTED",       ">> STANDBY FOR RELEASE..."};
}

// W7: CDC ジェレミー 認証ログ
String[] jeremyMarcyLines() {
    return new String[]{"LOCATION: CDC MAIN",
                        "OPERATOR: JEREMY LEE MARCY",
                        "--",
                        ">> OVERRIDE: WELLE SHIELD",
                        "TARGET: LAYER 1 & 2",
                        "INPUT COMMAND CODE:",
                        "**********",
                        "OK  CODE ACCEPTED",
                        ">> INITIATING DEPLOYMENT..."};
}

// W8: 偽装解除シェルログ
String[] camouflageLines() {
    return new String[]{"$ ./camouflage_ctrl -d",    ">> AUTH: ACCEPTED",
                        ">> MODE: DISENGAGE",        "LAYER 3 RELEASE...",
                        "MIRROR NODE 01: OFF",       "MIRROR NODE 02: OFF",
                        "MIRROR NODE 03: OFF",       "OK  LAYER 3 CLEAR",
                        "LAYER 2 RELEASE...",        "HOLOGRAM GRID: HALT",
                        "OK  LAYER 2 CLEAR",         "LAYER 1 RELEASE...",
                        "SURFACE MASK: DOWN",        "OK  LAYER 1 CLEAR",
                        ">> CAMOUFLAGE: DISENGAGED", "PHENEX ISLAND: EXPOSED",
                        "-- WARNING: VISIBLE --"};
}

// W9: ヴェルシールドステータス
String[] welleShieldLines() {
    return new String[]{"WELLE SHIELD INIT",    "LAYER 1/3: FORMING...",
                        "OK  LAYER 1/3 ACTIVE", "LAYER 2/3: FORMING...",
                        "OK  LAYER 2/3 ACTIVE", "LAYER 3/3: FORMING...",
                        "OK  LAYER 3/3 ACTIVE", ">> SHIELD: ONLINE",
                        "COVERAGE: 100%",       "INTEGRITY: 98.7%"};
}

// W10: BRUNHILDEエラー（赤）
String[] brunhildeErrorLines() {
    return new String[]{"ERR CIRCUIT FAULT: PSU-MB", "ERR MAIN POWER LINE OPEN",
                        "ERR CDC LINK LOST",         "!! POWER DRAW CRITICAL",
                        "!! VOLTAGE DROP: 98%",      "SWITCHING TO AUX BUS...",
                        "ERR AUX BUS OVERLOAD",      "!! BRUNHILDE: SHUTDOWN",
                        "MAIN POWER: DISCONNECTED"};
}

// AUX POWERウィンドウ
String[] auxLines() {
    return new String[]{"-- SYSTEM DARK --",     "AUX POWER: ONLINE",
                        "SUPPLY: MARK ALLES",    "ASSIMILATION ENERGY",
                        ">> BUS VOLTAGE: 12.1V", "BRUNHILDE: REBOOT...",
                        "TRANSFERRING TO AUX..."};
}
