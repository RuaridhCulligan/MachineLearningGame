//abominable spaghetti code ahead -- You have been warned...
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
meteor[] meteors = new meteor[noMeteors];

void setup() {//setup (duh)
  size(800, 800);
  background(255);
  for (int i = 0; i < meteors.length; i++) {
    meteors[i] = new meteor(); // Create each object
     
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
  //split mouseEvent();
  if (mousePressedv == true){
    if (lposY ==n1posY-62){
      lposX = mouseX;
}
    lposY = lposY +ldirY;
    ellipse(lposX, lposY, 10, 10);
    if(lposY <=10) {
      mousePressedv = false;
      lposY = n1posY - 62;
      lposX = 0;
    }
  }
 
    for (int i = 0; i < meteors.length; i++) {
    meteors[i].fall();
     for (int j =0; j< meteors.length; j++){
       if (meteors[i].mX + meteors[i].radiusRandom > meteors[j].mX + meteors[j].radiusRandom){
         meteors[i].mX = meteors[i].mX -10;
     }
  }
    }
  
  
class meteor{
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
