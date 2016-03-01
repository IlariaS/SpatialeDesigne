import processing.video.*;
Capture video;
PVector[] ellipseTrail = new PVector[50];
color trackColor; 
int index = 0;
PGraphics drawing;
PVector lastPoint = new PVector(0, 0);

void setup() 
{
  size(640, 480);

  video = new Capture(this, width, height, 60);
  video.start();
  drawing = createGraphics(width, height);
  trackColor = color(255, 0, 0);
  smooth();

  for (int i = 0; i<ellipseTrail.length; i++) {
    ellipseTrail[i] = new PVector(0, 0);
  }
}

void draw() 
{
  if (video.available()) 
  {
    video.read();
  }
  //video.loadPixels();


  image(video, 0, 0);


  float worldRecord = 500; 

  //int closestX = 0;
  //int closestY = 0;

  PVector closestPoint = new PVector();

  for (int x = 0; x < video.width; x ++ ) 
  {
    for (int y = 0; y < video.height; y ++ ) 
    {
      int loc = x + y*video.width;
      // Step 2: What is current color
      color currentColor = video.pixels[loc];

      PVector currColorVec = new PVector(red(currentColor), green(currentColor), blue(currentColor));
      PVector trackColorVec = new PVector(red(trackColor), green(trackColor), blue(trackColor));
      float diff = currColorVec.dist(trackColorVec);

      if (diff < worldRecord) 
      {
        worldRecord = diff;
        closestPoint.x = x;
        closestPoint.y = y;
      }
    }
  }
  
  closestPoint = PVector.lerp(closestPoint, lastPoint, 0.95);
  lastPoint.x = closestPoint.x;
  lastPoint.y = closestPoint.y;
  
  if (worldRecord < 10) 
  { 
    if (index < ellipseTrail.length) {
      //println(index);
      ellipseTrail[index].x = closestPoint.x;
      ellipseTrail[index].y = closestPoint.y;
      index++;
    } else {
      index = 0;
    }
  }

  noFill();
  stroke(trackColor);
  strokeWeight(10);
  //beginShape(LINES);
  for (int i = index; i<ellipseTrail.length-1; i++)
  {
    line(ellipseTrail[i].x, ellipseTrail[i].y, ellipseTrail[i+1].x, ellipseTrail[i+1].y);
    //vertex(ellipseTrail[i].x, ellipseTrail[i].y);
  }
  for (int i = 0; i<index-1; i++)
  {
    line(ellipseTrail[i].x, ellipseTrail[i].y, ellipseTrail[i+1].x, ellipseTrail[i+1].y);
    //vertex(ellipseTrail[i].x, ellipseTrail[i].y);
  }
  //endShape();
  fill(255);
  text(frameRate,10,10);
}

//read color of clicked mouse position
void mousePressed() 
{
  int loc = mouseX + mouseY*video.width;
  trackColor = video.pixels[loc];
}