// ============================================================
// config.pde  —  BRUNHILDE SYSTEM / Plymouth Animation
// 色・定数・タイミング・グローバル変数
// ============================================================

// ------------------------------------------------------------
// ウィンドウ
// ------------------------------------------------------------
final int WIN_W = 1920;
final int WIN_H = 1080;
final int TARGET_FPS = 60;

// ------------------------------------------------------------
// カラー（setup()内で初期化）
// ------------------------------------------------------------
color COL_BLUE;         // メイン青    (68, 170, 255)
color COL_ORANGE;       // メインオレンジ (255, 170, 50)
color COL_RED;          // 警告赤      (255, 60, 60)
color COL_GREEN;        // AUX電源緑   (80, 255, 160)
color COL_BG;           // 背景        (8, 18, 30)
color COL_RADAR_RING;   // レーダー同心円 (68, 170, 255, 40)
color COL_PANEL_BG;     // パネル背景   (10, 30, 55, 200)
color COL_PANEL_BORDER; // パネル枠     (68, 170, 255, 180)
color COL_TEXT_DIM;     // 暗めテキスト  (68, 170, 255, 120)
color COL_WHITE;        // 白          (220, 235, 255)

void initColors() {
    COL_BLUE = color(68, 170, 255);
    COL_ORANGE = color(255, 170, 50);
    COL_RED = color(255, 60, 60);
    COL_GREEN = color(80, 255, 160);
    COL_BG = color(8, 18, 30);
    COL_RADAR_RING = color(68, 170, 255, 40);
    COL_PANEL_BG = color(10, 30, 55, 200);
    COL_PANEL_BORDER = color(68, 170, 255, 180);
    COL_TEXT_DIM = color(68, 170, 255, 120);
    COL_WHITE = color(220, 235, 255);
}

// ------------------------------------------------------------
// フォント
// ------------------------------------------------------------
PFont fontOrbitron;
PFont fontOrbitronSm;

final float FONT_LG = 28;
final float FONT_MD = 20;
final float FONT_SM = 14;
final float FONT_XS = 11;

// ------------------------------------------------------------
// フェーズ
// ------------------------------------------------------------
// 0: SOLOMON REACTION
// 1: CAMOUFLAGE MIRROR RELEASE
// 2: WELLE SHIELD DEPLOYING
// 3: POWER CRITICAL → BLACKOUT
// 4: AUX POWER TRANSITION（暗転後）
int ePhase = 0;
float phaseStartTime = 0; // 現フェーズ開始時刻(秒)

// フェーズ切り替えタイミング(秒)
final float T_PHASE0 = 0.0;
final float T_PHASE1 = 3.0;
final float T_PHASE2 = 8.0;
final float T_PHASE3 = 15.5;
final float T_PHASE4 = 18.0; // ブラックアウト後
final float T_END = 22.0;    // 全終了

// ------------------------------------------------------------
// グローバルタイマー
// ------------------------------------------------------------
float gTime = 0; // 経過秒（draw()内で更新）

// ------------------------------------------------------------
// ブラックアウト / フェード
// ------------------------------------------------------------
float blackoutAlpha = 0; // 0〜255
float auxPanelAlpha = 0; // AUXウィンドウ用

// ------------------------------------------------------------
// セーブフレーム（書き出し時のみ true にする）
// ------------------------------------------------------------
final boolean EXPORT_FRAMES = true;
int exportFrame = 0;

boolean DEBUG_MODE = false; // D キーで実行中にも切替可能
