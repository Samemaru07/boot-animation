// ============================================================
//  グローバル変数・色定数
// ============================================================

// --- フェーズ ---
int phase = 0;
long phaseTimer = 0;

// --- MSアニメーション ---
float msOpacity = 0;
float funnelT = 0;
boolean funnelActive = false;
float flickerOpacity = 1.0;
boolean flickering = false;
int flickerCount = 0;
long flickerLast = 0;
float energyBar = 0;
boolean energyDone = false;

// --- プログレスバー ---
float progWidth = 0;
int progColor;

// --- 認証 ---
String pwInput = "";
boolean pwVisible = false;
boolean authDone = false;
boolean timedOut = false;
long authStart = 0;
int authTimeout = 15;
int pwAttempts = 0;

// --- アップリンク ---
int uplinkDots = 0;
long uplinkLast = 0;
boolean uplinkDone = false;

// --- ルート ---
float routeP = 0;
boolean routeDone = false;

// --- ステータスバー ---
String statusText = "MS-00X ENERGY TRANSFER SYSTEM :: STANDBY";

// --- ログ ---
ArrayList<LogEntry> logs = new ArrayList<LogEntry>();
ArrayList<LogEntry> cliLines = new ArrayList<LogEntry>();

// --- PC情報（右上パネルに表示） ---
String pcHostname = "---";
String pcKernel = "---";
String pcCPU = "---";
String pcPower = "OFFLINE";
String pcLink = "---";
int pcPowerCol, pcLinkCol;

// エネルギーアニメーション
float[] eVals = {0.0, 0.0, 0.0}; // 0スタート
int ePhase = 0;           // 現在充電中のバー（0=SYNC, 1=REACTOR, 2=THRUST）
boolean eStarted = false; // アニメーション開始フラグ

// --- 接続線アニメーション ---
float pipeDrawT = 0.0;
boolean pipeAnimDone = false;
float[] pulsePositions = {0.0, 0.33, 0.66}; // 粒の位置（0.0〜1.0）
boolean pulseActive = false;

// --- コンポーネントステータス ---
String[] compNames = {"SIEGFRIED SYS",  "CDC PLATFORM", "URD AUX",
                      "SOLOMON BUFFER", "AUX POWER",    "BRUNHILDE SYS"};
String[] compStatus = {"---", "---", "---", "---", "---", "---"};
int[] compColors; // initColors()で初期化

void initCompStatus() {
    compColors =
        new int[]{COL_DIM, COL_DIM, COL_DIM, COL_DIM, COL_DIM, COL_DIM};
}

// --- 色定数（initColors()で初期化） ---
int COL_PANEL_BG, COL_BORDER, COL_TITLE, COL_DIM;
int COL_MAIN, COL_OK, COL_ERR, COL_WARN, COL_CMD, COL_ACCENT;

void initColors() {
    COL_PANEL_BG = color(0, 6, 14);
    COL_BORDER = color(26, 58, 90);
    COL_TITLE = color(42, 106, 154);
    COL_DIM = color(26, 90, 122);
    COL_MAIN = color(68, 170, 255);
    COL_OK = color(51, 170, 102);
    COL_ERR = color(238, 68, 68);
    COL_WARN = color(255, 170, 0);
    COL_CMD = color(85, 187, 255);
    COL_ACCENT = color(255, 68, 170);
    pcPowerCol = color(85, 85, 85);
    pcLinkCol = color(85, 85, 85);
    progColor = COL_MAIN;
}
