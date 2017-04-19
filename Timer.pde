class Timer {
  private long startMillis;
  private int time;
  Timer(int time) {
    startMillis = millis();
    this.time = time;
  }
  public boolean isFinished() {
    if (millis() - startMillis >= time)
      return true;
    return false;
  }
}