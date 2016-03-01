import org.openkinect.processing.*; //kinect import //<>//
import damkjer.ocd.*; // ocd import

Kinect2 kinect2; //init kinect v2
Camera camera1; //init ocd cam

void setup() 
{ 
  size(800, 600, P3D);
  camera1 = new Camera(this, 100, -125, 150);
  kinect2 = new Kinect2(this);
  kinect2.initDepth();
  
  kinect2.initDevice(); // Start all data
}


void draw() 
{
  background(0);
  
  PImage img = kinect2.getDepthImage();
  int[] depthMap = kinect2.getRawDepth();
  int stepSize = 3;
  camera1.feed();
 
  
  loadPixels();
  
  for(int x=0; x<kinect2.depthWidth; x+=stepSize)
  {
    for(int y=0; y<kinect2.depthHeight; y+=stepSize)
    {
      int loc = x+y*kinect2.depthWidth;
      
      PVector point = depthToPointCloudPos(x,y,depthMap[loc]);
      
      int rawDepth = depthMap[loc];
     
      if (rawDepth > 300 && rawDepth <1000)
      {
        stroke(255,0,0);
        point(point.x, point.y, point.z);
        
        
      }
      else
      {
        stroke(255);
        point(point.x, point.y, point.z);
      }
    }
  }
}

void mouseMoved(){
//camera1.tumble(radians(mouseX-pmouseX),radians(mouseY-pmouseY));
//camera1.zoom(radians(mouseY - pmouseY) / 2.0);
//camera1.dolly(mouseY - pmouseY);
}

PVector depthToPointCloudPos(int x, int y, float depthValue) 
{
  PVector point = new PVector();
  point.z = (depthValue);
  point.x = (x - CameraParams.cx) * point.z / CameraParams.fx;
  point.y = (y - CameraParams.cy) * point.z / CameraParams.fy;
  return point;
}