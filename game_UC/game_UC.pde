import java.lang.String;
//abominable spaghetti code ahead -- You have been warned...
float gposY = 700;//ground positions
float gposX = width-100;
float pposX = width/2+400; //player positions
float pposY = gposY;
float n1posY = pposY - 70;
float pdirX = 3;
float pdirY = 3;
float pspeed = 1;
player[] playerN = new player[0];
boolean mousePressedv = false;
int noMeteors=4;
int noLasers = 4;
player player;
meteor[] meteors = new meteor[noMeteors];
laser[] lasers = new laser[noLasers];
ArrayList<String> arrObj = new ArrayList<String>();


class player {
  void movePlayer(){
    fill(0);
    rect(mouseX, pposY, 20, -50);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
  rect(mouseX +7, n1posY, 5, 20);
  }
}

void setup() {//setup (duh)
  size(800, 800);
  background(255);
  for (int i = 0; i < meteors.length; i++) {
    meteors[i] = new meteor(); // Create each object
    arrObj.add(meteors[i].nameM);
  }
  for (int j=0; j < lasers.length; j++){
    
    lasers[j] = new laser();
    arrObj.add(lasers[j].nameL);
  }
  for (int k = 0; k<playerN.length;k++){
    playerN[k] = new player();
  }
}


     
void draw(){//drawing the stuff
  background(255);
  stroke(0);
  strokeWeight(3);
  line(gposX, gposY, gposX + width, gposY);
  for (int k=0; k<playerN.length;k++){
    playerN[k].movePlayer();
  }
    for (int i = 0; i < meteors.length; i++) {
    meteors[i].fall();
     }
     for (int j=0;j<lasers.length;j++){
       lasers[j].shoot(); 
     }
     
    }
    
    

class laser {
  float pposY = gposY;
float n1posY = pposY - 70;
  float lX = 0;
  float lY = n1posY-50;
  float ldY = -12;
  String nameL = "laser";
  void mousePressed() {
  mousePressedv = true;
}
  
  void shoot(){
    
      if (lY == n1posY-62){
        lX = mouseX;
      }
      lY = lY + ldY;
      ellipse(lX, lY, 10, 10);
      if (lY <=10){
        if (mousePressedv){
          mousePressedv = false;
        lY = n1posY -62;
        lX =0;
      }
      }
  }
  
}
class meteor{
  float mX = random(width);
  float radiusRandom = random(30, 120);
  String nameM = "meteor";
  
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
