import peasy.*;
import org.openkinect.processing.*;
import damkjer.ocd.*;

PGraphics layerUp;
PGraphics layerDown;

KinectTracker tracker;
CameraParams params;
Camera camera1;
//PeasyCam cam;

void setup() 
{
  size(640, 520, P3D);
  //cam = new PeasyCam(this, 1000);
  //cam.setMaximumDistance(5000);
  layerUp = createGraphics(width, height);
  layerDown = createGraphics(width, height);
  camera1 = new Camera(this);
  tracker = new KinectTracker(this);
}

void draw(){
 background(255);
  camera1.feed();
  tracker.track();
  
 PVector v1 = tracker.getPos(); // get position of the tracker
  
  layerDown.beginDraw();
  
  //rotateY(PI/3);
  layerDown.pushMatrix();
  layerDown.translate(v1.x, v1.y);
  layerDown.shearX(v1.x/PI);
  layerDown.shearY(v1.y/PI);

  
  layerDown.noStroke();
  layerDown.fill(random(0,255),20,23);
  layerDown.rect(0,0,20,20);
  layerDown.popMatrix();
  //layerDown.ellipse(10,10,10,10);
  
 // layerDown.camera1.roll(radians(mouseX-pmouseX));
  layerDown.endDraw();


  layerUp.beginDraw();
  layerUp.background(255,255,255,20);
  //layerUp.noFill();
  //layerUp.stroke(0);
  //layerUp.ellipse(v1.x, v1.y, 20, 20); // access x and y data of the vectore v1

  //layerUp.ellipse(100,100,20,20);
  layerUp.endDraw();
  
  image(layerUp,-width/2, -height/2);
  image(layerDown, -width/2, -height/2);
  
  
}