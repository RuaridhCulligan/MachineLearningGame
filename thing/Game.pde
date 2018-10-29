float gposY = 700;//ground positions
float gposX = width-100;
float pposX = width/2+400; //player positions
float pposY = gposY;
float pdirX = 3;
float pdirY = 3;
float pspeed = 1;
float lposX = 0;
float n1posY = pposY - 70;
float lposY = n1posY -50;
float ldirY = -12;
float mdirY = 12;
boolean mousePressedv = false;
float randomRad;
int noMeteors=4;
float mposY;
float mposX;
int noLasers = 2;
meteor[] meteors = new meteor[noMeteors];
laser[] lasers = new laser[noLasers];

void setting() {
  fullScreen();
}

void setup() {//setup (duh)
  background(255);
  for (int i = 0; i < meteors.length; i++) {
    meteors[i] = new meteor(); // Create each object
  }
  for (int j=0; j < lasers.length; j++){
    lasers[j] = new laser();
  }
}


void draw(){//drawing the stuff

  background(255);
  stroke(0);
  strokeWeight(3);
  line(gposX, gposY, gposX + width, gposY);
  fill(0);
  rect(mouseX, pposY, 20, -50);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
  rect(mouseX +7, n1posY, 5, 20);
  
    for (int i = 0; i < meteors.length; i++) {
    meteors[i].fall();
     }
     for (int j=0;j<lasers.length;j++){
       lasers[j].shoot();
       delay(30);
     }
    }
  

class laser {
  float lX = 0;
  float lY = n1posY-50;
  float ldY = -12;
  void mousePressed() {
  mousePressedv = true;
}
  void shoot(){
    if (mousePressedv){
      if (lY == n1posY-62){
        lX = mouseX;
      }
      lY = lY + ldY;
      ellipse(lX, lY, 10, 10);
      if (lY <=10){
        mousePressedv = false;
        lY = n1posY -62;
        lX =0;
      }
    }
  }
}
 
class meteor {
  float mX = random(width);
  float radiusRandom = random(30, 120);

  
    float mY = random(-height);
     void fall(){
       mY = mY +5;
       fill(229, 175, 57);
       ellipse(mX, mY, radiusRandom, radiusRandom);
     
       if (mY>gposY-radiusRandom){
         mX = random(width);
         mY = random(-10);
       }
     }
}


void mousePressed() {
  mousePressedv = true;
}
