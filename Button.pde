class Button {
  private PVector pos;
  private PVector textPos;
  private int width, height;
  private String text;
  private boolean visible;
  public Button (int x, int y, int width, int height, String text, boolean visible) {
    pos = new PVector(x, y);
    this.width = width;
    this.height = height;
    this.text = text;
    this.visible = visible;
    if (text == "شروع")
      textPos = new PVector((pos.x + width / 2) + 22, (pos.y + height / 2) + 4);
    if (text == "دوباره")
      textPos = new PVector((pos.x + width / 2) + 28, (pos.y + height / 2) + 4);
  }
  public void display() {
    if(visible) {
      fill(0,177,220);
      rect(pos.x, pos.y, width, height);
      fill(0);
      text(text, textPos.x, textPos.y);
    }
  }
  public boolean isMouseOver() {
    if (mouseX > pos.x && mouseX < pos.x + width && mouseY > pos.y && mouseY < pos.y + height && visible)
      return true;
    return false;
  }
  public void setVisibility(boolean visible) {
    this.visible = visible;
  }
}