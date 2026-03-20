// ============================================================
//  左上：MSシルエットパネル
// ============================================================

void drawMSPanel(float px, float py, float pw, float ph) {
    panelTitle(px, py, pw, "[ MS-00X :: MOBILE SUIT UPLINK ]");
    pushMatrix();
    translate(px + pw / 2, py + ph / 2 + 10);
    if (msOpacity > 0) {
        drawMSGlow();
        drawMSBody(msOpacity);
        if (funnelActive)
            drawFunnels(funnelT);
        drawEnergyMeter();
    }

    popMatrix();
}

void drawMSGlow() {
    noFill();
    strokeWeight(3);
    stroke(red(COL_MAIN), green(COL_MAIN), blue(COL_MAIN), 40);
    drawMSShapes();
}

void drawMSBody(float op) {
    noFill();
    strokeWeight(0.8);
    stroke(red(COL_MAIN), green(COL_MAIN), blue(COL_MAIN),
           flickerOpacity * op * 255);
    drawMSShapes();

    // 胸のコアサークル
    // noFill();
    // stroke(red(COL_ACCENT), green(COL_ACCENT), blue(COL_ACCENT), op * 220);
    // strokeWeight(1);
    // ellipse(0, -45, 6, 6);
    // noStroke();
    // fill(red(COL_ACCENT), green(COL_ACCENT), blue(COL_ACCENT), op * 200);
    // ellipse(0, -45, 2.4, 2.4);

    // 目
    // noFill();
    // stroke(68, 255, 255, op * 255);
    // strokeWeight(1.2);
    // line(-7, -78, -3, -78);
    // line(3, -78, 7, -78);

    // 胸ディテールライン
    // stroke(red(COL_CMD), green(COL_CMD), blue(COL_CMD), op * 180);
    // strokeWeight(0.5);
    // line(-6, -50, 6, -50);
    // line(-8, -42, 8, -42);
}

