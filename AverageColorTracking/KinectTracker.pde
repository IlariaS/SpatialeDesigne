
class KinectTracker{

  int upperThreshold = 750; // Depth threshold
  int lowerThreshold = 0;
  PVector location; // Raw location
  int[] depth; // Depth data
  PImage display; // What the user will see
  
  Kinect2 kinect2; // Kinect 2 class
  
  KinectTracker(PApplet pa){ // constructor
    kinect2 = new Kinect2(pa); // receives the connect Kinect (this)
    kinect2.initDepth(); //get DephtCam Information
    kinect2.initDevice(); // Start all data
    
    display = createImage(kinect2.depthWidth, kinect2.depthHeight, RGB); // create a blank image
    location = new PVector(0,0); // create vectore with the value 0,0
  }
    
  PVector getPos(){ // only returns the location 
    return location;
  }
  
  void track(){
    depth = kinect2.getRawDepth(); // get the raw depth of the Kinect as an array of integers
    PImage img = kinect2.getDepthImage();
    
    if (depth == null || img == null) return; // if there are no data, stop here
    
    float sumX = 0; // sum of all x-axis pixel within the threshold (set float to 0 to count all the pixels which are within the threshold to calculate the average (middle))
    float sumY = 0; // sum of all y-axis pixel within the threshold
    float count = 0; // amount of pixel within the threshold
    
    display.loadPixels();
    
    for (int x = 0; x < kinect2.depthWidth; x++){ //first loop x-axis pixel
      for (int y = 0; y < kinect2.depthHeight; y++){ //second loop y-axis pixel
      
        int offset = kinect2.depthWidth - x - 1 + y * kinect2.depthWidth; // mirror the image
        int rawDepth = depth[offset]; // store raw depth in to integer rawDepth
        int pix = x + y*display.width;
        
        if (rawDepth > lowerThreshold && rawDepth < upperThreshold){ // Testing against threshold
          sumX += x; // if true add x to sumX
          sumY += y;
          count++;
          display.pixels[pix] = color(150, 50, 50); // if pixel withing this threshold color it.

        }
        else{
          display.pixels[pix] = img.pixels[offset]; // if not just show pixel of that location
        }
      }
    }
     display.updatePixels();
    
    if (count > 40) { // as long as we found some pixels within the threshold
      location = new PVector(sumX/count, sumY/count); // calculate the average and save it into the location vector
    }
    //image(display, 0, 0); // draw actual image
  } 
}