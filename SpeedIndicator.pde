class SpeedIndicator {
  private PVector pos;
  public SpeedIndicator(int x, int y) {
    pos = new PVector(x, y);
  }
  public void display(int speed) {
    if (speed > 100)
      speed = 100;
    for (int i = 0; i < 200; i+=2) {
      stroke(136);
      line(pos.x, pos.y + (200 - i), 10 + pos.x + (i*i/250), pos.y + (200 - i));
      line(pos.x, pos.y + (200 - i) + 1, 10 + pos.x + (i*i/250), pos.y + (200 - i) + 1);
    }
    for (int i = 0; i < speed*2; i+=2) {
      stroke(155 + i, 255 - i, 0);
      line(pos.x, pos.y + (200 - i), 10 + pos.x + (i*i/250), pos.y + (200 - i));
      line(pos.x, pos.y + (200 - i) + 1, 10 + pos.x + (i*i/250), pos.y + (200 - i) + 1);
    }
    textSize(22);
    text("100", pos.x + 25, pos.y - 2);
    textSize(17);
    text("0", pos.x + 8, pos.y + 200 + 15);
    textSize(20);
    stroke(0);
  }
}