void drawMSShapes() {
    // ここの頂点座標を変えるとMSの形が変わります
    noFill();
    // 胴体
    beginShape();
    vertex(9, -49);
    vertex(15, -43);
    vertex(3, -30);
    vertex(7, -29);
    vertex(7, -27);
    vertex(9, -28);
    vertex(11, -26);
    vertex(11, -24);
    vertex(7, -20);
    vertex(5, -6);
    vertex(3, -3);
    vertex(0, 35);
    vertex(-3, -3);
    vertex(-5, -6);
    vertex(-7, -20);
    vertex(-11, -24);
    vertex(-11, -26);
    vertex(-7, -29);
    vertex(-7, -27);
    vertex(-5, -35);
    vertex(-14, -39);
    vertex(-13, -44);
    endShape();

    // 頭
    beginShape();
    vertex(0, -88);
    vertex(3, -82);
    vertex(6, -84);
    vertex(10, -92);
    vertex(16, -93);
    vertex(9, -82);
    vertex(14, -78);
    vertex(8, -76);
    vertex(7, -72);
    vertex(4, -70);
    vertex(0, -64);
    vertex(-4, -70);
    vertex(-7, -72);
    vertex(-8, -76);
    vertex(-14, -78);
    vertex(-9, -82);
    vertex(-16, -93);
    vertex(-10, -92);
    vertex(-6, -84);
    vertex(-3, -82);
    endShape(CLOSE);
    // 左腕側の翼
    beginShape();
    vertex(15, -85);
    vertex(18, -86);
    vertex(32, -108);
    vertex(32, -107);
    bezierVertex(33, -112, 44, -119, 50, -122);
    bezierVertex(38, -111, 38, -107, 38, -84);
    vertex(42, -81);
    endShape();
    beginShape();
    vertex(55, -58);
    bezierVertex(56, -55, 58, -51, 59, -47);
    endShape();
    beginShape();
    vertex(65, 12);
    bezierVertex(64, 23, 63, 35, 65, 46);
    bezierVertex(63, 38, 62, 30, 60, 20);
    vertex(59, 20);
    vertex(58, 21);
    vertex(55, 18);
    bezierVertex(49, 0, 48, -22, 41, -47);
    endShape();

    // ここからは左から
    beginShape();
    vertex(11, -72);
    vertex(8, -66);
    vertex(0, -56);
    vertex(-8, -66);
    vertex(-11, -72);
    endShape();
    beginShape();
    vertex(12, -60);
    vertex(7, -53);
    vertex(8, -51);
    vertex(10, -50);
    vertex(2, -46);
    vertex(4, -51);
    vertex(2, -50);
    vertex(0, -48);
    vertex(-2, -50);
    vertex(-4, -51);
    vertex(-2, -46);
    vertex(-10, -50);
    vertex(-8, -51);
    vertex(-7, -53);
    vertex(-12, -60);
    endShape();
    beginShape();
    vertex(31, -77);
    vertex(27, -77);
    vertex(22, -73);
    vertex(15, -69);
    endShape();
    // ここまで

    // 右腕側の翼
    beginShape();
    vertex(-15, -85);
    vertex(-18, -86);
    vertex(-32, -108);
    vertex(-32, -107);
    bezierVertex(-33, -112, -44, -119, -50, -122);
    bezierVertex(-38, -111, -38, -107, -38, -84);
    vertex(-42, -81);
    endShape();
    beginShape();
    vertex(-55, -58);
    bezierVertex(-56, -55, -58, -51, -59, -47);
    endShape();
    beginShape();
    vertex(-65, 12);
    bezierVertex(-64, 23, -63, 35, -65, 46);
    bezierVertex(-63, 38, -62, 30, -60, 20);
    vertex(-59, 20);
    vertex(-58, 21);
    vertex(-55, 18);
    bezierVertex(-49, 0, -48, -22, -41, -47);
    endShape();
    // 右腕側の翼の装飾
    beginShape();
    vertex(-31, -77);
    vertex(-27, -77);
    vertex(-22, -73);
    vertex(-15, -69);
    endShape();

    // なんか伸びるやつの線(区切り)

    // Vフィン左
    // beginShape();
    // vertex(-10, -96);
    // vertex(-16, -102);
    // vertex(-14, -90);
    // vertex(-10, -82);
    // endShape(CLOSE);
    // Vフィン右
    // beginShape();
    // vertex(10, -90);
    // vertex(16, -96);
    // vertex(14, -82);
    // vertex(10, -82);
    // endShape(CLOSE);
    // 腰
    // beginShape();
    // vertex(0, -14);
    // vertex(10, -10);
    // vertex(10, 0);
    // vertex(-10, 0);
    // vertex(-10, -10);
    // endShape(CLOSE);
    // 右腕
    beginShape();
    vertex(-45, -60);
    vertex(-47, -63);
    vertex(-52, -51);
    vertex(-56, -45);
    vertex(-63, -42);
    vertex(-66, -47);
    vertex(-67, -54);
    // TODO シールド外側
    vertex(-69, -60);
    bezierVertex(-85, -40, -87, -20, -89, 0);
    vertex(-84, 11);
    vertex(-79, 8);
    vertex(-76, 8);
    vertex(-75, 11);
    vertex(-72, 2);
    vertex(-72, 9);
    vertex(-68, 3);
    vertex(-66, 8);
    vertex(-59, 9);
    vertex(-57, 8);
    vertex(-54, 5);
    vertex(-55, 3);
    vertex(-56, 0);
    vertex(-56, 1);
    vertex(-59, 0);
    vertex(-61, -4);
    vertex(-63, -3);
    vertex(-63, -7);
    vertex(-60, -11);
    vertex(-60, -16);
    vertex(-55, -21);
    vertex(-54, -27);
    vertex(-50, -31);
    vertex(-49, -44);
    vertex(-45, -47);
    vertex(-38, -52);
    vertex(-40, -55);
    endShape(CLOSE);
    // 右腕シールド
    beginShape();
    vertex(-63, -42);
    vertex(-60, -39);
    vertex(-68, -17);
    vertex(-76, 8);
    vertex(-79, 8);
    endShape();
    // 右腕シールド装飾1
    beginShape();
    vertex(-68, -17);
    vertex(-76, 8);
    vertex(-79, 8);
    vertex(-75, -16);
    vertex(-71, -17);
    endShape(CLOSE);
    // 右腕シールド装飾2
    beginShape();
    vertex(-69, -60);
    vertex(-76, -35);
    vertex(-75, -31);
    vertex(-81, -7);
    vertex(-89, 0);
    endShape();
    // 左肩
    beginShape();
    vertex(79, -84);
    vertex(72, -80);
    vertex(73, -80);
    vertex(57, -63);
    vertex(48, -58);
    vertex(45, -60);
    vertex(39, -56);
    vertex(36, -49);
    vertex(30, -47);
    vertex(24, -53);
    vertex(22, -52);
    vertex(20, -53);
    vertex(11, -47);
    vertex(14, -63);
    vertex(21, -66);
    vertex(25, -73);
    vertex(44, -78);
    vertex(51, -78);
    endShape(CLOSE);
    // 右肩
    beginShape();
    vertex(-79, -84);
    vertex(-72, -80);
    vertex(-73, -80);
    vertex(-57, -63);
    vertex(-48, -58);
    vertex(-45, -60);
    vertex(-39, -56);
    vertex(-36, -49);
    vertex(-30, -47);
    vertex(-24, -53);
    vertex(-22, -52);
    vertex(-20, -53);
    vertex(-11, -47);
    vertex(-14, -63);
    vertex(-21, -66);
    vertex(-25, -73);
    vertex(-44, -78);
    vertex(-51, -78);
    endShape(CLOSE);
    // 左腕
    beginShape();
    vertex(45, -60);
    vertex(47, -63);
    vertex(52, -51);
    vertex(56, -45);
    vertex(63, -42);
    vertex(66, -47);
    vertex(67, -54);
    // TODO シールド外側
    vertex(69, -60);
    bezierVertex(85, -40, 87, -20, 89, 0);
    vertex(84, 11);
    vertex(79, 8);
    vertex(76, 8);
    vertex(75, 11);
    vertex(72, 2);
    vertex(72, 9);
    vertex(68, 3);
    vertex(66, 8);
    vertex(59, 9);
    vertex(57, 8);
    vertex(54, 5);
    vertex(55, 3);
    vertex(56, 0);
    vertex(56, 1);
    vertex(59, 0);
    vertex(61, -4);
    vertex(63, -3);
    vertex(63, -7);
    vertex(60, -11);
    vertex(60, -16);
    vertex(55, -21);
    vertex(54, -27);
    vertex(50, -31);
    vertex(49, -44);
    vertex(45, -47);
    vertex(38, -52);
    vertex(40, -55);
    endShape(CLOSE);
    // 左腕シールド
    beginShape();
    vertex(63, -42);
    vertex(60, -39);
    vertex(68, -17);
    vertex(76, 8);
    vertex(79, 8);
    endShape();
    // 左腕シールド装飾1
    beginShape();
    vertex(68, -17);
    vertex(76, 8);
    vertex(79, 8);
    vertex(75, -16);
    vertex(71, -17);
    endShape(CLOSE);
    // 左腕シールド装飾2
    beginShape();
    vertex(69, -60);
    vertex(76, -35);
    vertex(75, -31);
    vertex(81, -7);
    vertex(89, 0);
    endShape();
    // 左脚
    beginShape();
    vertex(9, -16);
    vertex(13, -17);
    vertex(12, -20);
    vertex(12, -22);
    vertex(21, -20);
    vertex(24, -21);
    vertex(29, -16);
    vertex(26, -14);
    vertex(31, -9);
    vertex(31, -2);
    vertex(35, 0);
    vertex(34, 5);
    vertex(38, 8);
    vertex(41, 14);
    vertex(50, 16);
    vertex(48, 23);
    vertex(49, 25);
    vertex(56, 39);
    vertex(55, 43);
    vertex(59, 47);
    vertex(66, 51);
    vertex(63, 55);
    vertex(65, 64);
    vertex(63, 55);
    vertex(70, 84);
    vertex(76, 90);
    vertex(77, 109);
    vertex(77, 118);
    vertex(73, 122);
    vertex(64, 119);
    vertex(60, 110);
    vertex(52, 92);
    vertex(55, 87);
    vertex(50, 71);
    vertex(49, 65);
    vertex(47, 66);
    vertex(41, 61);
    vertex(44, 57);
    vertex(41, 55);
    vertex(39, 46);
    vertex(37, 46);
    vertex(30, 31);
    vertex(27, 27);
    vertex(26, 18);
    vertex(19, 16);
    vertex(21, 11);
    vertex(23, 9);
    vertex(19, 6);
    vertex(18, 0);
    vertex(12, -2);
    vertex(15, -9);
    vertex(8, -7);
    endShape(CLOSE);
    // 右脚
    beginShape();
    vertex(-9, -16);
    vertex(-13, -17);
    vertex(-12, -20);
    vertex(-12, -22);
    vertex(-21, -20);
    vertex(-24, -21);
    vertex(-29, -16);
    vertex(-26, -14);
    vertex(-31, -9);
    vertex(-31, -2);
    vertex(-35, 0);
    vertex(-34, 5);
    vertex(-38, 8);
    vertex(-41, 14);
    vertex(-50, 16);
    vertex(-48, 23);
    vertex(-49, 25);
    vertex(-56, 39);
    vertex(-55, 43);
    vertex(-59, 47);
    vertex(-66, 51);
    vertex(-63, 55);
    vertex(-65, 64);
    vertex(-63, 55);
    vertex(-70, 84);
    vertex(-76, 90);
    vertex(-77, 109);
    vertex(-77, 118);
    vertex(-73, 122);
    vertex(-64, 119);
    vertex(-60, 110);
    vertex(-52, 92);
    vertex(-55, 87);
    vertex(-50, 71);
    vertex(-49, 65);
    vertex(-47, 66);
    vertex(-41, 61);
    vertex(-44, 57);
    vertex(-41, 55);
    vertex(-39, 46);
    vertex(-37, 46);
    vertex(-30, 31);
    vertex(-27, 27);
    vertex(-26, 18);
    vertex(-19, 16);
    vertex(-21, 11);
    vertex(-23, 9);
    vertex(-19, 6);
    vertex(-18, 0);
    vertex(-12, -2);
    vertex(-15, -9);
    vertex(-8, -7);
    endShape(CLOSE);
    // 右足
    beginShape();
    vertex(-58, 68);
    vertex(-70, 84);
    vertex(-76, 90);
    vertex(-77, 109);
    vertex(-77, 118);
    vertex(-73, 122);
    vertex(-64, 119);
    vertex(-60, 110);
    vertex(-52, 92);
    vertex(-55, 87);
    endShape(CLOSE);
    // 左足
    beginShape();
    vertex(58, 68);
    vertex(70, 84);
    vertex(76, 90);
    vertex(77, 109);
    vertex(77, 118);
    vertex(73, 122);
    vertex(64, 119);
    vertex(60, 110);
    vertex(52, 92);
    vertex(55, 87);
    endShape(CLOSE);

    // 背部スタビライザー(上部左側)
    beginShape();
    vertex(1, -131);
    vertex(2, -89);
    endShape();
    // 背部スタビライザー(上部右側)
    beginShape();
    vertex(-1, -131);
    vertex(-2, -89);
    endShape();
    beginShape();
    vertex(1, -131);
    vertex(-1, -131);
    endShape();
    // 背部スタビライザー(下部右側)
    beginShape();
    vertex(4, 0);
    vertex(1, 95);
    endShape();
    // 背部スタビライザー(下部左側)
    beginShape();
    vertex(-4, 0);
    vertex(-1, 95);
    endShape();
    beginShape();
    vertex(1, 95);
    vertex(-1, 95);
    endShape();
    // 背部スタビライザー装飾
    beginShape();
    vertex(2, -104);
    vertex(4, -104);
    vertex(4, -89);
    endShape();
    beginShape();
    vertex(-2, -104);
    vertex(-4, -104);
    vertex(-4, -89);
    endShape();
}

