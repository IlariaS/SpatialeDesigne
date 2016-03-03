ColorCracker crackThat;

import org.openkinect.processing.*;
//import peasy.*;




void setup(){
  size(600,600);
  colorMode(HSB, 255);
  crackThat = new ColorCracker(this);
}


void draw(){
  background(0);
  crackThat.display();
}