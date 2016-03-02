import org.openkinect.processing.*;

Kinect2 kinect2; //initialize Kinect

color trackColor;   //variable to store tracked color

void setup() {
  size(512, 424);  //canvas size 
  kinect2 = new Kinect2(this);  //initialize Kinect
  kinect2.initDepth();         //get DephtCam Information
  kinect2.initVideo();        //second cam starts
  kinect2.initDevice(); // Start all data
  
  
  color c = color(255, 0, 0);  // Define color 'c'
  float trackColor = red(c);  // Get red in 'c'
  println(trackColor);
  
  
  //colorMode(HSB,255);                   //search for hue and not for rgb
  //color trackColor = color(255,0,0);      //define color to be tracked
  smooth();
}

void draw() {
  background(0);
  
 
  
  PImage img = kinect2.getDepthImage();                       //store DephtImage in img variable
  int[] depthMap = kinect2.getRawDepth();   //create array to store img info 
  int[] 
   loadPixels();
   
   
   int closestX = 0;
   int closestY = 0;
  
   PVector closestPoint = new PVector();
   
   for(int x=0; x<kinect2.depthWidth; x++)                   //create loop to check single pixels
  {
    for(int y=0; y<kinect2.depthHeight; y++)
    {
         int loc = x+y*kinect2.depthWidth;                    //create loc variable to store current pixel location

         int rawDepth = depthMap[loc];                        //read depthValue of each array location
         color currentColor = depthMap[loc];

          PVector currColorVec = new PVector(red(currentColor),green(currentColor),blue(currentColor));
          PVector trackColorVec = new PVector(red(trackColor),green(trackColor),blue(trackColor));
          float diff = currColorVec.dist(trackColorVec);
          
          if(rawDepth > 100 && rawDepth < 750) {
          fill(trackColor);
          noStroke();
          ellipse(closestPoint.x,closestPoint.y,50,50);
        }
        
        else {
          pixels[loc] = img.pixels[loc]; 
        }
    }
  }
        println("hallo");
  
  updatePixels(); 

  //image(img, 0, 0, kinect2.depthWidth, kinect2.depthHeight);  //draw image with position 0,0
}