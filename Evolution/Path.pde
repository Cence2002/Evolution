class Path {
  PVector[] accelaraions;
  int step = 0;


  Path(int size) {
    accelaraions = new PVector[size];
    randomise();
  }

  void randomise() {
    for (int i = 0; i < accelaraions.length; i++) {
      float randomAngle = random(2*PI);
      accelaraions[i] = PVector.fromAngle(randomAngle);
    }
  }

  Path clone() {
    Path clone=new Path(accelaraions.length);
    for (int i = 0; i < accelaraions.length; i++) {
      clone.accelaraions[i] = accelaraions[i].copy();
    }

    return clone;
  }

  void mutate() {
    float mutationRate = 0.05;
    for (int i = 0; i < accelaraions.length; i++) {
      float rand = random(1);
      if (rand < mutationRate) {
        float randomAngle = random(2*PI);
        accelaraions[i] = PVector.fromAngle(randomAngle);
      }
    }
  }
}
