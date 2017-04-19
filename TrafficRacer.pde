Game newGame;
void setup() {
  size(700, 701);
  frameRate(ControlPanel.frameRate);
  newGame = new Game(this);  
}
void draw() {
  newGame.display();
}
void keyPressed() {
  newGame.handleKeyDown(keyCode);
}
void keyReleased() {
  newGame.handleKeyUp(keyCode);
}
void mousePressed() {
  newGame.handleMousePress();
}