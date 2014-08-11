import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim;  
AudioInput audioInput;

FFT fft;

int w;

void setup() {

  size(800, 600);
  
  minim = new Minim(this);
  audioInput = minim.getLineIn(Minim.STEREO, 512);
  fft = new FFT( audioInput.bufferSize(), audioInput.sampleRate() );
  fft.logAverages(60, 7);
  
  
  
  w = width / fft.avgSize();

  strokeWeight(w);
  stroke(255);
  strokeCap(SQUARE);
}

void draw() {
  
  background(30);
  
  fft.forward( audioInput.mix );
  
  for(int i = 0; i < fft.avgSize(); i++) {
      
    line(i * w + w / 2, height, i * w + w / 2, height - fft.getBand(i) * 4);
  }
}
