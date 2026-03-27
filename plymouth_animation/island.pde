// ============================================================
// island.pde  —  島の線画＋半球シールド（偽装鏡面）演出
// Phase 1: 出現 → 半球がゆらゆら溶ける（上から）
// ============================================================

float islandAlpha = 0;
float hemisphereDissolve = 0; // 0=完全シールド / 1=完全溶解
float hemisphereLingerAlpha = 1.0;

void initIsland() {
    islandAlpha = 0;
    hemisphereDissolve = 0;
    welleShieldProgress1 = 0;
    welleShieldProgress2 = 0;
    hemisphereLingerAlpha = 1.0;
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
    } else if (ePhase == 3) {
        targetAlpha = 200;
    } else {
        targetAlpha = lerp(200, 0, phaseProgress(0.8));
    }
    islandAlpha += (targetAlpha - islandAlpha) * 0.06;

    // 偽装解除進行（Phase 1の後半から溶ける）
    if (hemisphereDissolve >= 1.0) {
        hemisphereLingerAlpha = max(hemisphereLingerAlpha - 0.02, 0.0);
    }
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

    // 島の出現スケールアニメ
    float islandScale = 1.0;
    if (ePhase == 1) {
        float appearP = constrain(phaseProgress(1.0), 0, 1);
        islandScale = easeOut(appearP);
    }
    scale(islandScale);

    // ─── 島の線画 ────────────────────────────────────────────
    drawIslandShape(a);

    // ─── 半球シールド ────────────────────────────────────────
    if (hemisphereDissolve < 1.0 || hemisphereLingerAlpha > 0) {
        float hemisphereA = (ePhase == 1) ? 1.0 : a;
        drawHemisphere(hemisphereA);
    }

    // ヴェルシールド展開
    if (ePhase >= 2) {
        if (ePhase == 2) {
            float p2 = phaseProgress(5.5);
            if (p2 > 4.5 / 5.5) {
                welleShieldProgress1 = min(welleShieldProgress1 + 0.005, 1.0);
                welleShieldProgress2 = min(welleShieldProgress2 + 0.005,
                                           max(0, welleShieldProgress1 - 0.15));
            }
        }
        float demoA = a;
        if (ePhase == 3) {
            demoA *= (1.0 - phaseProgress(0.5));
        }
        drawWelleShieldDome(demoA, welleShieldProgress1, 180);
        drawWelleShieldDome(demoA, welleShieldProgress2, 220);
    }

    if (DEBUG_MODE) {
        float relX = (mouseX - cx) / islandScale;
        float relY = (mouseY - (cy + 60)) / islandScale;
        fill(255);
        textSize(12);
        textAlign(LEFT, BOTTOM);
        text(int(relX) + ", " + int(relY), relX, relY - 10);
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
    curveVertex(-120, 65);
    curveVertex(-100, 25);
    curveVertex(-80, -25);
    curveVertex(-30, -55);
    curveVertex(20, -65);
    curveVertex(70, -45);
    curveVertex(90, 5);
    curveVertex(50, -15);
    curveVertex(20, -30);
    curveVertex(-10, -35);
    curveVertex(-40, -25);
    curveVertex(-60, 5);
    curveVertex(-100, 25);
    curveVertex(-80, -25);
    endShape();

    // 左下の離島
    pushMatrix();
    translate(-140, 35);
    scale(0.5);
    beginShape();
    vertex(60, 20);
    vertex(43, 30);
    vertex(45, 35);
    vertex(52, 45);
    vertex(65, 30);
    endShape(CLOSE);
    popMatrix();

    // 下の離島 (既存の修正)
    pushMatrix();
    translate(80, 55); // 30px右にずらした (-10 -> 20)
    scale(0.6);        // サイズを半分にした (0.8 -> 0.4)
    // ellipse(0, 0, 40, 40); // きれいな丸は削除
    //  汚い丸に変更 (不規則な10点で構成)
    beginShape();
    vertex(21, -1);
    vertex(15, 10);
    vertex(7, 12);
    vertex(-5, 12);
    vertex(-17, 7);
    vertex(-19, 1);
    vertex(-15, -13);
    vertex(-7, -18);
    vertex(5, -20);
    vertex(17, -11);
    endShape(CLOSE);
    popMatrix();

    // 右下の離島群
    pushMatrix();
    translate(90, 25);
    scale(0.5);
    beginShape();
    vertex(-2, -2);
    vertex(2, 2);
    vertex(0, 0);
    endShape(CLOSE);
    beginShape();
    vertex(12, 3);
    vertex(18, 10);
    vertex(10, 8);
    endShape(CLOSE);
    beginShape();
    vertex(25, 15);
    vertex(30, 22);
    vertex(22, 18);
    endShape(CLOSE);
    popMatrix();

    // 島内部の山・地形ライン
    stroke(68, 200, 255, 120 * a);
    strokeWeight(1.5);
    // 山頂
    line(-20, -35, 0, -60);
    line(0, -60, 25, -40);
    // 小山
    line(70, -5, 77, -20);
    line(77, -20, 85, -7);
    // 海岸線
    line(-85, 5, -75, -5);
    line(-75, -5, -65, 5);

    // 拠点マーク（中央付近）
    noFill();
    stroke(255, 170, 50, 180 * a);
    strokeWeight(7);
    ellipse(0, -50, 22, -12);
    ellipse(0, -50, 8, 8);

    // ラベル
    textFont(fontOrbitronSm);
    textSize(20);
    textAlign(CENTER, CENTER);
    fill(255, 170, 50, 200 * a);
    text("TATSUMIYA Island", 0, 105);
    textSize(14);
    fill(68, 170, 255, 150 * a);
    text("28.7°N  132.4°E", 0, 130);
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
            float fadeA = hemisphereDissolve >= 1.0 ? 0.0 : 1.0;
            fill(68, 160, 255, 100 * a * fadeA);
            beginShape();
            vertex(cos(angle1) * rw0, sin(angle1) * rh0 + ry0);
            vertex(cos(angle2) * rw0, sin(angle2) * rh0 + ry0);
            vertex(cos(angle2) * rw1, sin(angle2) * rh1 + ry1);
            vertex(cos(angle1) * rw1, sin(angle1) * rh1 + ry1);
            endShape(CLOSE);
        }
    }

    // ─── 膜（上から下に降りてくる） ─────────────────────────
    float membraneT = hemisphereDissolve; // 0=頂上 / 1=地面
    float membraneY = -rhMax * sin((1.0 - membraneT) * HALF_PI) * 1.2;
    float membraneRw = rwMax * membraneT;
    float membraneRh = rhMax * membraneT;

    // 膜の縁（少し明るく）
    noFill();
    stroke(100, 220, 255, 120 * a * hemisphereLingerAlpha);
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

