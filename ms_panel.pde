// ============================================================
//  左上：MSシルエットパネル
// ============================================================

void drawMSPanel(float px, float py, float pw, float ph) {
    panelTitle(px, py, pw, "[ MARK ALLES :: FAFNER UPLINK ]");
    pushMatrix();
    translate(px + pw / 2, py + ph / 2 + 10);
    if (msOpacity > 0) {
        drawMSBody(msOpacity);
        drawEnergyMeter();
    }
    popMatrix();
}

void drawMSBody(float op) {
    noFill();
    strokeWeight(0.8);
    stroke(red(COL_MAIN), green(COL_MAIN), blue(COL_MAIN),
           flickerOpacity * op * 255);
    drawMSShapes();

    // 顔
    // strokeWeight(0.8);
    // stroke(252, 218, 126, op * 255);
    // noFill();
    // beginShape();
    // vertex(-6, -75.5);
    // vertex(0, -79.5);
    // vertex(6, -75.5);
    // endShape();

    // strokeWeight(0.8);
    // stroke(52, 213, 242, op * 255);
    // noFill();
    // beginShape();
    // vertex(-6, -75.5);
    // vertex(0, -68.5);
    // vertex(6, -75.5);
    // endShape();

    noFill();
    strokeWeight(0.8);
    stroke(red(COL_MAIN), green(COL_MAIN), blue(COL_MAIN),
           flickerOpacity * op * 255);
}

