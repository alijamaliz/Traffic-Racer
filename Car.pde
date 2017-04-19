abstract class Car {
  PVector pos, velocity, accelerate;
  private PImage image;
  private int type;
  public Car() {
    
  }
  public Car(int type, int lane) {
    this.type = type;
    accelerate = new PVector(0, -0.01);
    velocity = new PVector(0, -3);
    if (lane == 3 || lane == 4)
      image = loadImage("car" + type + ".png");
    else
      image = loadImage("car" + type + "-r.png");
  }
  public void display() {
    image(image, pos.x - getWidth() / 2, pos.y);
  }
  public int getHeight() {
    return image.height; 
  }
  public int getWidth() {
    return image.width; 
  }
  public void setImage(String path) {
    image = loadImage(path); 
  }
}