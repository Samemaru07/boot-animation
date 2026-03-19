// ============================================================
//  右下：CLIパネル＋パスワード入力
// ============================================================

void drawCLIPanel(float px, float py, float pw, float ph) {
  panelTitle(px, py, pw, "[ COMMAND INTERFACE ]");
  float lx = px+10, startY = py+26, lineH = 14;
  int maxLines = (int)((ph-60)/lineH);
  int start = max(0, cliLines.size()-maxLines);
  for (int i = start; i < cliLines.size(); i++) {
    LogEntry e = cliLines.get(i);
    fill(e.col);
    textSize(9);
    textAlign(LEFT, TOP);
    text(e.msg, lx, startY+(i-start)*lineH);
  }

  // パスワード入力欄
  if (pwVisible) {
    float iy = py+ph-52;
    fill(COL_CMD);
    textSize(9);
    textAlign(LEFT, TOP);
    text("ACCESS CODE :", lx, iy);
    fill(COL_MAIN);
    text("> "+"*".repeat(pwInput.length())+(frameCount%60<30?"_":""), lx, iy+14);
  }
}
