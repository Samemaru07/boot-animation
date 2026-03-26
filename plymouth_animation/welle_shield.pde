// ============================================================
// welle_shield.pde  —  ヴェルシールド展開エフェクト
// Phase 2: 島を囲む3重シールドリングが展開
// ============================================================

float[] shieldRadius = {0, 0, 0, 0, 0, 0, 0, 0}; // 各レイヤーの現在半径
float[] shieldTargetR = {180, 210, 250, 270, 300, 330, 360, 390}; // 目標半径
float[] shieldAlpha = {0, 0, 0, 0, 0, 0, 0, 0};
float shieldGlow = 0;

void initWelleShield() {
    for (int i = 0; i < 8; i++) {
        shieldRadius[i] = 0;
        shieldAlpha[i] = 0;
    }
}

void drawWelleShield() {
    float cx = WIN_W / 2.0;
    float cy = WIN_H / 2.0 + 60; // 島と同じオフセット

    float p = (ePhase == 2) ? min(phaseProgress(3.0), 1.0) : 1.0;

    pushMatrix();
    pushStyle();
    translate(cx, cy);

    // 各レイヤーを時間差で展開
    for (int i = 0; i < 8; i++) {
        float layerDelay = i * 0.3; // 0.3秒ずつ遅らせる
        float layerP =
            constrain((p - layerDelay / 3.0) / (1.0 - layerDelay / 3.0), 0, 1);

        // 半径アニメ：ease out
        float rTarget = shieldTargetR[i];
        float rCurrent = rTarget * easeOut(layerP);
        shieldRadius[i] = rCurrent;

        // α：展開後に安定
        float aTarget = layerP > 0.1 ? 180 : 0;
        shieldAlpha[i] += (aTarget - shieldAlpha[i]) * 0.05;

        if (shieldAlpha[i] <= 0)
            continue;

        float a = shieldAlpha[i] / 255.0;

        // Phase 3 でフェードアウト
        if (ePhase == 3) {
            a *= (1.0 - phaseProgress(0.8));
        }
        if (a <= 0)
            continue;
        // i >= 3 は点線リング
        if (i >= 3) {
            stroke(68, 200, 255, 120 * a);
            strokeWeight(1.2);
            noFill();
            int dotCount = 80;
            for (int d = 0; d < dotCount; d++) {
                if (d % 3 == 0)
                    continue;
                float angle1 = TWO_PI / dotCount * d;
                float angle2 = TWO_PI / dotCount * (d + 1);
                line(cos(angle1) * rCurrent, sin(angle1) * rCurrent * 0.44,
                     cos(angle2) * rCurrent, sin(angle2) * rCurrent * 0.44);
            }
            continue;
        }
        // ─── シールドリング本体 ───────────────────────────────
        noFill();

        // グロー（外側から重ねる）
        for (int g = 4; g >= 1; g--) {
            float gr = g * 3.0;
            stroke(68, 170 + i * 20, 255, 25 * a);
            strokeWeight(gr);
            ellipse(0, 0, rCurrent * 2 + g * 3, (rCurrent * 2 + g * 3) * 0.44);
        }

        // リング本体
        stroke(68, 200, 255, 200 * a);
        strokeWeight(2.0);
        ellipse(0, 0, rCurrent * 2, rCurrent * 2 * 0.44);

        // 内側の薄いリング
        stroke(68, 170, 255, 80 * a);
        strokeWeight(1);
        ellipse(0, 0, rCurrent * 2 - 6, (rCurrent * 2 - 6) * 0.44);

        // ─── 展開波紋 ─────────────────────────────────────────
        if (layerP < 0.6) {
            float rippleR = rCurrent + (1.0 - layerP) * 40;
            float rippleA = (1.0 - layerP) * 120 * a;
            stroke(68, 200, 255, rippleA);
            strokeWeight(1.5);
            noFill();
            ellipse(0, 0, rippleR * 2, rippleR * 2 * 0.44);
        }

        // ─── セグメントマーク ─────────────────────────────────
        stroke(68, 200, 255, 150 * a);
        strokeWeight(1.5);
        int marks = 12;
        for (int m = 0; m < marks; m++) {
            float angle =
                TWO_PI / marks * m + gTime * 0.08 * (i % 2 == 0 ? 1 : -1);
            float len = (m % 3 == 0) ? 14 : 7;
            float rx = cos(angle) * rCurrent;
            float ry = sin(angle) * rCurrent;
            float nx = cos(angle);
            float ny = sin(angle);
            line(rx - nx * len, ry - ny * len, rx + nx * 4, ry + ny * 4);
        }

        // ─── レイヤーラベル ──────────────────────────────────
        if (layerP > 0.5) {
            textFont(fontOrbitronSm);
            textSize(9);
            textAlign(CENTER, CENTER);
            fill(68, 200, 255, 160 * a);
            float labelAngle = -HALF_PI + i * 0.15;
            float lx = cos(labelAngle) * (rCurrent + 18);
            float ly = sin(labelAngle) * (rCurrent + 18);
            text("L" + (i + 1), lx, ly);
        }
    }

    // ─── 全レイヤー展開後のパルス ───────────────────────────
    if (ePhase == 2 && phaseProgress(3.0) > 0.9) {
        float pulse = (sin(gTime * TWO_PI * 0.8) + 1) * 0.5;
        for (int i = 0; i < 3; i++) {
            stroke(68, 200, 255, 40 * pulse);
            strokeWeight(8);
            noFill();
            ellipse(0, 0, shieldRadius[i] * 2, shieldRadius[i] * 2 * 0.44);
        }
        // WELLE SHIELD ラベル
        textFont(fontOrbitron);
        textSize(FONT_SM);
        textAlign(CENTER, CENTER);
        fill(68, 200, 255, 180 * pulse + 75);
        text("WELLE SHIELD: ACTIVE", 0, -280);
    }

    popStyle();
    popMatrix();
}

// イーズアウト関数
float easeOut(float t) { return 1.0 - pow(1.0 - t, 3); }
