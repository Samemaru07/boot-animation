// ============================================================
//  右上：PCパネル
// ============================================================

void drawPCPanel(float px, float py, float pw, float ph) {
    panelTitle(px, py, pw, "[ ALVIS CDC TERMINAL ]");
    float cx = px + pw / 2 - 100;
    float cy = py + ph / 2;
    pushMatrix();
    translate(cx, cy);
    drawPCCase(px, py, pw, ph);
    drawPCLabels(msOpacity);
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

    // === CPUクーラー（サイドフロー型） ===
    stroke(COL_MAIN);
    strokeWeight(1.2);
    noFill();

    // ヒートシンク本体（塔型・アイソメトリック直方体）
    // 正面
    beginShape();
    vertex(-65, -56);
    vertex(-35, -56);
    vertex(-35, -30);
    vertex(-65, -30);
    endShape(CLOSE);

    // 上面
    beginShape();
    vertex(-25, -65);
    vertex(-45, -65);
    vertex(-65, -56);
    endShape();

    // 右側面（変更なし）
    beginShape();
    vertex(-35, -56);
    vertex(-25, -65);
    vertex(-25, -40);
    vertex(-35, -30);
    endShape(CLOSE);

    // ファン外枠
    float cfX1 = -35, cfY1 = -54; // 左上
    float cfX2 = -25, cfY2 = -64; // 右上
    float cfX3 = -24, cfY3 = -40; // 右下
    float cfX4 = -35, cfY4 = -31; // 左下

    strokeWeight(1.5);
    beginShape();
    vertex(cfX1, cfY1);
    vertex(cfX2, cfY2);
    vertex(cfX3, cfY3);
    vertex(cfX4, cfY4);
    endShape(CLOSE);

    // ファン内部
    strokeWeight(0.8);
    float cfCX = (cfX1 + cfX3) / 2;
    float cfCY = (cfY1 + cfY3) / 2;

    // 円
    ellipse(cfCX, cfCY, 12, 22);

    // 十字
    float cfTopMX = (cfX1 + cfX2) / 2;
    float cfTopMY = (cfY1 + cfY2) / 2;
    float cfBotMX = (cfX4 + cfX3) / 2;
    float cfBotMY = (cfY4 + cfY3) / 2;
    float cfLeftMX = (cfX1 + cfX4) / 2;
    float cfLeftMY = (cfY1 + cfY4) / 2;
    float cfRightMX = (cfX2 + cfX3) / 2;
    float cfRightMY = (cfY2 + cfY3) / 2;

    line(cfTopMX, cfTopMY, cfBotMX, cfBotMY);
    line(cfLeftMX, cfLeftMY, cfRightMX, cfRightMY);

    // 対角線
    line(cfX1, cfY1, cfX3, cfY3);
    line(cfX2, cfY2, cfX4, cfY4);

    // === デバッグ：マウス座標表示 ===
    float mx = mouseX - (px + pw / 2 - 100); // パネル中心からの相対座標
    float my = mouseY - (py + ph / 2);
    fill(255, 255, 255);
    noStroke();
    textSize(10);
    textAlign(LEFT, TOP);
    text((int)mx + ", " + (int)my, mx + 5, my);
}

