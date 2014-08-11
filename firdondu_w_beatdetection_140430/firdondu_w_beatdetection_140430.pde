import processing.serial.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
 
Minim minim;
AudioPlayer song;
AudioInput in;
BeatDetect beat;
 
Serial serialPort;
 
float eRadius;
 
void setup()
{
  size(400, 400, P3D);
  
  //serial = new Serial(this, "/dev/tty.usbmodemfd111", 9600);
  
  minim = new Minim(this);
  minim.debugOn();
  
  in = minim.getLineIn(Minim.STEREO, int(512));
  
  beat = new BeatDetect();
  beat.setSensitivity(20);
 
  ellipseMode(CENTER);
  eRadius = 20;
}
 
void draw()
{ 
  background(0);
  beat.detect(in.mix);
  float a = map(eRadius, 20, 80, 60, 255);
  fill(60, 255, 0, a);
  if ( beat.isOnset() ) {
  
    //serialPort.write("BANG");
    eRadius = 80;
  }
  ellipse(width/2, height/2, eRadius, eRadius);
  eRadius *= 0.9;
  if ( eRadius < 20 ) eRadius = 20;
}
 
void stop()
{
  in.close();
  minim.stop();
  super.stop();
} 
