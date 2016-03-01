//Spatial Interaction
//ZHdK, Interaction Design


import org.openkinect.processing.*;
import peasy.*;
import damkjer.ocd.*;

KinectTracker tracker;
//PeasyCam cam;
Camera cam1;

void setup() 
{
  size(640, 520, P3D);
  tracker = new KinectTracker(this);
  //cam = new PeasyCam(this, 1000);
  //cam.setMaximumDistance(5000);
  
  cam1 = new Camera(this);
}

void draw() 
{
  background(255);
  
  cam1.feed();


  tracker.track();
  tracker.display();

  //PVector v1 = tracker.getPos();
  //fill(50, 100, 250, 200);
  //noStroke();
  //ellipse(v1.x, v1.y, 20, 20);

  PVector v2 = tracker.getLerpedPos();
  fill(100, 250, 50, 200);
  noStroke();
  ellipse(v2.x, v2.y, 20, 20);

  int t = tracker.getThreshold();
  fill(0);
  text("threshold: " + t + "    " +  "framerate: " + int(frameRate) + "    " +
    "UP increase threshold, DOWN decrease threshold", 10, 500);
    
  //cam.setYawRotationMode(double 10);
  //rotateX(v2.x);
  //rotateY(v2.y);
  
  
  //rotateY(PI/3);
  //cam.tumble(radians(mouseX - pmouseX), radians(mouseY - pmouseY));
}

void keyPressed() 
{
  int t = tracker.getThreshold();
  if (key == CODED) 
  {
    if (keyCode == UP) 
    {
      t +=5;
      tracker.setThreshold(t);
    } 
    else if (keyCode == DOWN) 
    {
      t -=5;
      tracker.setThreshold(t);
    }
  }
}

void mouseMoved() {
 cam1.tumble(radians(mouseX - pmouseX), radians(mouseY - pmouseY));
}