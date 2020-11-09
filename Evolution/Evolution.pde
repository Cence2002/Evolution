Population population;
PVector goal = new PVector(250, 25);

float distance(float x, float y) {
  if (y < 70 || y < (goal.y-60)/(goal.x-400)*x+(goal.x*60-goal.y*400)/(goal.x-400)) {
    return dist(goal.x, goal.y, x, y);
  } else if (x > 400) {
    return dist(60, 400, x, y) + dist(goal.x, goal.y, 60, 400);
  }
  return dist(400, 60, 400, 80) + dist(60, 400, x, y) + dist(goal.x, goal.y, 60, 400);
}

void setup() {
  size(500, 500);
  frameRate(100);
  population = new Population(500);
}

void draw() {
  background(255);
  fill(0, 255, 0);
  ellipse(goal.x, goal.y, 10, 10);

  fill(0, 0, 255);
  rect(0, 60, 400, 20);

  if (population.allDotsDead()) {
    population.calculateEfficiency();
    population.naturalSelection();
    population.mutateChilds();
  } else {
    population.update();
    population.show();
  }
}
