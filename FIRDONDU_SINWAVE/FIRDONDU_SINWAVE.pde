
import processing.serial.*;
Serial serialComm; 

int step=0;
long  currTime, prevTime;
int animationStepTime=90;
String[] sendingValues=
{
  "102 152 178 170 132 77 27 1 9 47", 
  "114 160 179 164 120 65 19 0 15 59", 
  "125 167 179 158 110 54 12 0 21 69", 
  "134 172 178 150 99 45 7 1 29 80", 
  "143 175 175 142 88 36 4 4 37 91", 
  "153 178 170 131 76 26 1 9 48 103", 
  "160 179 164 121 65 19 0 15 58 114", 
  "166 179 158 111 55 13 0 21 68 124", 
  "171 178 151 100 45 8 1 28 79 134", 
  "176 174 141 87 35 3 5 38 92 144", 
  "178 169 130 75 25 1 10 49 104 154", 
  "179 164 120 64 18 0 15 59 115 161", 
  "179 156 108 53 11 0 23 71 126 168", 
  "177 148 97 43 7 2 31 82 136 172", 
  "173 138 85 33 3 6 41 94 146 176", 
  "169 129 74 25 0 10 50 105 154 179", 
  "162 117 62 17 0 17 62 117 162 179", 
  "155 107 52 11 0 24 72 127 168 179", 
  "148 96 42 6 2 31 83 137 173 177", 
  "139 85 33 3 5 40 94 146 176 174", 
  "130 75 25 0 10 49 104 154 179 169", 
  "118 62 17 0 16 61 117 162 179 163", 
  "108 52 11 0 23 71 127 168 179 156", 
  "97 43 6 2 31 82 136 173 177 148", 
  "86 34 3 5 39 93 145 176 174 140", 
  "75 26 1 9 49 104 153 178 170 130", 
  "65 19 0 15 59 114 160 179 164 120", 
  "53 12 0 23 71 126 167 179 156 108", 
  "42 6 2 32 83 137 173 177 147 96", 
  "33 3 5 40 94 146 176 174 139 85", 
  "25 0 10 50 105 154 179 169 129 74", 
  "18 0 15 60 115 161 179 164 119 64", 
  "12 0 22 70 125 167 179 157 109 54", 
  "7 2 30 81 135 172 177 149 98 44", 
  "3 5 40 93 145 176 174 139 86 34", 
  "1 10 49 104 153 178 169 130 75 26", 
  "0 15 59 115 161 179 164 120 64 18", 
  "0 23 71 126 168 179 156 108 53 11", 
  "2 32 84 137 173 177 147 95 42 6", 
  "6 41 94 146 176 173 138 85 33 3", 
  "10 50 105 154 179 169 129 74 25 0", 
  "16 60 116 161 179 163 119 63 18 0", 
  "22 70 126 167 179 157 109 53 12 0", 
  "30 81 135 172 177 149 98 44 7 2", 
  "38 92 144 176 174 141 87 35 3 5", 
  "48 103 152 178 170 131 76 27 1 9", 
  "58 113 160 179 165 121 66 19 0 14", 
  "68 123 166 179 158 111 56 13 0 21", 
  "78 133 171 178 151 101 46 8 1 28", 
  "89 142 175 175 143 90 37 4 4 36", 
  "100 151 178 171 134 79 28 1 8 45",
};

void setup() {
  serialComm = new Serial(this, Serial.list()[0], 9600);

  size(450, 360);
  currTime = millis();
  prevTime = currTime;
}


void draw() {
  currTime = millis();
  sendarduino();
}

void  sendarduino() {

  if (currTime >= prevTime + animationStepTime) {
    if (step<sendingValues.length) {
      
      serialComm.write(sendingValues[step]+" X");
      println(sendingValues[step]);
      step++;
      prevTime = currTime;
    }
  }
  if (step >= sendingValues.length) {
    step=0;
  }
}