// ヴェルシールド展開（偽装鏡面の逆再生）
float welleShieldProgress1 = 0;
float welleShieldProgress2 = 0;

void drawWelleShieldDome(float a, float progress, float rwMax) {
    float dissolve = 1.0 - progress;

    pushStyle();
    noFill();

    float rhMax = rwMax * 0.44;
    float topY = -rhMax * 1.2;
    float botY = 0;

    int sideSegs = 40;
    int heightSegs = 20;
    for (int h = 0; h < heightSegs; h++) {
        float t0 = (float)h / heightSegs;
        float t1 = (float)(h + 1) / heightSegs;

        if (t0 < dissolve)
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
            fill(255, 30, 30, 180 * a * progress);
            beginShape();
            vertex(cos(angle1) * rw0, sin(angle1) * rh0 + ry0);
            vertex(cos(angle2) * rw0, sin(angle2) * rh0 + ry0);
            vertex(cos(angle2) * rw1, sin(angle2) * rh1 + ry1);
            vertex(cos(angle1) * rw1, sin(angle1) * rh1 + ry1);
            endShape(CLOSE);
        }
    }

    // 膜リング（下から上へ）
    float membraneT = dissolve;
    float membraneY = -rhMax * sin((1.0 - membraneT) * HALF_PI) * 1.2;
    float membraneRw = rwMax * membraneT;
    float membraneRh = rhMax * membraneT;

    if (progress > 0) {
        noFill();
        stroke(220, 20, 20, 120 * a * progress);
        strokeWeight(2.5);
        beginShape();
        for (int i = 0; i <= 60; i++) {
            float angle = TWO_PI / 60 * i;
            float wave =
                (noise(cos(angle) + gTime, sin(angle) + gTime) * 32 - 18) *
                progress * (1.0 - progress) * 4;
            float mx = cos(angle) * (membraneRw + wave);
            float my = sin(angle) * (membraneRh + wave * 0.5) + membraneY;
            vertex(mx, my);
        }
        endShape(CLOSE);
    }

    popStyle();
}
