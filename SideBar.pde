class SideBar {
  private PImage filledHeartImage, unfilledHeartImage;
  public Button startButton, againButton;
  private SpeedIndicator speedIndicator; 
  private PFont font;
  public SideBar() {
    filledHeartImage = loadImage("filledHeart.png"); 
    unfilledHeartImage = loadImage("unfilledHeart.png"); 
    startButton = new Button(510, 640, 170, 40, "شروع", true);
    againButton = new Button(510, 640, 170, 40, "دوباره", false);
    speedIndicator = new SpeedIndicator(510, 290);
    font = createFont("A.Mosalas.ttf", 24);
    textFont(font);
    textAlign(RIGHT);
  }
  public void display(int score, MyCar myCar, int lives, int gameMode) {
    startButton.display();
    againButton.display();
    int dis = score;
    int speed = (gameMode == 0) ? 0 : (int) (13 + (-3 * myCar.velocity.y));
    fill(0);
    displayDistance(dis);
    displaySpeed(speed);
    textSize(20);
    displayLives(lives);
    displayeBestScore();
  } 
  private void displayLives(int lives) {
    textSize(22);
    text("فرصت:", 680, 140);
    for(int i = 0; i < lives; i++) {
      image(filledHeartImage, 510 + (i * (filledHeartImage.width + 10)), 165);
    }
    for(int i = 0; i < ControlPanel.lives - lives; i++) {
      image(unfilledHeartImage, 510 + ((i + lives) * (filledHeartImage.width + 10)), 165);
    }
  }
  private void displayDistance(int distance) {
    textSize(22);
    text("مسافت:", 680, 40);
    textSize(50);
    text(distance, 680, 90);
    textSize(13);
    text("متر", 530, 90);
  }
  private void displaySpeed(int speed) {
    textSize(20);
    text("سرعت:", 680, 270);
    speedIndicator.display(speed);
    textSize(40);
    text(speed, 660, 450);
    textSize(13);
    text("کیلومتر بر ساعت", 660, 470);
  }
  private void displayeBestScore() {
    textSize(20);
    text("رکورد:", 680, 550);
    textSize(40);
    text(getBestScore(), 680, 600);
    textSize(22);
  }
  public int getBestScore() {
    return Integer.parseInt((loadStrings("best.txt"))[0]);
  }
}