class ColorCracker{
  

  color trackColor = color(0,255,255);

   
  float colorSensitive = 500;
  
  int closestX = 0;
  int closestY = 0;
  
  float trackingColor= hue(trackColor); 
  
  
  
  Kinect2 kinect2;
  ColorCracker(PApplet pa){
    
    kinect2 = new Kinect2(pa);
    kinect2.initDepth();
    kinect2.initRegistered();
    kinect2.initDevice();  
  }
  
  
    void display(){
     image(kinect2.getRegisteredImage(), 0, 0);
     
      fill(trackColor);
      rect(580,580,20,20);
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}