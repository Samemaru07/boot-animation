void setup() {
    size(1920, 1020);
    frameRate(60);
    textFont(createFont("Courier New", 12, true));
    initColors();
    phaseTimer = millis();
    startPhase0();
}

void draw() {
    background(0);
    updatePhase();
    updateAnimations();

    float hw = width / 2.0;
    float hh = height * 0.65;

    drawPanel(4, 4, hw - 6, hh - 6);
    drawPanel(hw + 2, 4, hw - 6, hh - 6);
    drawPanel(4, hh + 2, hw - 6, hh - 6);
    drawPanel(hw + 2, hh + 2, hw - 6, hh - 6);

    drawMSPanel(4, 4, hw - 6, hh - 6);
    drawPCPanel(hw + 2, 4, hw - 6, hh - 6);
    drawLogPanel(4, hh + 2, hw - 6, hh - 6);
    drawCLIPanel(hw + 2, hh + 2, hw - 6, hh - 6);

    if (flickering && flickerOpacity > 0) {
        noStroke();
        fill(255, 0, 0, flickerOpacity * 120);
        rect(hw + 2, 4, hw - 6, hh - 6);
    }

    // デバッグ：接続線の起点・終点確認
    // hw と hh は上で宣言済みなので削除
    float msCX = 4 + (hw - 6) / 2;
    float msCY = 4 + (hh - 6) / 2 + 10;

    float coreX = 650;
    float coreY = msCY + (-45) * 1.5;

    float pcCX = hw + 2 + (hw - 6) / 2;
    float pcCY = 4 + (hh - 6) / 2;
    float pcLeftX = 1150;
    float pcLeftY = msCY + (-45) * 1.5;

    // 接続線（エネルギーパイプ）
    int pipeCol = (ePhase >= 3) ? color(100, 220, 100) : color(255, 100, 0);
    stroke(pipeCol);
    strokeWeight(8);
    line(coreX, coreY, pcLeftX, pcLeftY);
}

void drawPanel(float x, float y, float w, float h) {
    noStroke();
    fill(COL_PANEL_BG);
    rect(x, y, w, h);
    stroke(COL_BORDER);
    strokeWeight(1);
    noFill();
    rect(x, y, w, h);
}

void panelTitle(float x, float y, float w, String title) {
    fill(COL_TITLE);
    textSize(9);
    textAlign(LEFT, TOP);
    text(title, x + 8, y + 8);
    stroke(COL_BORDER);
    strokeWeight(0.5);
    line(x + 8, y + 20, x + w - 8, y + 20);
}
