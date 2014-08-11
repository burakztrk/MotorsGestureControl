import processing.serial.*;
import controlP5.*;
ControlP5 cp5;

 
Serial commPort = new Serial(this, Serial.list()[0], 9600);
int Max_STEP=0;
String sendData="";
String [] layer=new String[Max_STEP] ;

void setup() {

  size(800, 400);
  noStroke();
  cp5 = new ControlP5(this);

  cp5.addTextfield("Max_STEP").setPosition(730, 170).setSize(60, 20).setFocus(true).setColor(color(255, 255, 255));
  cp5.addButton("SEND").setValue(128).setPosition(730, 350).setSize(60, 20).updateSize();
  cp5.addButton("SET_0").setValue(128).setPosition(730, 20).setSize(60, 20).updateSize();
  cp5.addButton("SET_45").setValue(128).setPosition(730, 45).setSize(60, 20).updateSize();
  cp5.addButton("SET_90").setValue(128).setPosition(730, 70).setSize(60, 20).updateSize();
  cp5.addButton("SET_100").setValue(128).setPosition(730, 95).setSize(60, 20).updateSize();
  cp5.addButton("SET_135").setValue(128).setPosition(730, 120).setSize(60, 20).updateSize();
  cp5.addButton("SET_180").setValue(128).setPosition(730, 145).setSize(60, 20).updateSize();

  for (int i=10 ; i>=1 ;i--) {
    cp5.addSlider("motor"+i).setPosition((70*(10-i))+30, 20).setSize(40, 300).setRange(0, 180).setValue(90).setNumberOfTickMarks(37);
    cp5.getController("motor"+i).getValueLabel().align(ControlP5.CENTER, ControlP5.TOP);
  }
}
void draw() {

  println(Max_STEP);
  background(0);
}
int i=0;




public void SEND(int theValue) {
  for (int i=1 ; i<=10 ;i++) {
    int val = int(cp5.getController("motor"+i).getValue());
    sendData+=val + " ";
  }
  sendData+="X";
  println(sendData);
  commPort.write(sendData);
  sendData="";
}


public void SET_0(int theValue) {
  for (int i=1 ; i<=10 ;i++) {
    cp5.getController("motor"+i).setValue(0);
  }
}

public void SET_45(int theValue) {
  for (int i=1 ; i<=10 ;i++) {
    cp5.getController("motor"+i).setValue(45);
  }
}
public void SET_90(int theValue) {
  for (int i=1 ; i<=10 ;i++) {
    cp5.getController("motor"+i).setValue(90);
  }
}
public void SET_100(int theValue) {
  for (int i=1 ; i<=10 ;i++) {
    cp5.getController("motor"+i).setValue(100);
  }
}
public void SET_135(int theValue) {
  for (int i=1 ; i<=10 ;i++) {
    cp5.getController("motor"+i).setValue(135);
  }
}
public void SET_180(int theValue) {
  for (int i=1 ; i<=10 ;i++) {
    cp5.getController("motor"+i).setValue(180);
  }
}

