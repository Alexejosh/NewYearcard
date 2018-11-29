House NYC;
Snowflake[] mysnow;

Firework[] f = new Firework[100];
boolean once;
float xpos = (float)(Math.random()*width);
float ypos = (float)(Math.random()*height);
double color7 = (Math.random()*50) + 105;
double color8 = (Math.random()*50) + 105;
double color9 = (Math.random()*50) + 105;
int time;
int count;



void setup() {
  // background(0);
  size(1280, 720);
  frameRate(45);
  NYC=new House();
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

void draw() {
  if (time == 0) {
    count = 5;
  }
  background(0);
  if (time == 15) {
    time = 1;
    count--;
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
  }



  background(0);
  
  for (int j = 0; j < 900; j++)
  {
    mysnow[j].show();
    mysnow[j].move();
  }
  textSize(100);
  fill(255, 255, 10);
  text("Happy New Year's!", 175, 200); 

  for (int i = 0; i < f.length; i++) {
    f[i].show();
  }

  NYC.display();
}

void keyPressed() {
  if (key == CODED) {//shift
    if (keyCode == SHIFT) {
      //fill(0, 0, 0, 40);
      //rect(0, 0, width, height);
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
}



class Firework {
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