void drawFunnels(float t) {
    noFill();
    stroke(red(COL_MAIN), green(COL_MAIN), blue(COL_MAIN), msOpacity * 200);
    strokeWeight(0.5);
    // {x, y, w, h, 角度, 時間係数}
    float[][] f = {
        {-44, -64, 8, 14, -15, t * 1.0},
        {44, -64, 8, 14, 15, t * 1.1},
        {-50, -40, 6, 12, -20, t * 0.9},
        {50, -40, 6, 12, 20, t * 1.2},
    };
    for (float[] fn : f) {
        pushMatrix();
        translate(fn[0], fn[1] + sin(fn[5]) * 3);
        rotate(radians(fn[4] + sin(fn[5]) * 5));
        rect(-fn[2] / 2, -fn[3] / 2, fn[2], fn[3], 1);
        popMatrix();
    }
}

void drawEnergyMeter() {
    noFill();
    stroke(COL_DIM);
    strokeWeight(0.5);
    rect(-18, 68, 36, 4, 1);
    if (energyBar > 0) {
        int barCol = lerpColor(COL_MAIN, COL_OK, energyBar / 36.0);
        noStroke();
        fill(red(barCol), green(barCol), blue(barCol), 180);
        rect(-18, 68, energyBar, 4, 1);
    }
    stroke(COL_BORDER);
    strokeWeight(0.3);
    for (int i = 0; i < 3; i++)
        line(-40, 74 + i * 5, 40, 74 + i * 5);
}
