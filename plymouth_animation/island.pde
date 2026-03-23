// ============================================================
// island.pde  —  島の線画＋半球シールド（偽装鏡面）演出
// Phase 1: 出現 → 半球がゆらゆら溶ける（上から）
// ============================================================

float islandAlpha = 0;
float hemisphereDissolve = 0; // 0=完全シールド / 1=完全溶解

void initIsland() {
    islandAlpha = 0;
    hemisphereDissolve = 0;
}

void drawIsland() {
    float cx = WIN_W / 2.0;
    float cy = WIN_H / 2.0;

    // フェードイン
    float targetAlpha;
    if (ePhase == 1) {
        targetAlpha = 220;
    } else if (ePhase == 2) {
        targetAlpha = 200;
    } else {
        targetAlpha = lerp(200, 0, phaseProgress(0.8));
    }
    islandAlpha += (targetAlpha - islandAlpha) * 0.06;

    // 偽装解除進行（Phase 1の後半から溶ける）
    if (ePhase == 1) {
        float p = phaseProgress(4.0); // 4秒かけて
        float dissolveTarget = p > 0.3 ? map(p, 0.3, 1.0, 0, 1.0) : 0;
        hemisphereDissolve += (dissolveTarget - hemisphereDissolve) * 0.04;
    } else if (ePhase >= 2) {
        hemisphereDissolve = min(hemisphereDissolve + 0.01, 1.0);
    }

    float a = islandAlpha / 255.0;

    pushMatrix();
    pushStyle();
    translate(cx, cy + 60); // 中央より少し下に配置

    // ─── 島の線画 ────────────────────────────────────────────
    drawIslandShape(a);

    // ─── 半球シールド ────────────────────────────────────────
    if (hemisphereDissolve < 1.0) {
        float hemisphereA = (ePhase == 1) ? 1.0 : a;
        drawHemisphere(hemisphereA);
    }

    popStyle();
    popMatrix();
}

// 島のシルエット（シンプルな線画）
void drawIslandShape(float a) {
    pushStyle();
    stroke(68, 220, 255, 200 * a);
    strokeWeight(2);
    noFill();

    // 島の輪郭（手描き風の不規則な楕円＋岬）
    // 原点＝島中央
    beginShape();
    // 時計回りに頂点を並べる
    curveVertex(-120, 10);
    curveVertex(-110, -5);
    curveVertex(-80, -20);
    curveVertex(-60, -35);
    curveVertex(-30, -45);
    curveVertex(0, -50);
    curveVertex(35, -42);
    curveVertex(70, -28);
    curveVertex(95, -12);
    curveVertex(115, 5);
    curveVertex(110, 22);
    curveVertex(90, 38);
    curveVertex(55, 50);
    curveVertex(10, 55);
    curveVertex(-35, 50);
    curveVertex(-80, 35);
    curveVertex(-115, 22);
    curveVertex(-120, 10);
    curveVertex(-110, -5);
    endShape();

    // 島内部の山・地形ライン
    stroke(68, 200, 255, 120 * a);
    strokeWeight(1.5);
    // 山頂
    line(-20, -20, 0, -55);
    line(0, -55, 25, -25);
    // 小山
    line(50, 10, 65, -15);
    line(65, -15, 80, 8);
    // 海岸線
    line(-80, 20, -50, 10);
    line(-50, 10, -20, 20);
    // グリッド（人工物感）
    stroke(68, 170, 255, 60 * a);
    strokeWeight(1);
    for (int i = -3; i <= 3; i++) {
        line(i * 30, -40, i * 30, 50);
        line(-110, i * 18, 110, i * 18);
    }

    // 拠点マーク（中央付近）
    noFill();
    stroke(255, 170, 50, 180 * a);
    strokeWeight(2);
    ellipse(0, 0, 22, 22);
    ellipse(0, 0, 8, 8);
    // クロスヘア
    line(-14, 0, 14, 0);
    line(0, -14, 0, 14);

    // ラベル
    textFont(fontOrbitronSm);
    textSize(FONT_XS);
    textAlign(CENTER, CENTER);
    fill(255, 170, 50, 200 * a);
    text("PHENEX ISLAND", 0, 75);
    textSize(9);
    fill(68, 170, 255, 150 * a);
    text("28.7°N  132.4°E", 0, 90);

    popStyle();
}

