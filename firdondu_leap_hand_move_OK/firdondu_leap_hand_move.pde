import de.voidplus.leapmotion.*;

LeapMotion leap; 

void setup() {
  
  size(800, 600);
  
  leap = new LeapMotion(this).withGestures("swipe");
}

void draw() {

  int fps = leap.getFrameRate();
  
  background(0);
  
  
  int hand_count = leap.getHands().size();
  
  if(hand_count == 0) {
  
    println("Hand does not occure!");
  }
  if(hand_count == 1) {
  
    PVector hand_position = new PVector(-1,-1,-1);
    
    for(Hand hand : leap.getHands()){

    hand.draw();
    int     hand_id          = hand.getId();
    hand_position    = hand.getPosition();
//    PVector hand_stabilized  = hand.getStabilizedPosition();
//    PVector hand_direction   = hand.getDirection();
//    PVector hand_dynamics    = hand.getDynamics();
//    float   hand_roll        = hand.getRoll();
//    float   hand_pitch       = hand.getPitch();
//    float   hand_yaw         = hand.getYaw();
//    float   hand_time        = hand.getTimeVisible();
//    PVector sphere_position  = hand.getSpherePosition();
//    float   sphere_radius    = hand.getSphereRadius();
    }
    
    //println(hand_position);
    int handYPosScaled = int(map(hand_position.y, 0, 500, 0, 100));
    println(handYPosScaled);    // Seri porttan yollanacak dada
  }
  else {
  
    println("Too many hands on sight!");
  }
  
}


