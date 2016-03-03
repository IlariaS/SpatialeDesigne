class ColorCracker{
  

  color trackColor = color(255,0,0);

   
  float colorSensitive = 100;
  
  float sumX = 0;
  float sumY = 0;
  float count = 0;
  
  float trackingColor= hue(trackColor); 
  PVector averagePoint;
  PImage display;
  
  
  Kinect2 kinect2;
  ColorCracker(PApplet pa){
    
    kinect2 = new Kinect2(pa);
    kinect2.initDepth();
    kinect2.initRegistered();
    kinect2.initDevice();  
    
    //display = createImage(kinect2.depthWidth, kinect2.depthHeight, HSB);
    averagePoint = new PVector(0,0);
  }
  
  
  void display(){
   image(kinect2.getRegisteredImage(), 0, 0);
   
    //fill(trackColor);
    //rect(580,580,20,20);
  }
  
  

  void initialize(){
      sumX = 0;
      sumY = 0;
      count = 0;
  }
  void colorPoint(){
    
    PImage regImage = kinect2.getRegisteredImage();
    int[] depthMap = kinect2.getRawDepth();
    int[] depthMap2 = kinect2.getRawDepth();
    //int stepSize = 2;
    regImage.loadPixels();
    
    for (int x = 0; x < regImage.width; x++){
      for (int y = 0; y < regImage.height; y++){
        
        
        int colorLoc = x + y*regImage.width;
        int colorLoc2 = x + y*regImage.width;
        
        color currentColor = regImage.pixels[colorLoc];
        
        
        PVector point = depthToPointCloudPos(x,y,depthMap[colorLoc]);
        //PVector point2 = depthToPointCloudPos2(averagePoint.x, averagePoint.y, depthMap[loc]);

        
        PVector currColorVec = new PVector(red(currentColor), green(currentColor), blue(currentColor));
        PVector trackColorVec = new PVector(red(trackColor), green(trackColor), blue(trackColor));
        float diff = currColorVec.dist(trackColorVec);
        
        stroke(currentColor);
        point(point.x, point.y, point.z);
        
        //point(point2.x, point2.y, point2.z);
        //float diff = abs(hue(currentColor) - hue(trackColor));
        
        if(diff < colorSensitive ){
            sumX += x;
            sumY += y;
            count++;
         }  
          //PVector ellipseZ = new PVector(averagePoint.x, averagePoint.y, depthMap[loc]);
          
      if (count > 40) { 
          println("fuck");
          fill(trackColor);
          //strokeWeight(4.0);
          //stroke(0);
          
          
          averagePoint = new PVector(sumX/count, sumY/count);
          
          PVector ellipseZ = depthToPointCloudPos(averagePoint.x,averagePoint.y,depthMap2[colorLoc2]);
          stroke(trackColor);
          point(ellipseZ.x, ellipseZ.y, ellipseZ.z);
          
          
          
          //ellipse(averagePoint.x, averagePoint.y, 40,40);
          //PVector ellipseZ = new PVector(averagePoint.x, averagePoint.y, depthMap[loc]);
          //point(ellipseZ.x, ellipseZ.y, ellipseZ.z);
          
        }
          
          
          
          
          
          
          
        }
      }
   
     //updatePixels();
  }
   
}

PVector depthToPointCloudPos(float x, float y, float depthValue) 
{
 PVector point = new PVector();
 point.z = (depthValue);
 point.x = (x - CameraParams.cx) * point.z / CameraParams.fx;
 point.y = (y - CameraParams.cy) * point.z / CameraParams.fy;
 return point;
}