// 偽装鏡面
void drawHemisphere(float a) {
    pushStyle();
    noFill();

    int rings = 20;
    float rwMax = 180;
    float rhMax = 80; // アイソメ用に平たく

    // 頂上の楕円
    float topT = 0.0;
    float topRw = 5;
    float topRh = 5;
    float topY = -rhMax * 1.2;

    float botT = 1.0;
    float botRw = rwMax;
    float botRh = rhMax;
    float botY = 0;

    // 側面（ドーム膜）
    int sideSegs = 40;
    int heightSegs = 20;
    for (int h = 0; h < heightSegs; h++) {
        float t0 = (float)h / heightSegs;
        float t1 = (float)(h + 1) / heightSegs;

        // dissolveで上から消えていく
        if (t0 < hemisphereDissolve)
            continue;

        float ry0 = -rhMax * sin((1.0 - t0) * HALF_PI) * 1.2;
        float ry1 = -rhMax * sin((1.0 - t1) * HALF_PI) * 1.2;
        float rw0 = rwMax * t0;
        float rh0 = rhMax * t0;
        float rw1 = rwMax * t1;
        float rh1 = rhMax * t1;

        for (int i = 0; i < sideSegs; i++) {
            float angle1 = TWO_PI / sideSegs * i;
            float angle2 = TWO_PI / sideSegs * (i + 1);

            noStroke();
            fill(68, 170, 255, 100 * a * (1.0 - hemisphereDissolve));
            beginShape();
            vertex(cos(angle1) * rw0, sin(angle1) * rh0 + ry0);
            vertex(cos(angle2) * rw0, sin(angle2) * rh0 + ry0);
            vertex(cos(angle2) * rw1, sin(angle2) * rh1 + ry1);
            vertex(cos(angle1) * rw1, sin(angle1) * rh1 + ry1);
            endShape(CLOSE);
        }
    }

    // 底辺の楕円
    ellipse(0, botY, botRw * 2, botRh * 2);

    // ─── 膜（上から下に降りてくる） ─────────────────────────
    float membraneT = hemisphereDissolve; // 0=頂上 / 1=地面
    float membraneY = -rhMax * sin((1.0 - membraneT) * HALF_PI) * 1.2;
    float membraneRw = rwMax * membraneT;
    float membraneRh = rhMax * membraneT;

    // 膜本体（半透明塗り）
    noStroke();
    fill(68, 170, 255, 30 * a);
    ellipse(0, membraneY, membraneRw * 2, membraneRh * 2);

    // 膜の縁（少し明るく）
    noFill();
    stroke(100, 220, 255, 120 * a);
    strokeWeight(2.5);
    beginShape();
    for (int i = 0; i <= 60; i++) {
        float angle = TWO_PI / 60 * i;
        float wave = (noise(cos(angle) + gTime, sin(angle) + gTime) * 32 - 18) *
                     (1.0 - membraneT);
        float mx = cos(angle) * (membraneRw + wave);
        float my = sin(angle) * (membraneRh + wave * 0.5) + membraneY;
        vertex(mx, my);
    }
    endShape(CLOSE);

    // ラベル
    if (hemisphereDissolve < 0.7) {
        textFont(fontOrbitronSm);
        textSize(FONT_XS);
        textAlign(CENTER, CENTER);
        fill(68, 200, 255, (1.0 - hemisphereDissolve) * 180 * a);
        text("CAMOUFLAGE MIRROR", 0, -rhMax - 16);
        textSize(9);
        fill(68, 200, 255, (1.0 - hemisphereDissolve) * 120 * a);
        text("ACTIVE", 0, -rhMax - 4);
    } else {
        textFont(fontOrbitronSm);
        textSize(FONT_XS);
        textAlign(CENTER, CENTER);
        fill(255, 80, 80, (hemisphereDissolve - 0.7) * 3 * 180 * a);
        text("CAMOUFLAGE: DISENGAGED", 0, -rhMax - 16);
    }

    popStyle();
}
