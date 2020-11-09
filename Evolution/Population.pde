class Population {
  Dot[] dots;
  float efficiencySum;
  int generation = 1;

  int bestDot = 0;

  int minStep = 500;

  Population(int size) {
    dots = new Dot[size];
    for (int i = 0; i < size; i++) {
      dots[i] = new Dot();
    }
  }

  void show() {
    for (int i = 0; i < dots.length; i++) {
      dots[i].show();
    }
    dots[0].show();
  }

  void update() {
    for (int i = 0; i < dots.length; i++) {
      if (dots[i].path.step > minStep) dots[i].dead = true;
      else dots[i].update();
    }
  }

  void calculateEfficiency() {
    for (int i = 0; i < dots.length; i++) {
      dots[i].calculateFitness();
    }
  }

  boolean allDotsDead() {
    for (int i = 0; i < dots.length; i++) {
      if (!dots[i].dead && !dots[i].reachedGoal) return false;
    }
    return true;
  }

  void naturalSelection() {
    Dot[] newDots = new Dot[dots.length];
    setBestDot();
    calculateFitnessSum();
    newDots[0] = dots[bestDot].child();
    newDots[0].isBest = true;
    for (int i = 1; i < newDots.length; i++) {
      Dot parent = selectParent();
      newDots[i] = parent.child();
    }
    dots=newDots.clone();
    generation++;
  }

  void calculateFitnessSum() {
    efficiencySum = 0;
    for (int i = 0; i < dots.length; i++) {
      efficiencySum += dots[i].efficiency;
    }
  }

  Dot selectParent() {
    float rand = random(efficiencySum);
    float runningSum=0;

    for (int i = 0; i < dots.length; i++) {
      runningSum += dots[i].efficiency;
      if (runningSum > rand) return dots[i];
    }
    return null;
  }

  void mutateChilds() {
    for (int i = 1; i < dots.length; i++) {
      dots[i].path.mutate();
    }
  }

  void setBestDot() {
    float max = 0;
    int maxIndex = 0;
    for (int i = 0; i < dots.length; i++) {
      if (dots[i].efficiency > max) {
        max = dots[i].efficiency;
        maxIndex = i;
      }
    }
    bestDot = maxIndex;

    if (dots[bestDot].reachedGoal) minStep = dots[bestDot].path.step;
  }
}
