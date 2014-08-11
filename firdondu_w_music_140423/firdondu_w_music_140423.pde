import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim;  
AudioInput audioInput;

FFT fftLin;
FFT fftLog;


float height3;
float height23;
float spectrumScale = 4;

PFont font;

void setup()
{
  size(800, 600);
  height3 = height / 3;
  height23 = 2 * height / 3;

  minim = new Minim(this);
  audioInput = minim.getLineIn();
  
  fftLin = new FFT( audioInput.bufferSize(), audioInput.sampleRate() );
  fftLin.linAverages( 30 );
  
  fftLog = new FFT( audioInput.bufferSize(), audioInput.sampleRate() );
  fftLog.logAverages( 22, 3 );
  
  rectMode(CORNERS);
  font = loadFont("Dialog-12.vlw");
}

void draw()
{
  background(0);
  
  textFont(font);
  textSize( 18 );
 
  float centerFrequency = 0;
  
  fftLin.forward( audioInput.mix );
  fftLog.forward( audioInput.mix );
 
  // draw
  {
    noFill();
    for(int i = 0; i < fftLin.specSize(); i++)
    {
      if ( i == mouseX )
      {
        centerFrequency = fftLin.indexToFreq(i);
        stroke(255, 0, 0);
      }
      else
      {
          stroke(255);
      }
      line(i, height3, i, height3 - fftLin.getBand(i)*spectrumScale);
    }
    
    fill(255, 128);
    text("Spectrum Center Frequency: " + centerFrequency, 5, height3 - 25);
  }
  
  noStroke();
  
  // draw the linear averages
  {
    int w = int( width/fftLin.avgSize() );
    for(int i = 0; i < fftLin.avgSize(); i++)
    {
      if ( mouseX >= i*w && mouseX < i*w + w )
      {
        centerFrequency = fftLin.getAverageCenterFrequency(i);
        
        fill(255, 128);
        text("Linear Average Center Frequency: " + centerFrequency, 5, height23 - 25);
        
        fill(255, 0, 0);
      }
      else
      {
          fill(255);
      }
      rect(i * w, height23, i * w + w, height23 - fftLin.getAvg(i) * spectrumScale);
    }
  }
  
  // draw the logarithmic averages
  {
    for(int i = 0; i < fftLog.avgSize(); i++)
    {
      centerFrequency    = fftLog.getAverageCenterFrequency(i);
      float averageWidth = fftLog.getAverageBandWidth(i);   
      
      float lowFreq  = centerFrequency - averageWidth/2;
      float highFreq = centerFrequency + averageWidth/2;
      
      int xl = (int)fftLog.freqToIndex(lowFreq);
      int xr = (int)fftLog.freqToIndex(highFreq);
      
      if ( mouseX >= xl && mouseX < xr )
      {
        fill(255, 128);
        text("Logarithmic Average Center Frequency: " + centerFrequency, 5, height - 25);
        fill(255, 0, 0);
      }
      else
      {
          fill(255);
      }
      rect( xl, height, xr, height - fftLog.getAvg(i)*spectrumScale );
    }
  }
}
