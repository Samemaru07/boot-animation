// ============================================================
// phase.pde  —  フェーズ進行ロジック
// ============================================================

void initPhase() {
  ePhase         = 0;
  phaseStartTime = 0;
}

// フェーズ内経過秒を返す
float phaseTime() {
  return gTime - phaseStartTime;
}

// フェーズ内の進捗 0.0〜1.0 を返す（duration秒で1.0になる）
float phaseProgress(float duration) {
  return constrain(phaseTime() / duration, 0.0, 1.0);
}

void updatePhase() {
  int prevPhase = ePhase;

  if      (ePhase == 0 && gTime >= T_PHASE1) advancePhase(1);
  else if (ePhase == 1 && gTime >= T_PHASE2) advancePhase(2);
  else if (ePhase == 2 && gTime >= T_PHASE3) advancePhase(3);
  else if (ePhase == 3 && gTime >= T_PHASE4) advancePhase(4);

  // フェーズが変わったタイミングでのコールバック
  if (ePhase != prevPhase) {
    onPhaseChanged(ePhase);
  }
}

void advancePhase(int next) {
  ePhase         = next;
  phaseStartTime = gTime;
}

// フェーズ切り替え時に各モジュールへ通知
void onPhaseChanged(int phase) {
  onPhaseChangedLogWindows(phase);
  onPhaseChangedBlackout(phase);
}
