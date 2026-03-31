// ============================================================
//  データクラス・ユーティリティ
// ============================================================

void addLog(String msg, int c) { logs.add(new LogEntry(msg, c)); }
void addCli(String msg, int c) { cliLines.add(new LogEntry(msg, c)); }

class LogEntry {
  String msg;
  int col;
  LogEntry(String m, int c) { msg=m; col=c; }
}
