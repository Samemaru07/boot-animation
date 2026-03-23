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

// 半球シールド（偽装鏡面）
void drawHemisphere(float a) {
    pushStyle();

    // hemisphereDissolve = 0〜1 で上から溶けていく
    // dissolveY：これより上の部分が消えている（-1〜+1の正規化）
    float dissolveY = map(hemisphereDissolve, 0, 1, -1.2, 1.2);

    float rw = 180; // 半球の横幅半径
    float rh = 100; // 半球の縦幅半径（半分）

    // 半球を細かいセグメントで描き、dissolveY以下の部分のみ描く
    int segments = 60;
    noFill();

    for (int i = 0; i < segments; i++) {
        float t1 = map(i, 0, segments, -PI, 0); // 上半円（-π〜0）
        float t2 = map(i + 1, 0, segments, -PI, 0);

        float x1 = cos(t1) * rw;
        float y1 = sin(t1) * rh;
        float x2 = cos(t2) * rw;
        float y2 = sin(t2) * rh;

        // 正規化したy座標（-1=上端, +1=下端）
        float ny = map(y1, -rh, rh, -1, 1);
        if (ny < dissolveY)
            continue; // dissolveYより上は描かない

        // 溶ける境界付近はゆらゆらさせる
        float shimmer = 1.0;
        if (abs(ny - dissolveY) < 0.15) {
            shimmer = noise(x1 * 0.03 + gTime * 2, y1 * 0.03) * 2.0;
        }

        float segAlpha = (1.0 - hemisphereDissolve) * 180 * a * shimmer;
        // ハイライト（上部ほど明るく）
        float bright = map(y1, -rh, rh, 1.5, 0.6);
        stroke(68 * bright, 200 * bright, 255 * bright,
               constrain(segAlpha, 0, 255));
        strokeWeight(1.8);
        line(x1, y1, x2, y2);
    }

    // 底辺の楕円（地面との接触線）
    float bottomAlpha = (1.0 - hemisphereDissolve) * 160 * a;
    stroke(68, 200, 255, bottomAlpha);
    strokeWeight(2);
    noFill();
    ellipse(0, 0, rw * 2, 20);

    // 溶解中のパーティクル（境界付近に光点）
    if (hemisphereDissolve > 0.05 && hemisphereDissolve < 0.95) {
        for (int p = 0; p < 12; p++) {
            float px = random(-rw, rw);
            float pny = dissolveY + random(-0.12, 0.12);
            float py = map(pny, -1, 1, -rh, rh);
            // 半球内かチェック
            if (pow(px / rw, 2) + pow(py / rh, 2) > 1.0)
                continue;

            float ps = random(2, 5);
            noStroke();
            fill(100, 220, 255, random(100, 200) * a);
            ellipse(px, py, ps, ps);
        }
    }

    // ラベル
    if (hemisphereDissolve < 0.7) {
        textFont(fontOrbitronSm);
        textSize(FONT_XS);
        textAlign(CENTER, CENTER);
        fill(68, 200, 255, (1.0 - hemisphereDissolve) * 180 * a);
        text("CAMOUFLAGE MIRROR", 0, -rh - 16);
        textSize(9);
        fill(68, 200, 255, (1.0 - hemisphereDissolve) * 120 * a);
        text("ACTIVE", 0, -rh - 4);
    } else {
        textFont(fontOrbitronSm);
        textSize(FONT_XS);
        textAlign(CENTER, CENTER);
        fill(255, 80, 80, (hemisphereDissolve - 0.7) * 3 * 180 * a);
        text("CAMOUFLAGE: DISENGAGED", 0, -rh - 16);
    }

    popStyle();
}
