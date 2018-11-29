public class Fireworks {
  float x, y, oldX, oldY, ySpeed, targetX, targetY, Timer, fWeight, fAngle;
  int flareAmount, duration;
  boolean launched, exploded, hidden;
  color flare;
  double color7 = (Math.random()*50) + 105;
  double color8 = (Math.random()*50) + 105;
  double color9 = (Math.random()*50) + 105;

  Fireworks() {
    launched = false;
    exploded = false;
    hidden = true;
  }

  void show() {
    if ((launched)&&(!exploded)&&(!hidden)) {
      launchMaths();
      strokeWeight(5);
      stroke(255);
      line(x, y, oldX, oldY);
    }
    if ((!launched)&&(exploded)&&(!hidden)) {
      explodeMaths();
      noStroke();
      strokeWeight(fWeight);
      stroke(flare);
      for (int i = 0; i < flareAmount + 1; i++) {
        pushMatrix();
        translate(x, y);
        point(sin(radians(i*fAngle))*Timer, cos(radians(i*fAngle))*Timer);
        popMatrix();
      }
    }
    if ((!launched)&&(!exploded)&&(hidden)) {
    }
  }
  void move() {
    //fill(0, 0, 0, 20);
    //rect(0, 0, width, height);
    x  = xpos ;
    y  = ypos;
    targetX = (float)Math.random()*width;
    targetY = (float)(Math.random()*height)+20;
    ySpeed = random(3) + 2;
    flare = color((int)color7, (int)color8, (int)color9);
    flareAmount = ceil(random(100)) + 50;
    fWeight = (float)Math.random()*4;
    duration = ceil(random(8))*20 + 30;
    fAngle = 500/flareAmount;
    launched = true;
    exploded = false;
    hidden = false;
  }
  void launchMaths() {
    oldX = x;
    oldY = y;
    if (dist(x, y, targetX, targetY) > 6) {
      x += (targetX - x)/2;
      y += -ySpeed;
    } else {
      explode();
    }
  }
  void explode() {
    Timer = 0;
    launched = false;
    exploded = true;
    hidden = false;
  }
  void explodeMaths() {
    if (Timer < duration) {
      Timer+= 0.4;
    } else {
      hide();
    }
  }
  void hide() {
    launched = false;
    exploded = false;
    hidden = true;
  }
}