void drawMSShapes() {
    noFill();
    // 顔の部分
    // beginShape();
    // vertex(-6, -75.5);
    // vertex(6, -75.5);
    // endShape();

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

    // 頭部
    beginShape();
    vertex(0, -88);
    vertex(3, -82);
    vertex(6, -84);
    vertex(10, -92);
    vertex(16, -93);
    vertex(9, -82);
    vertex(14, -79);
    vertex(8, -76);
    vertex(7, -72);
    vertex(4, -70);
    vertex(0, -64);
    vertex(-4, -70);
    vertex(-7, -72);
    vertex(-8, -76);
    vertex(-14, -79);
    vertex(-9, -82);
    vertex(-16, -93);
    vertex(-10, -92);
    vertex(-6, -84);
    vertex(-3, -82);
    endShape(CLOSE);

    // 頭部：センター装飾
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

    // 背部スタビライザー：上部
    beginShape();
    vertex(1, -131);
    vertex(2, -89);
    endShape();
    beginShape();
    vertex(-1, -131);
    vertex(-2, -89);
    endShape();
    beginShape();
    vertex(1, -131);
    vertex(-1, -131);
    endShape();
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

    // 背部スタビライザー：下部
    beginShape();
    vertex(4, 0);
    vertex(1, 95);
    endShape();
    beginShape();
    vertex(-4, 0);
    vertex(-1, 95);
    endShape();
    beginShape();
    vertex(1, 95);
    vertex(-1, 95);
    endShape();

    // ファフナー右肩
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

    // ファフナー左肩
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

    // ファフナー右肩：装飾
    beginShape();
    vertex(47, -60);
    vertex(54, -64);
    vertex(56, -68);
    vertex(76, -82);
    endShape();
    beginShape();
    vertex(32, -73);
    vertex(30, -64);
    vertex(37, -64);
    vertex(67, -81);
    endShape();
    beginShape();
    vertex(31, -77);
    vertex(27, -77);
    vertex(22, -73);
    vertex(15, -69);
    endShape();

    // ファフナー左肩：装飾
    beginShape();
    vertex(-47, -60);
    vertex(-54, -64);
    vertex(-56, -68);
    vertex(-76, -82);
    endShape();
    beginShape();
    vertex(-32, -73);
    vertex(-30, -64);
    vertex(-37, -64);
    vertex(-67, -81);
    endShape();
    beginShape();
    vertex(-31, -77);
    vertex(-27, -77);
    vertex(-22, -73);
    vertex(-15, -69);
    endShape();

    // ファフナー右腕
    beginShape();
    vertex(45, -60);
    vertex(47, -63);
    vertex(52, -51);
    vertex(56, -45);
    vertex(63, -42);
    vertex(66, -47);
    vertex(67, -54);
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

    // ファフナー右腕：シールド
    beginShape();
    vertex(63, -42);
    vertex(60, -39);
    vertex(68, -17);
    vertex(76, 8);
    vertex(79, 8);
    endShape();
    beginShape();
    vertex(68, -17);
    vertex(76, 8);
    vertex(79, 8);
    vertex(75, -16);
    vertex(71, -17);
    endShape(CLOSE);
    beginShape();
    vertex(69, -60);
    vertex(76, -35);
    vertex(75, -31);
    vertex(81, -7);
    vertex(89, 0);
    endShape();

    // ファフナー左腕
    beginShape();
    vertex(-45, -60);
    vertex(-47, -63);
    vertex(-52, -51);
    vertex(-56, -45);
    vertex(-63, -42);
    vertex(-66, -47);
    vertex(-67, -54);
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

    // ファフナー左腕：シールド
    beginShape();
    vertex(-63, -42);
    vertex(-60, -39);
    vertex(-68, -17);
    vertex(-76, 8);
    vertex(-79, 8);
    endShape();
    beginShape();
    vertex(-68, -17);
    vertex(-76, 8);
    vertex(-79, 8);
    vertex(-75, -16);
    vertex(-71, -17);
    endShape(CLOSE);
    beginShape();
    vertex(-69, -60);
    vertex(-76, -35);
    vertex(-75, -31);
    vertex(-81, -7);
    vertex(-89, 0);
    endShape();

    // ファフナー右翼
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
    vertex(27, -100);
    vertex(30, -100);
    vertex(44, -117);
    endShape();
    beginShape();
    vertex(55, -58);
    bezierVertex(56, -55, 58, -51, 59, -47);
    endShape();
    beginShape();
    vertex(65, 12);
    bezierVertex(64, 23, 68, 35, 74, 49);
    bezierVertex(63, 38, 62, 30, 59, 20);
    vertex(59, 20);
    vertex(58, 21);
    vertex(55, 18);
    bezierVertex(49, 0, 48, -22, 35, -47);
    endShape();

    // ファフナー左翼
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
    vertex(-27, -100);
    vertex(-30, -100);
    vertex(-44, -117);
    endShape();
    beginShape();
    vertex(-55, -58);
    bezierVertex(-56, -55, -58, -51, -59, -47);
    endShape();
    beginShape();
    vertex(-65, 12);
    bezierVertex(-64, 23, -68, 35, -74, 49);
    bezierVertex(-63, 38, -62, 30, -59, 20);
    vertex(-59, 20);
    vertex(-58, 21);
    vertex(-55, 18);
    bezierVertex(-49, 0, -48, -22, -35, -47);
    endShape();

    // 翼：装飾ライン（ファフナー右）
    beginShape();
    vertex(61, 18);
    vertex(61, 11);
    endShape();
    beginShape();
    vertex(61, 20);
    vertex(59, 11);
    endShape();
    beginShape();
    vertex(58, 21);
    vertex(56, 7);
    endShape();
    beginShape();
    vertex(56, -4);
    vertex(50, -28);
    endShape();
    beginShape();
    vertex(54, -1);
    vertex(44, -45);
    endShape();
    beginShape();
    vertex(60, -4);
    vertex(56, -18);
    endShape();
    beginShape();
    vertex(41, -33);
    vertex(43, -33);
    vertex(47, -22);
    vertex(48, -22);
    endShape();

    // 翼：装飾ライン（ファフナー左）
    beginShape();
    vertex(-61, 18);
    vertex(-61, 11);
    endShape();
    beginShape();
    vertex(-61, 20);
    vertex(-59, 11);
    endShape();
    beginShape();
    vertex(-58, 21);
    vertex(-56, 7);
    endShape();
    beginShape();
    vertex(-56, -4);
    vertex(-50, -28);
    endShape();
    beginShape();
    vertex(-54, -1);
    vertex(-44, -45);
    endShape();
    beginShape();
    vertex(-60, -4);
    vertex(-56, -18);
    endShape();
    beginShape();
    vertex(-43, -33);
    vertex(-41, -33);
    vertex(-43, -33);
    vertex(-47, -22);
    vertex(-48, -22);
    endShape();

    // ファフナー右脚
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

    // ファフナー左脚
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

    // ファフナー右足
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
    beginShape();
    vertex(58, 68);
    vertex(65, 78);
    bezierVertex(66, 83, 67, 88, 65, 94);
    bezierVertex(60, 89, 55, 83, 55, 77);
    endShape(CLOSE);
    beginShape();
    vertex(75, 119);
    vertex(72, 104);
    vertex(69, 111);
    vertex(63, 106);
    vertex(67, 119);
    endShape();

    // ファフナー左足
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
    beginShape();
    vertex(-58, 68);
    vertex(-65, 78);
    bezierVertex(-66, 83, -67, 88, -65, 94);
    bezierVertex(-60, 89, -55, 83, -55, 77);
    endShape(CLOSE);
    beginShape();
    vertex(-75, 119);
    vertex(-72, 104);
    vertex(-69, 111);
    vertex(-63, 106);
    vertex(-67, 119);
    endShape();

    // ファフナー右膝
    beginShape();
    vertex(32, 12);
    vertex(37, 15);
    vertex(38, 12);
    vertex(44, 21);
    vertex(49, 39);
    vertex(47, 43);
    vertex(41, 41);
    vertex(30, 26);
    vertex(27, 16);
    vertex(31, 17);
    endShape(CLOSE);
    beginShape();
    vertex(31, 17);
    vertex(38, 31);
    vertex(42, 33);
    endShape();
    beginShape();
    vertex(37, 15);
    vertex(43, 29);
    vertex(42, 33);
    endShape();
    beginShape();
    vertex(36, 25);
    vertex(40, 27);
    vertex(40, 23);
    endShape();

    // ファフナー左膝
    beginShape();
    vertex(-32, 12);
    vertex(-37, 15);
    vertex(-38, 12);
    vertex(-44, 21);
    vertex(-49, 39);
    vertex(-47, 43);
    vertex(-41, 41);
    vertex(-30, 26);
    vertex(-27, 16);
    vertex(-31, 17);
    endShape(CLOSE);
    beginShape();
    vertex(-31, 17);
    vertex(-38, 31);
    vertex(-42, 33);
    endShape();
    beginShape();
    vertex(-37, 15);
    vertex(-43, 29);
    vertex(-42, 33);
    endShape();
    beginShape();
    vertex(-36, 25);
    vertex(-40, 27);
    vertex(-40, 23);
    endShape();

    // 腰：中央パーツ
    beginShape();
    vertex(2, -26);
    vertex(2, -17);
    vertex(0, -10);
    vertex(-2, -17);
    vertex(-2, -26);
    endShape(CLOSE);

    // 腹部ライン
    beginShape();
    vertex(6, -31);
    vertex(-5, -35);
    endShape();
    beginShape();
    vertex(-5, -35);
    vertex(5, -46);
    endShape();

    // 腰下：装飾
    beginShape();
    vertex(-1, 21);
    vertex(1, 21);
    endShape();

    // ファフナー右手
    beginShape();
    vertex(64, -4);
    vertex(68, 1);
    endShape();
    beginShape();
    vertex(65, -1);
    vertex(60, 4);
    vertex(55, 3);
    endShape();

    // ファフナー左手
    beginShape();
    vertex(-64, -4);
    vertex(-68, 1);
    endShape();
    beginShape();
    vertex(-65, -1);
    vertex(-60, 4);
    vertex(-55, 3);
    endShape();
}

void drawEnergyMeter() {
    noFill();
    stroke(COL_DIM);
    strokeWeight(0.5);
    rect(-18, 130, 36, 4, 1);
    if (energyBar > 0) {
        int barCol = lerpColor(COL_MAIN, COL_OK, energyBar / 36.0);
        noStroke();
        fill(red(barCol), green(barCol), blue(barCol), 180);
        rect(-18, 130, energyBar, 4, 1);
    }
    stroke(COL_BORDER);
    strokeWeight(0.3);
    for (int i = 0; i < 3; i++)
        line(-40, 136 + i * 5, 40, 136 + i * 5);
}
