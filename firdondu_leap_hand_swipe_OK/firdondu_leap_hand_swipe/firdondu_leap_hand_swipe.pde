import processing.serial.*;
import de.voidplus.leapmotion.*;


LeapMotion leap;
Serial serialcomm;


int       id;
PVector   direction=new PVector(0, 0, 0);
PVector   position=new PVector(0, 0, 0);
PVector   position_start=new PVector(0, 0, 0);




void setup() {

  size(800, 600);
  println( Serial.list());
    serialcomm =new Serial(this, "COM8", 9600);

  leap = new LeapMotion(this).withGestures("swipe");
}

void draw() {

  int fps = leap.getFrameRate();
  background(126);
}

void leapOnSwipeGesture (SwipeGesture g, int state) {

  int       id               = g.getId();
  PVector   direction        = g.getDirection();
  PVector   position_start         = g.getStartPosition();
  PVector   position         = g.getPosition();

  if (direction.x>=400) {
    println(id +"sağ swype");
    serialcomm.write("0 20 40 60 80 100 120 140 160 180 X");
  }
  if (direction.x<400) {
    println(id+"sol swype");
    serialcomm.write("180 160 140 120 100 80 60 40 20 0 X");
  }
}

