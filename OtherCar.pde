class OtherCar extends Car {
  int lane;
  public OtherCar(int type, int lane, PVector pos, PVector velocity) {
    super(type, lane);
    this.lane = lane;
    this.pos = pos;
    this.velocity = velocity;
    accelerate = new PVector(0, 0);
  }
  void move(MyCar myCar) {
    velocity.add(accelerate);
    pos.add(velocity);
    pos.y -= myCar.velocity.y;
  }
  public boolean checkOutOfScreen() {
    if (pos.y > height + 10)
      return true;
    return false;
  }
}