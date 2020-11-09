class Dot {
  PVector position;
  PVector veliocity;
  PVector accelaration;
  Path path;

  boolean dead = false;
  boolean reachedGoal = false;
  boolean isBest = false;

  float efficiency = 0;
  float maxEfficiency = 0;

  Dot() {
    path = new Path(500);
    position = new PVector(width/2, height-10);
    veliocity = new PVector(0, 0);
    accelaration = new PVector(0, 0);
  }

  void show() {
    if (isBest) {
      fill(255, 0, 0);
      ellipse(position.x, position.y, 8, 8);
    } else {
      fill(0);
      ellipse(position.x, position.y, 4, 4);
    }
  }

  void move() {
    if (path.accelaraions.length > path.step) {
      accelaration = path.accelaraions[path.step];
      path.step++;
    } else dead = true;
    veliocity.add(accelaration);
    veliocity.limit(5);
    position.add(veliocity);
  }

  void update() {
    if (!dead && !reachedGoal) {
      move();
      if (position.x<4 || position.y<4 || position.x>width-4 || position.y>height-4) dead = true;
      else if (dist(position.x, position.y, goal.x, goal.y)<8) reachedGoal = true;
      else if (position.y > 60 && position.y < 80 && position.x > 0 && position.x < 400) dead = true;
    }
  }

  void calculateFitness() {
    if (reachedGoal) maxEfficiency = 1.0/16.0 + 10000.0/pow((float)path.step, 2);
    else {
      float differenceToGoal = distance(position.x, position.y);
      maxEfficiency = 1.0/pow(differenceToGoal, 4);
    }
    if (maxEfficiency > efficiency) efficiency = maxEfficiency;
  }

  Dot child() {
    Dot baby = new Dot();
    baby.path = path.clone();
    return baby;
  }
}
