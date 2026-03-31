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
        msOpacity = min(msOpacity + 0.02, 1.0);
        funnelActive = true;
        if (now - phaseTimer > 1400 && pcHostname.equals("---")) {
          compStatus[0] = "SCANNING";
            compColors[0] = COL_MAIN;
            compStatus[1] = "RESTRICTED";
            compColors[1] = COL_WARN;
            pcHostname = "archlinux";
            pcKernel = "6.x.x-arch1";
            pcCPU = "DETECTED";
            addLog("[0002] HARDWARE SCAN OK", COL_OK);
            addCli("> SCAN --target=PC-NODE", COL_CMD);
        }
        if (now - phaseTimer > 2200) {
            phase = 1;
            phaseTimer = now;
            statusText = "ESTABLISHING UPLINK...";
            addLog("[0003] UPLINK TO PC-NODE...", COL_MAIN);
            addCli("> UPLINK --ch=01 --enc=AES256", COL_CMD);
        }
    } else if (phase == 1) {
        if (now - uplinkLast > 300) {
            uplinkLast = now;
            uplinkDots = (uplinkDots + 1) % 5;
            pcLink = ".".repeat(uplinkDots + 1);
            pcLinkCol = COL_MAIN;
        }
        if (now - phaseTimer > 2200 && !uplinkDone) {
            uplinkDone = true;
            compStatus[0] = "OK";
            compColors[0] = COL_OK;
            compStatus[2] = "ONLINE";
            compColors[2] = COL_OK;
            compStatus[3] = "STANDBY";
            compColors[3] = COL_WARN;
            pcLink = "SECURE";
            pcLinkCol = COL_OK;
            addLog("[0004] UPLINK SECURE :: CH01", COL_OK);
            addCli("> LINK OK", COL_MAIN);
        }
        if (now - phaseTimer > 2900) {
            phase = 2;
            phaseTimer = now;
            statusText = "CALCULATING POWER ROUTE...";
            addLog("[0005] ROUTING POWER CHANNEL", COL_MAIN);
            addCli("> ROUTE power --src=MS-00X --dst=PC", COL_CMD);
        }
    } else if (phase == 2) {
        routeP = min(routeP + 1.2, 60);
        progWidth = lerp(progWidth, routeP, 0.1);
        if (routeP >= 60 && !routeDone) {
            routeDone = true;
            compStatus[4] = "ACTIVE";
            compColors[4] = COL_OK;
            compStatus[5] = "BOOTING";
            compColors[5] = COL_MAIN;
            addLog("[0006] ROUTE CONFIRMED", COL_OK);
        }
        if (now - phaseTimer > 3500) {
            phase = 3;
            phaseTimer = now;
            authStart = now;
            statusText = "AUTH REQUIRED :: ENTER ACCESS CODE";
            addLog("[0007] AUTH CHALLENGE ISSUED", COL_MAIN);
            addCli("> AUTH --mode=challenge --timeout=15", COL_CMD);
            addCli("  [!] ACCESS CODE REQUIRED", COL_MAIN);
            pwVisible = true;
            progColor = COL_WARN;
        }
    } else if (phase == 3) {
        if (!authDone && !timedOut) {
            int remaining = authTimeout - (int)((now - authStart) / 1000);
            if (remaining <= 0) {
                timedOut = true;
                pwVisible = false;
                doFail("TIMEOUT");
            } else {
                statusText = "AUTH TIMEOUT IN " + remaining + "s";
                progWidth =
                    60 + (authTimeout - remaining) * (40.0 / authTimeout);
            }
        }
    } else if (phase == 4) {
        energyBar = min(energyBar + 0.36, 36);
        if (energyBar >= 36 && !energyDone) {
            energyDone = true;
            compStatus[5] = "ONLINE";
            compColors[5] = COL_OK;
            addLog("[0009] TRANSFER COMPLETE", COL_OK);
            addCli("> exec boot_sequence --host", COL_CMD);
            statusText = "[ TRANSFER COMPLETE :: WELCOME, PILOT ]";
            progWidth = 100;
            progColor = COL_OK;
            pcPower = "ONLINE";
            pcPowerCol = COL_OK;
        }

        // エネルギーアニメーション
        if (eStarted && ePhase < 3) {
            float current = eVals[ePhase];
            if (current < 30) {
                eVals[ePhase] += 0.3;
            } else {
                eVals[ePhase] += 2.0;
            }
            if (eVals[ePhase] >= 100) {
                eVals[ePhase] = 100;
                ePhase++;
            }
        }

        // 接続線アニメーション
        if (!pipeAnimDone) {
            pipeDrawT = min(pipeDrawT + 0.33, 1.0);
            if (pipeDrawT >= 1.0) {
                pipeAnimDone = true;
                pulseActive = true;
            }
        }
        if (pulseActive) {
            for (int i = 0; i < pulsePositions.length; i++) {
                pulsePositions[i] += 0.012;
                if (pulsePositions[i] > 1.0)
                    pulsePositions[i] -= 1.0;
            }
        }
    }
}

void updateAnimations() {
    if (funnelActive)
        funnelT += 0.05;
    if (phase >= 4)
        flickerOpacity = 0.85 + random(0.15);
    if (flickering) {
        long now = millis();
        if (now - flickerLast > 140) {
            flickerLast = now;
            flickerCount++;
            flickerOpacity = (flickerCount % 2 == 0) ? 1.0 : 0.0;
            if (flickerCount > 6) {
                flickering = false;
                flickerOpacity = 1.0;
                onFlashDone();
            }
        }
    }
}
