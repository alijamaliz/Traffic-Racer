import java.io.*;
class Game {
  private Road road;
  private MyCar myCar;
  private SideBar sideBar = new SideBar();
  private SoundManager soundManager;
  private Timer timer;
  private OtherCar[] otherCars;
  private int totalCarsInScreen;
  private int lives;
  private int gameMode;
  private int score;
  private int accidentIgnorance;
  public Game(TrafficRacer parent) {
    gameMode = 0;
    score = 0;
    accidentIgnorance = 5;
    lives = ControlPanel.lives;
    totalCarsInScreen = ControlPanel.totalCarsInScreen;
    road = new Road();
    myCar = new MyCar();
    otherCars = new OtherCar[totalCarsInScreen];
    soundManager = new SoundManager(parent);
    soundManager.playBackgroundMusic();
  }
  private void update() {
    if (road.getMinSpeed() > -4 - (score / 200)){
      road.increaseMinSpeed();
    }
    road.move(myCar);
    if (gameMode > 0) {
      myCar.move();
    }
    if(timer != null && timer.isFinished()) {
      gameMode = 2;
      timer = null;
    }
    if (gameMode > 0)
      score = (-1 * road.distance) / 100;
    if (gameMode > 1) {
      for (int i = 0; i < totalCarsInScreen; i++) {
        if(otherCars[i] == null || otherCars[i].checkOutOfScreen()) {
          otherCars[i] = createNewOtherCar();
        }
        otherCars[i].move(myCar);
      }
      if(checkAcceident()) {
        if (!ControlPanel.godMode) accident();
      }
    }
  } 
  private void accident() {
    gameMode = 1;
    soundManager.playSound("accident");
    for (int i = 0; i < totalCarsInScreen; i++) {
      otherCars[i] = null;
    }
    if (--lives == 0)
      gameOver();
    else {
      myCar = new MyCar();
      timer = new Timer(4000);
    }
  }
  private void gameOver() {
    if (score > sideBar.getBestScore())
      changeBestScore(score);
    gameMode = 0;
    myCar.pos.y = height + 50;
  }
  private OtherCar createNewOtherCar() {
    OtherCar otherCar;
    boolean flag;
    do {
      int type = (int) random(8) + 1;
      PVector pos = new PVector(0, 0);
      PVector velocity = new PVector(0, 0);
      int lane = (int) random(4) + 1;
      switch(lane) {
        case 1: pos = new PVector(62, (int)((-1)*random(100)) - 250); velocity = new PVector(0, (int)(random(2) + 3)); break;
        case 2: pos = new PVector(187, (int)((-1)*random(100)) - 250); velocity = new PVector(0, (int)(random(2) + 3)); break;
        case 3: pos = new PVector(312, (int)((-1)*random(100)) - 250); velocity = new PVector(0, (int)((-1)*(random(2) + 3))); break;
        case 4: pos = new PVector(437, (int)((-1)*random(100)) - 250); velocity = new PVector(0, (int)((-1)*(random(2) + 3))); break;
      }
      otherCar = new OtherCar(type, lane, pos, velocity);
      flag = false;
      for (OtherCar anotherCar: otherCars) {
        if (checkCollisionOfTwoCar(otherCar, anotherCar))
          flag = true;
      }
    }
    while (flag);
    return otherCar;
  } 
  private boolean checkCollisionOfTwoCar(OtherCar otherCar1, OtherCar otherCar2) {
    if (otherCar1 == null || otherCar2 == null)
      return false;
    if(otherCar1.lane == otherCar2.lane) {
      if (otherCar1.lane == 3 || otherCar1.lane == 4)
        if (Math.abs(otherCar1.velocity.y) < Math.abs(otherCar2.velocity.y))
          return true;
      if (otherCar1.lane == 1 || otherCar1.lane == 2)
        if (Math.abs(otherCar1.velocity.y) > Math.abs(otherCar2.velocity.y))
          return true;
      if (otherCar1.pos.y < otherCar2.pos.y && otherCar1.pos.y + otherCar1.getHeight() > otherCar2.pos.y)
        return true;
      if (otherCar1.pos.y < otherCar2.pos.y + otherCar2.getHeight() && otherCar1.pos.y + otherCar1.getHeight() > otherCar2.pos.y + otherCar2.getHeight())
        return true;
      if (otherCar1.pos.y > otherCar2.pos.y && otherCar1.pos.y + otherCar1.getHeight() < otherCar2.pos.y + otherCar2.getHeight())
        return true;
      if (otherCar1.pos.y < otherCar2.pos.y && otherCar1.pos.y + otherCar1.getHeight() > otherCar2.pos.y + otherCar2.getHeight())
        return true;
    }
    return false;
  }
  private boolean checkAcceident() {
    for (OtherCar otherCar: otherCars) {
      if (otherCar != null) {
        if (otherCar.pos.y < myCar.pos.y && otherCar.pos.y + otherCar.getHeight() > myCar.pos.y)
          if ((otherCar.pos.x < myCar.pos.x + accidentIgnorance && otherCar.pos.x + otherCar.getWidth() > myCar.pos.x + accidentIgnorance) || (otherCar.pos.x < myCar.pos.x + myCar.getWidth() - accidentIgnorance && otherCar.pos.x + otherCar.getWidth() > myCar.pos.x  + myCar.getWidth() - accidentIgnorance))
            return true;
        if (otherCar.pos.y < myCar.pos.y + myCar.getHeight() && otherCar.pos.y + otherCar.getHeight() > myCar.pos.y + myCar.getHeight())
          if ((otherCar.pos.x < myCar.pos.x + accidentIgnorance && otherCar.pos.x + otherCar.getWidth() > myCar.pos.x + accidentIgnorance) || (otherCar.pos.x < myCar.pos.x + myCar.getWidth() - accidentIgnorance && otherCar.pos.x + otherCar.getWidth() > myCar.pos.x  + myCar.getWidth() - accidentIgnorance))
            return true;
        if (otherCar.pos.y > myCar.pos.y && otherCar.pos.y + otherCar.getHeight() < myCar.pos.y + myCar.getHeight())
          if ((otherCar.pos.x < myCar.pos.x + accidentIgnorance && otherCar.pos.x + otherCar.getWidth() > myCar.pos.x + accidentIgnorance) || (otherCar.pos.x < myCar.pos.x + myCar.getWidth() - accidentIgnorance && otherCar.pos.x + otherCar.getWidth() > myCar.pos.x  + myCar.getWidth() - accidentIgnorance))
            return true;
        if (otherCar.pos.y < myCar.pos.y && otherCar.pos.y + otherCar.getHeight() > myCar.pos.y + myCar.getHeight())
          if ((otherCar.pos.x < myCar.pos.x + accidentIgnorance && otherCar.pos.x + otherCar.getWidth() > myCar.pos.x + accidentIgnorance) || (otherCar.pos.x < myCar.pos.x + myCar.getWidth() - accidentIgnorance && otherCar.pos.x + otherCar.getWidth() > myCar.pos.x  + myCar.getWidth() - accidentIgnorance))
            return true;
      }
    }
    return false;
  }
  private void display() {
    fill(220);
    rect(0, 0, width, height);
    update();
    road.display();
    for (OtherCar otherCar : otherCars) {
      if (otherCar != null) otherCar.display();
    }
    myCar.display();
    sideBar.display(score, myCar, lives, gameMode);
  }
  public void handleKeyDown(int keyCode) {
    if (gameMode != 0) {
      if (keyCode == 10)
        soundManager.playSound("horn");
      if (keyCode == 38)
        soundManager.loopSound("idle");
      myCar.handleKeyDown(keyCode);
    }
  }
  public void handleKeyUp(int keyCode) {
    if (gameMode != 0) {
      if (keyCode == 38)
        soundManager.stopSound("idle");
      myCar.handleKeyUp(keyCode);
    }
  }
  public void handleMousePress() {
    if(sideBar.startButton.isMouseOver()) {
      sideBar.startButton.setVisibility(false);
      sideBar.againButton.setVisibility(true);
      soundManager.playSound("start");
      startGame();
    }
    if(sideBar.againButton.isMouseOver()) {
      playAgain();
    }
  }
  private void startGame() {
    gameMode = 1;
    timer = new Timer(4000);
  }
  private void playAgain() {
    lives = ControlPanel.lives;
    road.distance = 0;
    for (int i = 0; i < otherCars.length; i++) {
      otherCars[i] = null;
    }
    myCar = new MyCar();
    startGame();
  }
  private void changeBestScore(int newBestScore) {
    String[] list = new String[1];
    list[0] = Integer.toString(newBestScore);
    saveStrings("data/best.txt", list);
  }
}