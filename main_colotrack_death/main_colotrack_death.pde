ColorCracker crackThat;

import org.openkinect.processing.*;
import peasy.*;


PeasyCam cam;

void setup(){
  size(600,600, P3D);
  cam = new PeasyCam(this, 1000);
  cam.setMaximumDistance(10000);
  
  crackThat = new ColorCracker(this);
}


void draw(){
  //colorMode(HSB, 255);
  background(0);
  crackThat.display();
  crackThat.initialize();
  crackThat.colorPoint();

}