// ============================================================
//  右下：CLIパネル＋パスワード入力
// ============================================================

void drawCLIPanel(float px, float py, float pw, float ph) {
    panelTitle(px, py, pw, "[ COMMAND INTERFACE ]");
    float lx = px + 10;
    float startY = py + 26;
    float lineH = 18;
    int maxLines = (int)((ph - 80) / lineH);
    int start = max(0, cliLines.size() - maxLines);
    for (int i = start; i < cliLines.size(); i++) {
        LogEntry e = cliLines.get(i);
        fill(e.col);
        textSize(12);
        textAlign(LEFT, TOP);
        text(e.msg, lx, startY + (i - start) * lineH);
    }

    // パスワード入力欄
    if (pwVisible) {
        float boxX = px + 10;
        float boxY = py + ph - 70;
        float boxW = pw - 20;
        float boxH = 50;

        // 枠線（点滅）
        if (frameCount % 60 < 45) {
            stroke(COL_CMD);
        } else {
            stroke(COL_DIM);
        }
        strokeWeight(1.5);
        noFill();
        rect(boxX, boxY, boxW, boxH, 2);

        // ラベル
        noStroke();
        fill(COL_CMD);
        textSize(10);
        textAlign(LEFT, TOP);
        text("ACCESS CODE", boxX + 8, boxY + 6);

        // 入力テキスト＋カーソル
        String cursor = (frameCount % 60 < 30) ? "_" : " ";
        fill(COL_MAIN);
        textSize(16);
        text("> " + "*".repeat(pwInput.length()) + cursor, boxX + 8, boxY + 22);
    }
}
