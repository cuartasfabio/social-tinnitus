class Cube {
  float startingZ = -10000;
  float maxZ = 1000;

  float x, y, z;
  float rotX, rotY, rotZ;
  float sumRotX, sumRotY, sumRotZ;

  public Cube() {
    x = random(0, width);
    y = random(0, height);
    z = random(startingZ, maxZ);

    rotX = random(0, 1);
    rotY = random(0, 1);
    rotZ = random(0, 1);
  }

  void display(float intensity, float scoreGlobal) {

    color displayColor = color(random(0,255), random(0,255), random(0,255), intensity*5);
    fill(displayColor, 255);

    color strokeColor = color(255, 150-(20*intensity));
    stroke(strokeColor);
    strokeWeight(random(0.4, 2));

    pushMatrix();

    translate(x, y, z);

    sumRotX += intensity*(rotX/1000);
    sumRotY += intensity*(rotY/1000);
    sumRotZ += intensity*(rotZ/1000);

    rotateX(sumRotX);
    rotateY(sumRotY);
    rotateZ(sumRotZ);

    rotateY(map(mouseX, 0, width, 0, PI));
    rotateX(map(mouseY, 0, height, 0, PI));

    box(100+(intensity/2));

    popMatrix();

    z+= (1+(intensity/5)+(pow((scoreGlobal/150), 2)));

    if (z >= maxZ) {
      x = random(0, width);
      y = random(0, height);
      z = startingZ;
    }
  }
}
