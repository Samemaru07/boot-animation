// ============================================================
//  フェーズ進行ロジック
// ============================================================

void startPhase0() {
  statusText = "MS-00X :: SYSTEM BOOT SEQUENCE";
  addLog("[0001] BOOT INIT...", COL_MAIN);
  addCli("> INIT transfer_protocol v3.1", COL_CMD);
  phaseTimer = millis();
  phase = 0;
}

void updatePhase() {
  long now = millis();

  if (phase == 0) {
    msOpacity = min(msOpacity+0.02, 1.0);
    funnelActive = true;
    if (now-phaseTimer > 1400 && pcHostname.equals("---")) {
      pcHostname = "archlinux";
      pcKernel   = "6.x.x-arch1";
      pcCPU      = "DETECTED";
      addLog("[0002] HARDWARE SCAN OK", COL_OK);
      addCli("> SCAN --target=PC-NODE", COL_CMD);
    }
    if (now-phaseTimer > 2200) {
      phase=1; phaseTimer=now;
      statusText = "ESTABLISHING UPLINK...";
      addLog("[0003] UPLINK TO PC-NODE...", COL_MAIN);
      addCli("> UPLINK --ch=01 --enc=AES256", COL_CMD);
    }
  }
  else if (phase == 1) {
    if (now-uplinkLast > 300) {
      uplinkLast=now;
      uplinkDots=(uplinkDots+1)%5;
      pcLink=".".repeat(uplinkDots+1);
      pcLinkCol=COL_MAIN;
    }
    if (now-phaseTimer > 2200 && !uplinkDone) {
      uplinkDone=true;
      pcLink="SECURE"; pcLinkCol=COL_OK;
      addLog("[0004] UPLINK SECURE :: CH01", COL_OK);
      addCli("> LINK OK", COL_MAIN);
    }
    if (now-phaseTimer > 2900) {
      phase=2; phaseTimer=now;
      statusText = "CALCULATING POWER ROUTE...";
      addLog("[0005] ROUTING POWER CHANNEL", COL_MAIN);
      addCli("> ROUTE power --src=MS-00X --dst=PC", COL_CMD);
    }
  }
  else if (phase == 2) {
    routeP=min(routeP+1.2, 60);
    progWidth=lerp(progWidth, routeP, 0.1);
    if (routeP>=60 && !routeDone) {
      routeDone=true;
      addLog("[0006] ROUTE CONFIRMED", COL_OK);
    }
    if (now-phaseTimer > 3500) {
      phase=3; phaseTimer=now; authStart=now;
      statusText = "AUTH REQUIRED :: ENTER ACCESS CODE";
      addLog("[0007] AUTH CHALLENGE ISSUED", COL_MAIN);
      addCli("> AUTH --mode=challenge --timeout=15", COL_CMD);
      addCli("  [!] ACCESS CODE REQUIRED", COL_MAIN);
      pwVisible=true; progColor=COL_WARN;
    }
  }
  else if (phase == 3) {
    if (!authDone && !timedOut) {
      int remaining = authTimeout-(int)((now-authStart)/1000);
      if (remaining<=0) {
        timedOut=true; pwVisible=false; doFail("TIMEOUT");
      } else {
        statusText = "AUTH TIMEOUT IN "+remaining+"s";
        progWidth = 60+(authTimeout-remaining)*(40.0/authTimeout);
      }
    }
  }
  else if (phase == 4) {
    energyBar=min(energyBar+0.36, 36);
    if (energyBar>=36 && !energyDone) {
      energyDone=true;
      addLog("[0009] TRANSFER COMPLETE", COL_OK);
      addCli("> exec boot_sequence --host", COL_CMD);
      statusText = "[ TRANSFER COMPLETE :: WELCOME, PILOT ]";
      progWidth=100; progColor=COL_OK;
      pcPower="ONLINE"; pcPowerCol=COL_OK;
    }
  }
}

void updateAnimations() {
  if (funnelActive) funnelT+=0.05;
  if (phase>=4) flickerOpacity=0.85+random(0.15);
  if (flickering) {
    long now=millis();
    if (now-flickerLast > 140) {
      flickerLast=now; flickerCount++;
      flickerOpacity=(flickerCount%2==0)?1.0:0.0;
      if (flickerCount>6) {
        flickering=false; flickerOpacity=1.0; onFlashDone();
      }
    }
  }
}
