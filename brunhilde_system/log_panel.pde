// ============================================================
//  左下：システムログパネル
// ============================================================

void drawLogPanel(float px, float py, float pw, float ph) {
    panelTitle(px, py, pw, "[ SYSTEM LOG ]");

    float leftW = pw * 0.55;
    float rightX = px + leftW + 10;
    float startY = py + 26;
    float lineH = 16;

    // 左：ログ
    float lx = px + 10;
    int maxLines = (int)((ph - 36) / lineH);
    int start = max(0, logs.size() - maxLines);
    for (int i = start; i < logs.size(); i++) {
        LogEntry e = logs.get(i);
        fill(e.col);
        textSize(11);
        textAlign(LEFT, TOP);
        text(e.msg, lx, startY + (i - start) * lineH);
    }

    // 縦区切り線
    stroke(COL_BORDER);
    strokeWeight(1);
    line(px + leftW, py + 24, px + leftW, py + ph - 8);

    // 右：コンポーネントステータス
    fill(COL_TITLE);
    textSize(11);
    textAlign(LEFT, TOP);
    text("COMPONENT STATUS", rightX, startY);

    stroke(COL_BORDER);
    strokeWeight(0.5);
    line(rightX, startY + 16, px + pw - 10, startY + 16);

    for (int i = 0; i < compNames.length; i++) {
        float rowY = startY + 24 + i * 22;

        // コンポーネント名
        fill(COL_DIM);
        textSize(10);
        textAlign(LEFT, TOP);
        text(compNames[i], rightX, rowY);

        // ステータス（点滅処理）
        boolean blink =
            compStatus[i].equals("BOOTING") && (frameCount / 30 % 2 == 0);
        if (!blink) {
            fill(compColors[i]);
            textAlign(RIGHT, TOP);
            text(compStatus[i], px + pw - 10, rowY);
        }
    }
}
