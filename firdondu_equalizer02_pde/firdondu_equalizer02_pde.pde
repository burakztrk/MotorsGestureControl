import processing.serial.*;

import ddf.minim.analysis.*;
import ddf.minim.*;

Serial serialPort; 

Minim minim;  
AudioInput audioInput;

FFT fft;

int w;

int timeElapsed; 
int timeLastMsgSent;
int timeIntervalForDataSending;

void setup() {

  size(800, 600);
  
  serialPort = new Serial(this, Serial.list()[0], 9600);
  
  minim = new Minim(this);
  audioInput = minim.getLineIn(Minim.STEREO, 512);
  fft = new FFT( audioInput.bufferSize(), audioInput.sampleRate() );
  fft.logAverages(42, 1);
  
  
  w = width / fft.avgSize();

  strokeWeight(w);
  stroke(255);
  strokeCap(SQUARE);
  
  timeElapsed = millis();
  timeLastMsgSent = timeElapsed;
  timeIntervalForDataSending = 500;
}

void draw() {
  
  timeElapsed = millis();
  
  background(30);
  
  fft.forward( audioInput.mix );
  //println(fft.avgSize());
  
  float resizeFactor = 20;
  for(int i = 0; i < fft.avgSize(); i++) {
      
    line(i * w + w / 2, height, i * w + w / 2, height - fft.getBand(i) * resizeFactor);
  }
  
  if(timeElapsed >= timeLastMsgSent + timeIntervalForDataSending) {
    
    String msg = "";
    
    for(int i = 0; i < fft.avgSize(); i++) {
    
      msg += str(int(map(fft.getBand(i) * resizeFactor, 0, 200, 0, 100)));
      msg +=  " ";   
    }
    msg += "X";
    
    serialPort.write(msg);
    println(msg);
    
    timeLastMsgSent = timeElapsed;
  }
}

void stop()
{
  audioInput.close();
  minim.stop();
  super.stop();
}
