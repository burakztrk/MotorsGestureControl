// Bunu daha once yaptik burak in laptop da

import de.voidplus.leapmotion.*;

LeapMotion leap; 

void setup() {
  
  size(800, 600);
  
  leap = new LeapMotion(this);
}

void draw() {

  int fps = leap.getFrameRate();
  
}
