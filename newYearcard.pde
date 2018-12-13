House NYC;
Snowflake[] mysnow;
int z=55;
int y=55;

Firework[] f = new Firework[75];
boolean once;
float xpos = (float)(Math.random()*width);
float ypos = (float)(Math.random()*height);
double color7 = (Math.random()*150) + 105;
double color8 = (Math.random()*150) + 105;
double color9 = (Math.random()*150) + 105;
int time;
int count;
double bally =50;
double r, g, b;
int time2;


void setup() {
  size(1280,720);
  frameRate(45);
  setup2();
}
void setup2(){
  //NYC=new House();
  mysnow = new Snowflake[900];
  for (int i = 0; i < 900; i++)
  {
    mysnow[i] = new Snowflake((float)(Math.random() * width), (float) (Math.random() * height), 
      (float) (Math.random() *3), (float) (Math.random() * 11), (float)(Math.random() * 5), (float)(Math.random() * 10 - 5));
  }

  for (int i = 0; i < f.length; i++) {
    f[i] = new Firework();
  }
}
void reset() {
  setup2();
  time = 0;
  time2 = 0;
  //draw();
}
void draw() {
  Time();
  for (int j = 0; j < 900; j++)
  {
    mysnow[j].show();
    mysnow[j].move();
  }

  for (int i = 0; i < f.length; i++) {
    color7 = (Math.random()*150) + 105;
    color8 = (Math.random()*150) + 105;
    color9 = (Math.random()*150) + 105;
    f[i].show();
  }

  NYC.display();
  fill((float)r, (float)g, (float)b);
  stroke(0);
  rect(40, 50, 40, 500);
  rect(20, 500, 80, 50);
  noStroke();
  ellipse(60, (float)bally, 55, 55);

  {
    ypos=height;
    xpos = (float)Math.random()*width;
    once = false;
    for (int i = 0; i < f.length; i++) {
      if ((f[i].hidden)&&(!once)) {
        f[i].show();
        f[i].move();
        once = true;
      }
    }
  }
}

public void Time() {



  if (time == 0) {
    count = 5;
    bally=20;
  }
  background(0);
  if (time == 15) {
    time = 1;
    count--;
    time2++;
  }
  if (count > 0) {
    textSize(100);
    fill(255, 255, 10);
    text(count, 200*(6-count), 200);
  }
  if (count < 1)
  {
    textSize(100);
    fill(255, 255, 10);
    text("Happy New Year's!", 175, 200);
    bally=500;
  }
  bally+=6.2;
  r=(Math.random()*150) + 105;
  g=(Math.random()*150) + 105;
  b=(Math.random()*150) + 105;
  time++;
  if(time2 == 30)
  {
    reset();
  }
}

class Firework {
  /* Code from "Fireworks" by Anders Fisher
   http://www.openprocessing.org/sketch/17259
   Licensed under Creative Commons Attribution ShareAlike
   https://creativecommons.org/licenses/by-sa/2.0
   https://creativecommons.org/licenses/GPL/2.0/
   */
  float x, y, oldX, oldY, ySpeed, targetX, targetY, Timer, fWeight, fAngle;
  int flareAmount, duration;
  boolean launched, exploded, hidden;
  color flare;
  Firework() {
    launched = false;
    exploded = false;
    hidden = true;
  }
  void keyPressed() {
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
    fill(0, 0, 0, 20);
    rect(0, 0, width, height);
    x  = xpos ;
    y  = ypos;
    targetX = (float)Math.random()*width;
    targetY = (float)Math.random()*height+0;
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
