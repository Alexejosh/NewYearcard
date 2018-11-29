public class Snowflake implements Snow {
  float X;
  float Y;
  float W;
  float H;
  float Speed;
  float Wiggle;
  Snowflake(float X2, float Y2, float W2, float H2, float Speed2, float Wiggle2) {
    X = X2;
    Y = Y2;
    W = W2;
    H = H2;
    Speed = Speed2;
    Wiggle = Wiggle2;
  }
  void move() {
    noStroke();
    if (Y > height)
    {
      Y = 0;
      X = (float)(Math.random() * width);
    } else {
      Y += Speed;
    }
    X += Wiggle;
  }
  void show() {
    noStroke();
    fill(255);
    ellipse(X, Y, W, H);
  }
}
