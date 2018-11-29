public class House {

  PImage photo;

  public House() {
    photo = loadImage("NYC.png");
  }

  public void display () {
    fill(255);
    image(photo, 0, 220);
  }
}
