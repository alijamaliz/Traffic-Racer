class Road {
  private PImage roadImage;
  private RoadSign roadSign;
  int distance;  
  private int accInterval = 10;
  private int accCounter = 0;
  private int minSpeed;
  public Road() {
    roadImage = loadImage("road.jpg");
    distance = 0;
    minSpeed = -1 * ControlPanel.primitiveCarSpeed;
  }
  public void increaseMinSpeed() {
    minSpeed--;
  }
  public int getMinSpeed() {
    return minSpeed;
  }
  public void display() {
    image(roadImage, 0, -701 + ((-1) * distance) % 701); 
    if(roadSign != null) roadSign.display();
  }
  public void move(MyCar myCar) {
    handleSign();
    distance += myCar.velocity.y;
    if (accCounter % accInterval == 0)
    {
      if(myCar.velocity.y + myCar.accelerate.y <= minSpeed && myCar.velocity.y + myCar.accelerate.y >= -30) {
        myCar.velocity.y += myCar.accelerate.y; 
        accCounter = 0;
      }
      else {
        if (myCar.velocity.y + myCar.accelerate.y < -30) myCar.velocity.y = -30;
        if (myCar.velocity.y + myCar.accelerate.y > minSpeed) myCar.velocity.y = minSpeed;
        myCar.accelerate.y = 0;
      }
    }
    accCounter ++;
    if(roadSign != null) roadSign.move(myCar);
  }
  private void handleSign() {
    if (random(300) < 1) {
      if (roadSign == null)
        roadSign = new RoadSign((int)random(7));
      else if (roadSign.checkOutOfScreen())
        roadSign = new RoadSign((int)random(7));
    }
  }
}