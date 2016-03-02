import org.openkinect.processing.*;
import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;

Kinect2 kinect2; //initialize Kinect



void setup() {
  size(512, 424, P2D);  //canvas size 
  kinect2 = new Kinect2(this);  //initialize Kinect
  kinect2.initRegistered();         //get RegisteredCam Information

  kinect2.initDevice(); // Start all data
}

void draw() {
  background(0);
  
 
  
  PImage img = kinect2.getRegisteredImage();                       //store RegisteredImage in img variable
  int[] depthMap = kinect2.getRawDepth();   //create array to store img info 
  
   loadPixels();
   
   for(int x=0; x<kinect2.depthWidth; x++)                   //create loop to check single pixels
  {
    for(int y=0; y<kinect2.depthHeight; y++)
    {
         int loc = x+y*kinect2.depthWidth;                    //create loc variable to store current pixel location

         int rawDepth = depthMap[loc];                        //read depthValue of each array location


        if(rawDepth > 100 && rawDepth < 750) {
          pixels[loc] = color(255,200,0); 
        }
        
        else {
          pixels[loc] = img.pixels[loc]; 
        }
    }
  }
  updatePixels(); 

  //image(img, 0, 0, kinect2.depthWidth, kinect2.depthHeight);  //draw image with position 0,0
}