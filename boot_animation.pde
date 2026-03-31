void setup() {
    size(1920, 1020);
    frameRate(60);
    textFont(createFont("Courier New", 12, true));
    initColors();
    initCompStatus();
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

    // フェーズ5ではパネルをアルファ付きで描画
    if (phase < 5) {
        drawMSPanel(4, 4, hw - 6, hh - 6);
        drawPCPanel(hw + 2, 4, hw - 6, hh - 6);
        drawLogPanel(4, hh + 2, hw - 6, hh - 6);
        drawCLIPanel(hw + 2, hh + 2, hw - 6, hh - 6);
    } else {
        tint(255, panelAlpha[0]);
        drawMSPanel(4, 4, hw - 6, hh - 6);
        noTint();
        tint(255, panelAlpha[1]);
        drawPCPanel(hw + 2, 4, hw - 6, hh - 6);
        noTint();
        tint(255, panelAlpha[2]);
        drawLogPanel(4, hh + 2, hw - 6, hh - 6);
        noTint();
        tint(255, panelAlpha[3]);
        drawCLIPanel(hw + 2, hh + 2, hw - 6, hh - 6);
        noTint();
    }

    if (flickering && flickerOpacity > 0) {
        noStroke();
        fill(255, 0, 0, flickerOpacity * 120);
        rect(hw + 2, 4, hw - 6, hh - 6);
    }

    // フェーズ5：スキャンライン
    if (phase == 5 && !scanLineDone) {
        noStroke();
        fill(255, 255, 255, 60);
        rect(0, scanLineY - 6, width, 6);
        fill(255, 255, 255, 180);
        rect(0, scanLineY - 2, width, 2);
    }

    float msCX = 4 + (hw - 6) / 2;
    float msCY = 4 + (hh - 6) / 2 + 10;
    float coreX = 650;
    float coreY = msCY + (-45) * 1.5;
    float pcLeftX = 1150;
    float pcLeftY = msCY + (-45) * 1.5;

    // 接続線（エネルギーパイプ）
    if (pipeDrawT > 0) {
        int pipeCol =
            (ePhase >= 3) ? color(100, 220, 100) : color(255, 170, 50);
        float lineEndX = lerp(coreX, pcLeftX, pipeDrawT);
        float[] pipeOffsets = {-20, 0, 20};

        for (int i = 0; i < pipeOffsets.length; i++) {
            float offsetY = pipeOffsets[i];
            float lineEndY =
                lerp(coreY + offsetY, pcLeftY + offsetY, pipeDrawT);

            // 線本体
            stroke(pipeCol);
            strokeWeight(8);
            line(coreX, coreY + offsetY, lineEndX, lineEndY);

            // 中央線のみソケット・ラベル
            // 左ソケット（全線）
            noStroke();
            fill(red(pipeCol), green(pipeCol), blue(pipeCol), 80);
            ellipse(coreX, coreY + offsetY, 22, 22);
            fill(pipeCol);
            ellipse(coreX, coreY + offsetY, 12, 12);

            // 右ソケット（全線・伸びきったら表示）
            if (pipeAnimDone) {
                noStroke();
                fill(red(pipeCol), green(pipeCol), blue(pipeCol), 80);
                ellipse(pcLeftX, pcLeftY + offsetY, 22, 22);
                fill(pipeCol);
                ellipse(pcLeftX, pcLeftY + offsetY, 12, 12);
            }

            // ラベル（一番下の線の下に表示）
            if (i == 2) {
                fill(pipeCol);
                textSize(11);
                textAlign(LEFT, TOP);
                text("ENERGY LINK", coreX, coreY + offsetY + 16);
            }
        }
    }

    // パルスエフェクト
    if (pulseActive) {
        int pipeCol =
            (ePhase >= 3) ? color(100, 220, 100) : color(255, 170, 50);
        float[] pipeOffsets = {-20, 0, 20};
        for (int i = 0; i < pipeOffsets.length; i++) {
            float offsetY = pipeOffsets[i];
            for (int j = 0; j < pulsePositions.length; j++) {
                float px = lerp(coreX, pcLeftX, pulsePositions[j]);
                float py =
                    lerp(coreY + offsetY, pcLeftY + offsetY, pulsePositions[j]);
                noStroke();
                fill(red(pipeCol), green(pipeCol), blue(pipeCol), 60);
                ellipse(px, py, 24, 24);
                fill(red(pipeCol), green(pipeCol), blue(pipeCol), 200);
                ellipse(px, py, 10, 10);
            }
        }
    }

    // フェーズ5：中央テキスト
    if (finalTextAlpha > 0) {
        noStroke();
        fill(0, finalTextAlpha * 0.85);
        rect(0, 0, width, height);
        textFont(createFont("Orbitron", 19));
        textAlign(CENTER, CENTER);
        fill(100, 220, 100, finalTextAlpha);
        textSize(36);
        text("BRUNHILDE SYSTEM :: ONLINE", width / 2, height / 2 - 20);
    }

    // フェーズ5：暗転
    if (blackoutAlpha > 0) {
        noStroke();
        fill(0, blackoutAlpha);
        rect(0, 0, width, height);
    }
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
