// ============================================================
// blackout.pde  —  ブラックアウト＋電源遮断演出
// Phase 3 → Phase 4
// ============================================================

boolean redFlashActive = false;
float redFlashAlpha = 0;
float blackoutProgress = 0;

void initBlackout() {
    redFlashActive = false;
    redFlashAlpha = 0;
    blackoutProgress = 0;
    blackoutAlpha = 0;
}

void drawBlackout() {
    if (ePhase < 3)
        return;

    float p = phaseProgress(2.0); // Phase 3：2秒間

    // ─── ブラックアウト（Phase 3 後半〜） ──────────────────
    if (ePhase == 3 && p > 0.45) {
        blackoutAlpha = 255;
    } else if (ePhase >= 4) {
        blackoutAlpha = 255;
    }

    if (blackoutAlpha > 0) {
        pushStyle();
        noStroke();
        fill(0, 0, 0, blackoutAlpha);
        rect(0, 0, WIN_W, WIN_H);
        popStyle();
    }

    // ─── 電源遮断テキスト（フラッシュ中） ────────────────────
    if (ePhase == 3 && p > 0.1 && p < 0.5) {
        float textA = sin((p - 0.1) / 0.4 * PI) * 255;
        pushStyle();
        textFont(fontOrbitron);
        textSize(FONT_MD);
        textAlign(CENTER, CENTER);
        fill(255, 60, 60, textA);
        text("MAIN POWER: DISCONNECTED", WIN_W / 2.0, WIN_H / 2.0 - 200);
        textSize(FONT_SM);
        fill(255, 170, 50, textA * 0.8);
        text("BRUNHILDE SYSTEM: SHUTDOWN", WIN_W / 2.0, WIN_H / 2.0 - 170);
        popStyle();
    }
}

void onPhaseChangedBlackout(int phase) {
    if (phase == 3) {
        redFlashActive = true;
    }
}

float easeIn(float t) { return t * t * t; }
