class MyCar extends Car {
  private String rlKeysStatus;
  private String udKeysStatus;
  private int accInterval = 3;
  private int accCounter = 0;
  private Timer timer;
  public MyCar() {
    rlKeysStatus = "";
    udKeysStatus = "";
    setImage("myCar.png");
    pos = new PVector (width / 2 - getWidth() / 2, height + 80);
    velocity = new PVector(0, -30);
    accelerate = new PVector(0, 1);
    timer = new Timer (3000);
  }
  public void handleKeyDown(int keyCode) {
    switch(keyCode) {
      case 37: if(!rlKeysStatus.contains("l")) rlKeysStatus = "l" + rlKeysStatus; break;
      case 38: if(!udKeysStatus.contains("u")) udKeysStatus = "u" + udKeysStatus; break;
      case 39: if(!rlKeysStatus.contains("r")) rlKeysStatus = "r" + rlKeysStatus; break;
      case 40: if(!udKeysStatus.contains("d")) udKeysStatus = "d" + udKeysStatus; break;
    }
  }
  public void handleKeyUp(int keyCode) {
    switch(keyCode) {
      case 37: rlKeysStatus = rlKeysStatus.replace("l", ""); break;
      case 38: udKeysStatus = udKeysStatus.replace("u", ""); break;
      case 39: rlKeysStatus = rlKeysStatus.replace("r", ""); break;
      case 40: udKeysStatus = udKeysStatus.replace("d", ""); break;
    }
  }
  public void move() {
    if(timer != null && timer.isFinished())
    {
      timer = null;
    }
    if (pos.y > height - getHeight() - 30) {
      pos.y -= 2;
    }
    if(rlKeysStatus.length() != 0) {
      if(rlKeysStatus.charAt(0) == 'r') {
        velocity.x = 4; 
        accelerate.x = -2;
      }
      if(rlKeysStatus.charAt(0) == 'l') {
        velocity.x = -6; 
        accelerate.x = 2;
      }
    }
    if(udKeysStatus.length() != 0) {
      if(udKeysStatus.charAt(0) == 'u') {
        accelerate.y = -1; //Accelerate
      }
      if(udKeysStatus.charAt(0) == 'd') {
        accelerate.y = 2; //Break
      }
    }
    else {
      accelerate.y = 1; //Friction
    }
    
    if (pos.x - (getWidth() / 2) + velocity.x > 10 && pos.x - (getWidth() / 2) + velocity.x < 500 - getWidth() - 10) {
      pos.x += velocity.x;
      if (accCounter % accInterval == 0) {
        velocity.x += accelerate.x; 
        accCounter = 0;
      }
      accCounter++;
    }
    else {
      if (pos.x - (getWidth() / 2) + velocity.x <= 10) pos.x = 11 + (getWidth() / 2);
      if (pos.x - (getWidth() / 2) + velocity.x >= 500 - getWidth() - 10) pos.x = 500 - (getWidth() / 2) - 11;
      velocity.x = 0;
    }
    if (velocity. x == 0) {
      accelerate.x = 0; 
    }
  }
}