// ============================================================
//  右上：PCパネル
// ============================================================

void drawPCPanel(float px, float py, float pw, float ph) {
    panelTitle(px, py, pw, "[ ALVIS CDC TERMINAL ]");
    float cx = px + pw / 2;
    float cy = py + ph / 2;
    pushMatrix();
    translate(cx, cy);
    drawPCCase(px, py, pw, ph);
    popMatrix();
}

void drawPCCase(float px, float py, float pw, float ph) {
    // === 正面 ===
    stroke(COL_MAIN);
    strokeWeight(0.8);
    noFill();
    beginShape();
    vertex(-125, -100);
    vertex(60, -100);
    vertex(60, 80);
    vertex(-125, 80);
    endShape(CLOSE);

    // === 上面 ===
    beginShape();
    vertex(-125, -100);
    vertex(60, -100);
    vertex(90, -130);
    vertex(-85, -130);
    endShape(CLOSE);

    // === 右側面 ===
    beginShape();
    vertex(60, -100);
    vertex(90, -130);
    vertex(90, 45);
    vertex(60, 80);
    endShape(CLOSE);

    // === 正面：天板ライン ===
    line(-125, -80, 60, -80);
    line(60, -80, 90, -110);

    // === 正面：パネルライン ===
    line(-125, 50, 60, 50);
    line(60, 50, 90, 15);

    // === 足 ===
    beginShape();
    vertex(-120, 80);
    vertex(-120, 90);
    vertex(-100, 90);
    vertex(-100, 80);
    endShape();
    beginShape();
    vertex(-100, 90);
    vertex(-90, 80);
    endShape();

    beginShape();
    vertex(30, 80);
    vertex(30, 90);
    vertex(50, 90);
    vertex(50, 80);
    endShape();
    beginShape();
    vertex(50, 90);
    vertex(60, 80);
    endShape();
    beginShape();
    vertex(85, 50);
    vertex(85, 58);
    vertex(78, 58);
    endShape();
    beginShape();
    vertex(85, 58);
    vertex(90, 52);
    vertex(90, 47);
    endShape();

    // === グラフィックボード ===
    textFont(createFont("Orbitron", 19));
    textAlign(LEFT, TOP);
    textSize(9);
    text("GEFORCE RTX", -105, 8);

    beginShape();
    vertex(-85, -25);
    vertex(-105, 1);
    vertex(-9, 1);
    vertex(11, -25);
    endShape(CLOSE);
    beginShape();
    vertex(-105, 1);
    vertex(-105, 17);
    vertex(-9, 17);
    vertex(-9, 1);
    endShape(CLOSE);
    beginShape();
    vertex(-9, 17);
    vertex(11, -9);
    vertex(11, -25);
    endShape();

    // === マザボ ===
    beginShape();
    vertex(-85, -25);
    vertex(-85, -73);
    vertex(11, -73);
    vertex(11, -25);
    endShape(CLOSE);
    beginShape();
    vertex(11, -9);
    vertex(11, 15);
    vertex(-3, 15);
    endShape();
    beginShape();
    vertex(11, 15);
    vertex(12, 8);
    vertex(12, -74);
    vertex(11, -73);
    endShape();
    line(-85, -74, 12, -74);

    // === 底面 ===
    line(-125, 50, -95, 22);
    line(90, 15, 17, 15);

    // === ファン：マザボ右隣 ===
    stroke(COL_MAIN);
    strokeWeight(0.8);
    noFill();

    float fanX = 35;               // ファン左端X
    float fanW = 45;               // ファン幅
    float fanH = 40;               // ファン高さ
    float fanCX = fanX + fanW / 2; // ファン中心X
    float fanR = 35;               // ファン円の直径

    // 上ファン
    float fan1Y = -80;               // 上ファンの上端Y
    float fan1CY = fan1Y + fanH / 2; // 上ファン中心Y
    rect(fanX, fan1Y, fanW, fanH, 1);
    strokeWeight(1.5); // 枠を太く
    rect(fanX, fan1Y, fanW, fanH, 1);
    strokeWeight(0.8); // 中身は細いまま
    ellipse(fanCX, fan1CY, fanR, fanR);
    line(fanCX, fan1CY - fanR / 2, fanCX, fan1CY + fanR / 2);
    line(fanCX - fanR / 2, fan1CY, fanCX + fanR / 2, fan1CY);
    line(fanCX - fanR / 2, fan1CY - fanR / 2, fanCX + fanR / 2,
         fan1CY + fanR / 2);
    line(fanCX + fanR / 2, fan1CY - fanR / 2, fanCX - fanR / 2,
         fan1CY + fanR / 2);

    // 下ファン
    float fan2Y = fan1Y + fanH + 9; // 上ファンの直下に3px間隔
    float fan2CY = fan2Y + fanH / 2;
    rect(fanX, fan2Y, fanW, fanH, 1);
    strokeWeight(1.5); // 枠を太く
    rect(fanX, fan2Y, fanW, fanH, 1);
    strokeWeight(0.8); // 中身は細いまま
    ellipse(fanCX, fan2CY, fanR, fanR);
    line(fanCX, fan2CY - fanR / 2, fanCX, fan2CY + fanR / 2);
    line(fanCX - fanR / 2, fan2CY, fanCX + fanR / 2, fan2CY);
    line(fanCX - fanR / 2, fan2CY - fanR / 2, fanCX + fanR / 2,
         fan2CY + fanR / 2);
    line(fanCX + fanR / 2, fan2CY - fanR / 2, fanCX - fanR / 2,
         fan2CY + fanR / 2);

    // === ファン：左側面上部 ===
    float lFanX1 = -117, lFanY1 = -57; // 左上
    float lFanX2 = -93, lFanY2 = -76;  // 右上
    float lFanX3 = -93, lFanY3 = -38;  // 右下
    float lFanX4 = -117, lFanY4 = -15; // 左下

    stroke(COL_MAIN);
    strokeWeight(0.8);
    noFill();

    // 外枠
    strokeWeight(1.5);
    beginShape();
    vertex(lFanX1, lFanY1);
    vertex(lFanX2, lFanY2);
    vertex(lFanX3, lFanY3);
    vertex(lFanX4, lFanY4);
    endShape(CLOSE);
    strokeWeight(0.8);

    // 中心
    float lFanCX = (lFanX1 + lFanX3) / 2; // -105
    float lFanCY = (lFanY1 + lFanY3) / 2; // -47

    // 楕円（平行四辺形に合わせて縦長・少し傾いた形）
    float lFanW = abs(lFanX2 - lFanX1) * 0.8; // 幅
    float lFanH = abs(lFanY4 - lFanY1) * 0.8; // 高さ
    ellipse(lFanCX, lFanCY, lFanW, lFanH);

    // 対角線（4隅を結ぶ）
    line(lFanX1, lFanY1, lFanX3, lFanY3); // 左上 → 右下
    line(lFanX2, lFanY2, lFanX4, lFanY4); // 右上 → 左下

    // 十字（中心から上下・左右の辺の中点へ）
    // 上辺の中点
    float topMX = (lFanX1 + lFanX2) / 2;
    float topMY = (lFanY1 + lFanY2) / 2;
    // 下辺の中点
    float botMX = (lFanX4 + lFanX3) / 2;
    float botMY = (lFanY4 + lFanY3) / 2;
    // 左辺の中点
    float leftMX = (lFanX1 + lFanX4) / 2;
    float leftMY = (lFanY1 + lFanY4) / 2;
    // 右辺の中点
    float rightMX = (lFanX2 + lFanX3) / 2;
    float rightMY = (lFanY2 + lFanY3) / 2;

    line(topMX, topMY, botMX, botMY);
    line(leftMX, leftMY, rightMX, rightMY);

    // === RAM ===
    stroke(COL_MAIN);
    strokeWeight(2);
    noFill();

    // 奥のRAM（左）
    beginShape();
    vertex(-10, -70); // 左上
    vertex(-4, -73);  // 右上
    vertex(-4, -28);  // 右下
    vertex(-10, -25); // 左下
    endShape(CLOSE);

    // 手前のRAM（右）
    beginShape();
    vertex(-2, -70); // 左上
    vertex(4, -73);  // 右上
    vertex(4, -28);  // 右下
    vertex(-2, -25); // 左下
    endShape(CLOSE);

    // マザボに刺さっている部分（下端の線を太く）
    strokeWeight(2.0);
    line(-10, -25, -4, -28); // 奥のRAM下端
    line(-2, -25, 4, -28);   // 手前のRAM下端
    // === 正面：電源ボタン ===
    // ellipse(40, -88, 8, 8);

    // === 正面：ドライブベイ ===
    // rect(-45, -70, 55, 8, 1);
    // rect(-45, -58, 55, 8, 1);

    // === 正面：マザーボードエリア ===
    // rect(-45, -42, 90, 120, 1);

    // === 内部：CPU ===
    // stroke(COL_MAIN, 150);
    // strokeWeight(0.6);
    // rect(-35, -35, 25, 25, 1);
    // CPUピン
    // for (int i = 0; i < 4; i++) {
    //   line(-35, -35 + i * 8, -35 - 5, -35 + i * 8);
    //  line(-10, -35 + i * 8, -10 + 5, -35 + i * 8);
    // }
    // CPUファン
    // ellipse(-22, -22, 22, 22);
    // line(-22, -33, -22, -11);
    // line(-33, -22, -11, -22);

    // === 内部：GPU ===
    // rect(-42, 10, 75, 20, 1);
    // ellipse(-22, 20, 14, 14);
    // ellipse(0, 20, 14, 14);
    // ellipse(18, 20, 14, 14);

    // === 内部：RAM ===
    // stroke(COL_MAIN, 150);
    // rect(5, -35, 6, 45, 1);
    // rect(14, -35, 6, 45, 1);
    // rect(23, -35, 6, 45, 1);

    // === 電源ユニット（下部・正面） ===
    // stroke(COL_MAIN);
    // strokeWeight(0.8);
    // rect(-45, 55, 90, 35, 1);
    // 電源ファン
    // ellipse(-15, 72, 20, 20);
    // line(-15, 62, -15, 82);
    // line(-25, 72, -5, 72);

    // === 上面ディテール ===
    // stroke(COL_MAIN, 120);

    // === 右側面ディテール ===
    // スリット
    // for (int i = 0; i < 5; i++) {
    //    line(65, -80 + i * 20, 85, -105 + i * 20);
    //}
    // === デバッグ：マウス座標表示 ===
    float mx = mouseX - (px + pw / 2); // パネル中心からの相対座標
    float my = mouseY - (py + ph / 2);
    fill(255, 255, 255);
    noStroke();
    textSize(10);
    textAlign(LEFT, TOP);
    text((int)mx + ", " + (int)my, mx + 5, my);
}