void drawPCLabels(float op) {
    // ===== BRUNHILDE SYSTEM =====
    float bsX = -350; // 左端X
    float bsY = -270; // 上端Y
    float bsW = 330;  // 幅
    float bsH = 130;  // 高さ

    stroke(255, 170, 50, op * 255);
    strokeWeight(1.0);
    noFill();

    // 枠
    rect(bsX, bsY, bsW, bsH, 1);

    // タイトル下線
    line(bsX, bsY + 26, bsX + bsW, bsY + 26);

    // テキスト
    textFont(createFont("Orbitron", 19));
    textAlign(LEFT, TOP);
    noStroke();

    // タイトル
    fill(255, 170, 50, op * 255);
    textSize(21);
    text("BRUNHILDE SYSTEM", bsX + 8, bsY + 4);

    // STATUS
    fill(255, 200, 0, op * 255);
    textSize(14);
    text("STATUS : RESTRICTED", bsX + 8, bsY + 33);

    // ALERT（赤色・点滅）
    if (frameCount % 60 < 45) {
        fill(255, 50, 50, op * 255);
    } else {
        fill(255, 50, 50, op * 60);
    }
    text("ALERT  : TYPE-1", bsX + 8, bsY + 51);

    // ◆の代わりに小さい四角（点滅）
    if (frameCount % 60 < 45) {
        fill(255, 50, 50, op * 255);
    } else {
        fill(255, 50, 50, op * 60);
    }
    noStroke();
    rect(bsX + bsW - 22, bsY + 53, 8, 8);

    // MODE
    fill(255, 80, 80, op * 255);
    text("MODE   : DEFENCE MODE", bsX + 8, bsY + 69);

    // 詳細情報
    fill(255, 170, 50, op * 180);
    textSize(13);
    text("MAIN PWR LOST. RUNNING ON AUX PWR.", bsX + 20, bsY + 87);
    text("OP LIMIT 10MIN. NACHTHERE LOCKED.", bsX + 20, bsY + 99);

    // 各ブロック名称
    noFill();
    int partsNameFontSize = 13;
    int roleNameFontSize = 19;
    int managerNameFontSize = 12;

    // ===== CPU =====
    float cpuX1 = -35, cpuY1 = -53; // 起点（部品上）
    float cpuX2 = 29, cpuY2 = -219; // 折れ点
    float cpuX3 = 60, cpuY3 = -219; // 終点

    // 折れ線
    stroke(255, 170, 50, op * 255);
    strokeWeight(1.2);
    beginShape();
    vertex(cpuX1, cpuY1);
    vertex(cpuX2, cpuY2);
    vertex(cpuX3, cpuY3);
    endShape();

    // 枠線
    stroke(255, 170, 50, op * 255);
    beginShape();
    vertex(cpuX3 - 10, cpuY3 - 6);
    vertex(cpuX3 + 165, cpuY3 - 6);
    endShape();

    fill(255, 170, 50, op * 255);
    noStroke();
    textAlign(LEFT, TOP);
    textSize(partsNameFontSize);
    text("CPU", cpuX3 - 10, cpuY3 - 45);
    textSize(roleNameFontSize);
    text("Siegfried System", cpuX3 - 10, cpuY3 - 30);
    textSize(managerNameFontSize);
    text("Sui Kaburagi", cpuX3 + 95, cpuY3);

    // ===== Motherboard =====
    noFill();
    stroke(255, 170, 50, op * 255);
    float motherX1 = -18, motherY1 = -55;
    float motherX2 = 151, motherY2 = -146;
    float motherX3 = motherX2 + 31, motherY3 = motherY2;

    // 折れ線
    beginShape();
    vertex(motherX1, motherY1);
    vertex(motherX2, motherY2);
    vertex(motherX3, motherY3);
    endShape();

    // 枠線
    beginShape();
    vertex(motherX3 - 10, motherY3 - 6);
    vertex(motherX3 + 232, motherY3 - 6);
    endShape();

    // テキスト
    textSize(partsNameFontSize);
    text("Motherboard", motherX3 - 10, motherY3 - 45);

    textSize(roleNameFontSize);
    text("CDC Integrated Platform", motherX3 - 10, motherY3 - 30);

    textSize(managerNameFontSize);
    text("Fumihiko Makabe", motherX3 + 140, motherY3);

    // ===== GPU =====
    float gpuX1 = 4, gpuY1 = -5;
    float gpuX2 = 151, gpuY2 = -73;
    float gpuX3 = gpuX2 + 31, gpuY3 = gpuY2;

    // 折れ線
    beginShape();
    vertex(gpuX1, gpuY1);
    vertex(gpuX2, gpuY2);
    vertex(gpuX3, gpuY3);
    endShape();

    // 枠線
    beginShape();
    vertex(gpuX3 - 10, gpuY3 - 6);
    vertex(gpuX3 + 370, gpuY3 - 6);
    endShape();

    // テキスト
    textSize(partsNameFontSize);
    text("Graphics Card", gpuX3 - 10, gpuY3 - 45);

    textSize(roleNameFontSize);
    text("Video Control / Urd Auxiliary System", gpuX3 - 10, gpuY3 - 30);

    textSize(managerNameFontSize);
    text("Masaki Tatekami", gpuX3 + 275, gpuY3);

    // ===== RAM =====
    float ramX1 = -4, ramY1 = -44;
    float ramX2 = 2, ramY2 = 0;
    float ramX3 = motherX3, ramY3 = ramY2;

    // 折れ線
    beginShape();
    vertex(ramX1, ramY1);
    vertex(ramX2, ramY2);
    vertex(ramX3, ramY3);
    endShape();

    // 枠線
    beginShape();
    vertex(ramX3 - 10, ramY3 - 6);
    vertex(ramX3 + 252, ramY3 - 6);
    endShape();

    // テキスト
    textSize(partsNameFontSize);
    text("RAM Disk", ramX3 - 10, ramY3 - 45);

    textSize(roleNameFontSize);
    text("Solomon's Buffer Memory", ramX3 - 10, ramY3 - 30);

    textSize(managerNameFontSize);
    text("Kiyomi Kaname", ramX3 + 168, ramY3);

    // ===== Storage =====
    float stX1 = -75, stY1 = -39;
    float stX2 = 8, stY2 = 70;
    float stX3 = motherX3, stY3 = stY2;

    // 折れ線
    beginShape();
    vertex(stX1, stY1);
    vertex(stX2, stY2);
    vertex(stX3, stY3);
    endShape();

    // 枠線
    beginShape();
    vertex(stX3 - 10, stY3 - 6);
    vertex(stX3 + 124, stY3 - 6);
    endShape();

    // テキスト
    textSize(partsNameFontSize);
    text("Storage Disk", stX3 - 10, stY3 - 45);

    textSize(roleNameFontSize);
    text("All Alvis Data", stX3 - 10, stY3 - 30);

    textSize(managerNameFontSize);
    text("Kyosuke Mizoguchi", stX3 + 10, stY3);

    // ===== PSU（主電源） =====
    stroke(255, 170, 50, op * 255);
    strokeWeight(0.8);
    noFill();

    float psuOX = -320; // PSU原点X
    float psuOY = 200;  // PSU原点Y

    // 正面（横長の直方体）
    beginShape();
    vertex(psuOX, psuOY);
    vertex(psuOX + 120, psuOY);
    vertex(psuOX + 120, psuOY + 60);
    vertex(psuOX, psuOY + 60);
    endShape(CLOSE);

    // 上面
    beginShape();
    vertex(psuOX, psuOY);
    vertex(psuOX + 120, psuOY);
    vertex(psuOX + 140, psuOY - 20);
    vertex(psuOX + 20, psuOY - 20);
    endShape(CLOSE);

    // 右側面
    beginShape();
    vertex(psuOX + 120, psuOY);
    vertex(psuOX + 140, psuOY - 20);
    vertex(psuOX + 140, psuOY + 40);
    vertex(psuOX + 120, psuOY + 60);
    endShape(CLOSE);

    // 正面：ファン（大型）
    strokeWeight(1.5);
    rect(psuOX + 5, psuOY + 5, 50, 50, 2);
    strokeWeight(0.8);
    ellipse(psuOX + 30, psuOY + 30, 40, 40);
    line(psuOX + 30, psuOY + 10, psuOX + 30, psuOY + 50);
    line(psuOX + 10, psuOY + 30, psuOX + 50, psuOY + 30);
    line(psuOX + 16, psuOY + 16, psuOX + 44, psuOY + 44);
    line(psuOX + 44, psuOY + 16, psuOX + 16, psuOY + 44);

    // 正面：コネクタパネル
    rect(psuOX + 62, psuOY + 5, 50, 50, 1);
    // コネクタ穴
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 2; j++) {
            rect(psuOX + 66 + i * 15, psuOY + 9 + j * 20, 10, 14, 1);
        }
    }

    // 正面：電源スイッチ
    ellipse(psuOX + 75, psuOY + 49, 6, 6);
    // ステータスLED（赤点滅）
    if (frameCount % 60 < 30) {
        fill(255, 0, 0, op * 255);
        noStroke();
    } else {
        fill(255, 0, 0, op * 80);
        noStroke();
    }
    ellipse(psuOX + 93, psuOY + 49, 6, 6);

    // 上面：通気スリット
    stroke(255, 170, 50, op * 255);
    strokeWeight(0.5);
    for (int i = 0; i < 5; i++) {
        line(psuOX + 25 + i * 18, psuOY - 18, psuOX + 35 + i * 18, psuOY - 18);
    }

    // ラベル
    fill(255, 170, 50, op * 255);
    noStroke();
    textFont(createFont("Orbitron", 19));
    textAlign(LEFT, TOP);
    textSize(partsNameFontSize);
    text("Power Supply Unit", psuOX, psuOY + 70);
    textSize(roleNameFontSize);
    text("MAIN POWER SUPPLY", psuOX, psuOY + 88);
    textSize(managerNameFontSize);
    // 切断状態の表示（赤点滅）
    if (frameCount % 60 < 30) {
        fill(255, 0, 0, op * 255);
    } else {
        fill(255, 0, 0, op * 80);
    }
    text("[ DISCONNECTED ]", psuOX, psuOY + 115);

    // ===== SYSTEM LINK STATUS =====
    float slX = 120; // 左端X
    float slY = 130; // 上端Y
    float slH = 18;  // 行間

    textFont(createFont("Orbitron", 19));
    textAlign(LEFT, TOP);

    // タイトル
    fill(255, 170, 50, op * 255);
    noStroke();
    textSize(roleNameFontSize);
    text("SYSTEM LINK STATUS", slX, slY);

    // タイトル下線
    stroke(255, 170, 50, op * 255);
    strokeWeight(1.2);
    line(slX, slY + 22, slX + 220, slY + 22);

    // 接続リスト
    noStroke();
    textSize(managerNameFontSize);

    String[][] links = {
        {"CPU", "AMD Ryzen 7 5700X"},
        {"MB", "ASUS TUF Gaming B550 Plus"},
        {"GPU", "NVIDIA GeForce RTX 5060Ti"},
        {"RAM", "Crucial PRO DDR4-3200 16×2 [GB]"},
        {"STORAGE", "WD_BLACK SN7100 M.2 PCIe Gen4 1 [TB]"},
    };

    for (int i = 0; i < links.length; i++) {
        float y = slY + 30 + i * slH;

        // [ OK ]
        fill(100, 220, 100, op * 255);
        text("[ OK ]", slX, y);

        // 部品名
        fill(255, 170, 50, op * 255);
        text(links[i][0], slX + 45, y);

        // ドット
        fill(255, 170, 50, op * 120);
        text("...........", slX + 95, y);

        // 役割名
        fill(255, 170, 50, op * 255);
        text(links[i][1], slX + 155, y);
    }

    // PSU（切断・赤点滅）
    float psuLY = slY + 30 + links.length * slH;

    if (frameCount % 60 < 30) {
        fill(255, 0, 0, op * 255);
    } else {
        fill(255, 0, 0, op * 80);
    }
    text("[ NO ]", slX, psuLY);

    fill(255, 170, 50, op * 255);
    text("PSU", slX + 45, psuLY);

    fill(255, 170, 50, op * 120);
    text("...........", slX + 95, psuLY);

    if (frameCount % 60 < 30) {
        fill(255, 0, 0, op * 255);
    } else {
        fill(255, 0, 0, op * 80);
    }
    text("Main Power Supply", slX + 155, psuLY);

    // ===== PSU 切断線 =====
    noFill();

    float psuX1 = -175, psuY1 = 208; // 始点
    float psuX2 = -88, psuY2 = 208;  // 曲がる点
    float cutX1 = -88, cutY1 = 155;  // 断線直前
    float cutX = -86, cutY = 149;    // 断線点
    float cutX2 = -88, cutY2 = 123;  // 断線直後
    float endX = -88, endY = 84;     // PCケース接続点

    // 接続線（PSU → 断線点）
    stroke(255, 50, 50, op * 255);
    strokeWeight(5);
    beginShape();
    vertex(psuX1, psuY1);
    vertex(psuX2, psuY2);
    vertex(cutX1, cutY1);
    endShape();

    // 断線マーク（//）
    stroke(255, 50, 50, op * 255);
    strokeWeight(5);
    line(cutX - 15, cutY - 9, cutX + 15, cutY + 9);
    line(cutX - 14, cutY - 22, cutX + 17, cutY - 3);

    // 破線（断線点 → PCケース）
    stroke(255, 50, 50, op * 255); // 100 → 255
    strokeWeight(4);
    float dashLen = 0.20; // 破線の長さ割合
    float gapLen = 0.20;  // 隙間を広げる
    float t = 0;
    while (t < 1.0) {
        float t2 = min(t + dashLen, 1.0);
        float y1 = lerp(cutY2, endY, t);
        float y2 = lerp(cutY2, endY, t2);
        line(cutX2, y1, cutX2, y2);
        t += dashLen + gapLen;
    }
}
