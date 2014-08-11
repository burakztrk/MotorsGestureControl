// with Kinect

import processing.serial.*;
import tsps.*;

class Ball {
  float x, y, rad;
}

static int MOTOR_NUMBER = 10;

Serial serialPort;
TSPS tsps;



Ball[] balls; 

void setup() {

  size(800, 600);
  
  tsps = new TSPS(this, 12000);
  serialPort = new Serial(this, Serial.list()[0], 9600);
  
  
  balls = new Ball[MOTOR_NUMBER];
  for (int i = 0; i < MOTOR_NUMBER; i++) {
    
    balls[i] = new Ball();
    
    balls[i].x = (width / MOTOR_NUMBER) * i + (width / MOTOR_NUMBER) / 2;
    balls[i].y = 50;
    balls[i].rad = 50;
  }
}

void draw() {
  
  TSPSPerson[] people = tsps.getPeopleArray();
  float[] bXPoints = new float[people.length];
  for(int i = 0; i < people.length; i++) {
    bXPoints[i] = people[i].centroid.x * width;
    //println(bXPoints[i]);
  }
  float subGridWidth = width / MOTOR_NUMBER;
  
  
  for (int i = 0; i < MOTOR_NUMBER; i++) {
    
    balls[i].y = 50;  
  }
  
  for(int i = 0; i < bXPoints.length; i++) {
    int whichGrid = int(bXPoints[i] / subGridWidth);
    //println(whichGrid);
    balls[whichGrid].y = 200;
 
    if(whichGrid - 1 >= 0) {
    
      balls[whichGrid - 1].y = 150;
    }
    if(whichGrid - 2 >= 0) {
    
      balls[whichGrid - 2].y = 100;
    }
    if(whichGrid + 1 < MOTOR_NUMBER) {
    
      balls[whichGrid + 1].y = 150;
    }
    if(whichGrid + 2 < MOTOR_NUMBER) {
    
      balls[whichGrid + 2].y = 100;
    }    
  }
  
  String msg = ""; 
  for(int i = 0; i < MOTOR_NUMBER; i++) {
  
    msg += balls[i].y;
    msg += " ";
  }
  msg += "X";
  serialPort.write(msg);
 
 
  // DRAW
  background(20);
  translate(0, height);
  scale(1, -1);
 
  noStroke();
  fill(250);
  for (int i = 0; i < MOTOR_NUMBER; i++) {
    
    ellipse(balls[i].x, balls[i].y, balls[i].rad, balls[i].rad);         
  }
  
}
