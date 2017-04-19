class RoadSign {
  private PVector pos;
  private PImage image;
  public RoadSign(int type) {
    pos = new PVector(0, -100);
    switch (type) {
      case 0: image = loadImage("Aber.jpg"); break;
      case 1: image = loadImage("Jahat.png"); break;
      case 2: image = loadImage("Sorat.png"); break;
      case 3: image = loadImage("Ehtyat1.png"); break;
      case 4: image = loadImage("Ehtyat2.png"); break;
      case 5: image = loadImage("Madrese1.png"); break;
      case 6: image = loadImage("Madrese1.png"); break;
    }
  }
  public void display() {
    image(image, pos.x, pos.y); 
  }
  public void move(MyCar myCar) {
    pos.y -= myCar.velocity.y;
  }
  public boolean checkOutOfScreen() {
    if (pos.y > height + 10)
      return true;
    return false;
  }
}