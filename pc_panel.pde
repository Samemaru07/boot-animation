// ============================================================
//  右上：PCステータスパネル
// ============================================================

void drawPCPanel(float px, float py, float pw, float ph) {
  panelTitle(px, py, pw, "[ TARGET :: PC-NODE ]");
  float lx = px+10, ly = py+28, lh = 16;

  // ここの文字列・項目を自由に変えてください
  specRow(lx, ly,      pw-20, "HOSTNAME", pcHostname, COL_MAIN);
  specRow(lx, ly+lh,   pw-20, "OS",       "ARCH LINUX", COL_MAIN);
  specRow(lx, ly+lh*2, pw-20, "KERNEL",   pcKernel, COL_MAIN);
  specRow(lx, ly+lh*3, pw-20, "CPU",      pcCPU, COL_MAIN);
  specRow(lx, ly+lh*4, pw-20, "POWER",    pcPower, pcPowerCol);
  specRow(lx, ly+lh*5, pw-20, "LINK",     pcLink, pcLinkCol);

  // プログレスバー
  noFill();
  stroke(progColor);
  strokeWeight(1);
  rect(px+4, py+ph-20, pw-8, 3);
  noStroke();
  fill(progColor);
  rect(px+4, py+ph-20, (pw-8)*(progWidth/100.0), 3);

  // ステータステキスト
  fill(COL_TITLE);
  textSize(8);
  textAlign(LEFT, BOTTOM);
  text(statusText, px+6, py+ph-4);
}

void specRow(float x, float y, float w, String label, String val, int vc) {
  fill(COL_DIM);
  textSize(9);
  textAlign(LEFT, TOP);
  text(label, x, y);
  fill(vc);
  textAlign(RIGHT, TOP);
  text(val, x+w, y);
  textAlign(LEFT, TOP);
}
