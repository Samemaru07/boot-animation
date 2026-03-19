// ============================================================
//  左下：システムログパネル
// ============================================================

void drawLogPanel(float px, float py, float pw, float ph) {
  panelTitle(px, py, pw, "[ SYSTEM LOG ]");
  float lx = px+10, startY = py+26, lineH = 14;
  int maxLines = (int)((ph-36)/lineH);
  int start = max(0, logs.size()-maxLines);
  for (int i = start; i < logs.size(); i++) {
    LogEntry e = logs.get(i);
    fill(e.col);
    textSize(8);
    textAlign(LEFT, TOP);
    text(e.msg, lx, startY+(i-start)*lineH);
  }
}
