// ============================================================
// solomon.pde  —  SOLOMONシンボル描画
// 歯車＋六角形モチーフ・発光・回転
// ============================================================

float solomonAlpha = 0;
float solomonScale = 0;
float solomonGlow = 0;

void initSolomon() {
    solomonAlpha = 0;
    solomonScale = 0;
}

void drawSolomon() {
    float cx = WIN_W / 2.0;
    float cy = WIN_H / 2.0;

    // フェーズに応じたα
    float targetAlpha;
    if (ePhase == 0) {
        // フェードイン
        targetAlpha = 255;
    } else if (ePhase == 1) {
        // Phase 1：半透明に落ちていく
        targetAlpha = lerp(255, 80, phaseProgress(4.0));
    } else if (ePhase == 2) {
        // Phase 2：さらに薄く
        targetAlpha = 60;
    } else {
        // Phase 3：フラッシュ→消える
        targetAlpha = lerp(60, 0, phaseProgress(1.0));
    }
    solomonAlpha += (targetAlpha - solomonAlpha) * 0.08;

    // スケールアニメ（出現時）
    float targetScale = (ePhase == 0 && gTime < T_PHASE0 + 0.8)
                            ? map(gTime - T_PHASE0, 0, 0.8, 0.3, 1.0)
                            : 1.0;
    solomonScale += (targetScale - solomonScale) * 0.12;

    // 発光パルス
    solomonGlow = 0.6 + 0.4 * sin(gTime * TWO_PI * 0.4);

    pushMatrix();
    pushStyle();
    translate(cx, cy);
    scale(solomonScale);

    float a = solomonAlpha / 255.0;

    // ─── 外側220度の円弧 ─────────────────────────────────────
    noFill();
    stroke(255, 170, 50, 200 * a);
    strokeWeight(2.5);
    beginShape();
    for (int i = 0; i <= 40; i++) {
        float angle = radians(-200) + (radians(220) / 40) * i;
        vertex(cos(angle) * 145, sin(angle) * 130 - 85);
    }
    endShape();

    noStroke();
    for (int g = 6; g >= 1; g--) {
        float gr = g * 30.0;
        float alp = (30 - g * 4) * a * solomonGlow;
        fill(255, 200, 80, alp); // 黄色寄りに
        ellipse(0, 0, gr * 2, gr * 2);
    }

    // 円弧外周
    strokeWeight(2.5);
    noFill();
    stroke(255, 170, 50, 200 * a);

    // 左下
    fill(200, 80, 10, 140 * a); // 暗い赤茶
    beginShape();
    vertex(-137, -40);
    vertex(-145, -35);
    vertex(-148, -43);
    vertex(-163, -37);
    vertex(-172, -66);
    vertex(-192, -66);
    vertex(-192, -70);
    vertex(-187, -70);
    vertex(-187, -80);
    vertex(-182, -80);
    vertex(-182, -90);
    vertex(-145, -90);
    vertex(-144, -66);
    endShape(CLOSE);

    // 右下
    beginShape();
    vertex(137, -40);
    vertex(145, -35);
    vertex(150, -49);
    vertex(158, -46);
    vertex(155, -38);
    vertex(161, -36);
    vertex(167, -51);
    vertex(179, -47);
    vertex(184, -59);
    vertex(175, -63);
    vertex(179, -81);
    vertex(185, -80);
    vertex(187, -90);
    vertex(145, -90);
    vertex(145, -90);
    vertex(144, -66);
    endShape();

    // SOLOMON 左
    fill(255, 150, 20, 180 * a);
    beginShape();
    vertex(-192, -97);
    vertex(-235, -97);
    vertex(-235, -102);
    vertex(-230, -102);
    vertex(-230, -112);
    vertex(-235, -112);
    vertex(-235, -111);
    vertex(-235, -114);
    vertex(-243, -114);
    vertex(-243, -119);
    vertex(-192, -119);
    endShape(CLOSE);
    noFill();

    // 上
    fill(255, 170, 50, 230 * a);
    strokeWeight(6);
    beginShape();
    vertex(120, -158);
    vertex(109, -172);
    vertex(80, -194);
    vertex(43, -209);
    vertex(11, -215);
    vertex(-11, -215);
    vertex(-43, -209);
    vertex(-80, -194);
    vertex(-109, -172);
    vertex(-120, -158);
    vertex(-175, -158);
    bezierVertex(-175, -158, -164, -173, -152, -188);
    vertex(-156, -192);
    vertex(-140, -210);
    vertex(-134, -206);
    vertex(-111, -227);
    vertex(-114, -231);
    vertex(-104, -240);
    vertex(-116, -257);
    vertex(-110, -263);
    vertex(-102, -253);
    vertex(-94, -259);
    vertex(-97, -265);
    vertex(-91, -270);
    vertex(-80, -250);
    bezierVertex(-43, -265, 5, -267, 41, -257);
    vertex(46, -265);
    vertex(62, -259);
    vertex(65, -264);
    vertex(83, -257);
    vertex(79, -244);
    vertex(103, -233);
    vertex(109, -242);
    vertex(118, -237);
    vertex(113, -226);
    vertex(131, -212);
    vertex(145, -227);
    vertex(151, -222);
    vertex(147, -217);
    vertex(151, -214);
    vertex(141, -203);
    bezierVertex(155, -187, 168, -170, 175, -158);
    endShape();

    beginShape();
    vertex(120, -158);
    vertex(175, -158);
    endShape();

    // SOLOMON 右
    fill(255, 150, 20, 180 * a);
    beginShape();
    vertex(192, -97);
    vertex(230, -97);
    vertex(230, -102);
    vertex(230, -112);
    vertex(235, -112);
    vertex(235, -111);
    vertex(235, -114);
    vertex(243, -114);
    vertex(243, -119);
    vertex(192, -119);
    endShape(CLOSE);
    noFill();

    // ─── 中央半円─────────────────────────────────────
    fill(255, 150, 20, 180 * a);
    stroke(255, 170, 50, 230 * a);
    strokeWeight(2);
    beginShape();
    vertex(-130, -85);
    vertex(130, -85);
    for (int i = 0; i <= 20; i++) {
        float angle = TWO_PI - (PI / 20) * i;
        vertex(cos(angle) * 130, sin(angle) * 110 - 85);
    }
    endShape(CLOSE);

    // ─── "SOLOMON" テキスト背景 ──────────────────────────────
    noStroke();
    fill(10, 5, 0, 200 * a);
    rect(-190, -155, 380, 70);

    // ─── "SOLOMON" テキスト ──────────────────────────────────
    textFont(fontOrbitron);
    textSize(75);
    textAlign(CENTER, CENTER);

    // テキストグロー
    for (int t = 4; t >= 1; t--) {
        fill(255, 230, 200, 40 * a * solomonGlow);
        text("SOLOMON", t * 2, -125);
        text("SOLOMON", -t * 2, -125);
        text("SOLOMON", 0, t * 2 - 125);
        text("SOLOMON", 0, -t * 2 - 125);
    }
    fill(255, 60, 20, 255 * a);
    text("SOLOMON", 0, -125);

    // ─── 中央垂直ステム ──────────────────────────────────────
    fill(255, 170, 50, 230 * a);
    strokeWeight(5);
    stroke(255, 170, 50, 200 * a);
    beginShape();
    // vertex(-65, -73);
    vertex(-38, -73);
    vertex(38, -73);
    vertex(88, -33);
    vertex(60, 8);
    vertex(-60, 8);
    vertex(-88, -33);
    vertex(-38, -73);
    endShape();

    beginShape();
    vertex(-15, 21);
    vertex(15, 21);
    vertex(15, 125);
    vertex(10, 125);
    vertex(10, 135);
    vertex(-5, 135);
    vertex(-5, 145);
    vertex(-8, 145);
    vertex(-8, 135);
    vertex(-15, 130);
    vertex(-15, 21);
    endShape();

    // 左上
    beginShape();
    vertex(-105, -58);
    vertex(-85, -73);
    vertex(-53, -73);
    vertex(-93, -42);
    vertex(-105, -58);
    endShape();

    // 右上
    beginShape();
    vertex(105, -58);
    vertex(85, -73);
    vertex(53, -73);
    vertex(93, -42);
    vertex(105, -58);
    endShape();

    // ─── 光の筋（放射） ───────────────────────────────────────
    float[][] glowPoints = {
        {-91, -270},  // 左上
        {82, -255},   // 右上
        {-243, -114}, // 左タブ端
        {243, -114},  // 右タブ端
        {-192, -66},  // 左下端
        {192, -66},   // 右下端
        {-88, -33},   // 左下ステム
        {88, -33},    // 右下ステム
        {0, 135},     // ステム下端
        {-241, -118}, {-226, -101}, {-218, -99},  {144, -36},   {177, -49},
        {244, -121},  {230, -95},   {153, -216},  {147, -219},  {146, -227},
        {120, -236},  {108, -224},  {62, -262},   {44, -268},   {-98, -259},
        {-101, -258}, {-107, -262}, {-117, -258}, {-105, -243}, {-141, -201},
        {-156, -194}, {12, 123},    {-12, 119}};

    for (int p = 0; p < glowPoints.length; p++) {
        float px = glowPoints[p][0];
        float py = glowPoints[p][1];
        float dx = px - 0;
        float dy = py + 85;
        float len = sqrt(dx * dx + dy * dy);
        dx /= len;
        dy /= len;
        // 垂直方向（筋の幅方向）
        float nx = -dy;
        float ny = dx;

        float glowLen = 70;
        float baseWidth = 18; // 根元の幅
        int steps = 20;
        for (int s = 0; s < steps; s++) {
            float t0 = (float)s / steps;
            float t1 = (float)(s + 1) / steps;
            float w0 = baseWidth * t0;
            float w1 = baseWidth * t1;
            float segAlpha = (1.0 - t0) * 30 * a;
            noStroke();
            fill(255, 200, 100, segAlpha);
            beginShape();
            vertex(px + dx * glowLen * t0 + nx * w0,
                   py + dy * glowLen * t0 + ny * w0);
            vertex(px + dx * glowLen * t0 - nx * w0,
                   py + dy * glowLen * t0 - ny * w0);
            vertex(px + dx * glowLen * t1 - nx * w1,
                   py + dy * glowLen * t1 - ny * w1);
            vertex(px + dx * glowLen * t1 + nx * w1,
                   py + dy * glowLen * t1 + ny * w1);
            endShape(CLOSE);
        }
    }

    popStyle();
    popMatrix();
}

// 歯車を描く
void drawGear(float x, float y, float innerR, float outerR, int teeth,
              float a) {
    pushStyle();
    stroke(255, 170, 50, 180 * a);
    strokeWeight(1.5);
    fill(255, 120, 20, 30 * a);

    beginShape();
    for (int i = 0; i < teeth * 2; i++) {
        float angle = TWO_PI / (teeth * 2) * i;
        float r = (i % 2 == 0) ? outerR : innerR;
        vertex(x + cos(angle) * r, y + sin(angle) * r);
    }
    endShape(CLOSE);
    popStyle();
}

// 正多角形
void drawRegularPolygon(float x, float y, float r, int sides) {
    beginShape();
    for (int i = 0; i < sides; i++) {
        float angle = TWO_PI / sides * i - HALF_PI;
        vertex(x + cos(angle) * r, y + sin(angle) * r);
    }
    endShape(CLOSE);
}
