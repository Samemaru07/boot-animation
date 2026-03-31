// ============================================================
//  認証ロジック
// ============================================================

void keyPressed() {
    if (phase == 3 && pwVisible && !authDone && !timedOut) {
        if (key == ENTER || key == RETURN) {
            authDone = true;
            pwVisible = false;
            if (pwInput.equals(secretPassword))
                doSuccess();
            else
                doFail("INVALID CODE");
        } else if (key == BACKSPACE) {
            if (pwInput.length() > 0)
                pwInput = pwInput.substring(0, pwInput.length() - 1);
        } else if (key >= 32 && key < 127 && pwInput.length() < 16) {
            pwInput += key;
        }
    }
}

void doSuccess() {
    addLog("[0008] AUTH GRANTED :: PILOT VERIFIED", COL_OK);
    addCli("> POWER TRANSFER :: ACTIVE", COL_MAIN);
    statusText = "POWER TRANSFER IN PROGRESS...";
    pcPower = "TRANSFERRING";
    pcPowerCol = color(68, 255, 136);
    progColor = COL_OK;
    phase = 4;
}

void doFail(String reason) {
    pwAttempts++;
    addLog("[ERR] AUTH FAILED :: " + reason, COL_ERR);
    addCli("> DENIED :: " + reason, COL_ERR);
    statusText = "AUTH FAILED";
    flickering = true;
    flickerCount = 0;
    flickerLast = millis();
}

void onFlashDone() {
    if (pwAttempts < 3) {
        addLog("[WARN] RETRY " + pwAttempts + "/3", COL_MAIN);
        pwInput = "";
        authDone = false;
        timedOut = false;
        pwVisible = true;
        authStart = millis();
        statusText = "RETRY " + (pwAttempts + 1) + "/3 :: ENTER CODE";
        progColor = COL_WARN;
    } else {
        addLog("[CRITICAL] LOCKOUT :: MAX ATTEMPTS", COL_ERR);
        statusText = "SYSTEM LOCKED :: CONTACT ADMINISTRATOR";
        progWidth = 100;
        progColor = COL_ERR;
    }
}

void loadPassword() {
    String[] lines = loadStrings("secret.txt");
    if (lines != null && lines.length > 0) {
        secretPassword = lines[0].trim();
    }
}
