import damkjer.ocd.*;

Camera camera1;

void setup() {
  size(1000, 500, P3D);

  camera1 = new Camera(this);
}

void draw() {
  background(204);
  lights();
  camera1.feed();

  rotateY(PI/3);
  box(50);
  
  //for(int x=0; x<=100; x++){
    
    
  //  for(int y=0; y<=100; y++){
   
    
  //  }
  //}
  
  
}

void mouseMoved() {
  //camera1.roll(radians(mouseX - pmouseX));
camera1.tumble(radians(mouseX - pmouseX), radians(mouseY - pmouseY));
 }