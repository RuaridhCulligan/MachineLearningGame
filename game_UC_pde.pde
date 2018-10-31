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
int nPlayers = 0;
player[] players = new player[nPlayers];
boolean mousePressedv = false;
int noMeteors=4;
int noLasers = 4;
int noCoins = 2;
meteor[] meteors = new meteor[noMeteors];
laser[] lasers = new laser[noLasers];
coin[] coins = new coin[noCoins];
PImage coinImg;
PImage meteorImageCurr;
int nMimgs = 3;
PImage[] meteorImages = new PImage[nMimgs];
int currScore;
float widthAct = width -100;
int selectedImage;

ArrayList<String> arrObj = new ArrayList<String>();




void setup() {//setup (duh)
  background(255);
  currScore =0;
  coinImg = loadImage("coin.png");
  meteorImageCurr = loadImage("meteor_big.png");
  size(900, 800);
  for (int p =0; p< meteorImages.length; p++){
    meteorImages[p] = loadImage("meteor" +p+".png");
    }
 
  for (int i = 0; i < meteors.length; i++) {
    meteors[i] = new meteor(); // Create each object
    arrObj.add(meteors[i].nameM);
  }
  for (int j=0; j < lasers.length; j++){
    
    lasers[j] = new laser();
    arrObj.add(lasers[j].nameL);
  }
  for (int k=0; k< players.length; k++){
    players[k] = new player();
    arrObj.add(players[k].nameP);
    players[k].pX = players[k].pX -10;
  }
  for (int c=0;c<coins.length;c++){
    coins[c] = new coin();
    arrObj.add(coins[c].nameC);
  }
}


     
void draw(){//drawing the stuff
  background(255);
  stroke(0);
  strokeWeight(3);
  fill(0);
  rect(mouseX, pposY, 20, -50);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
  rect(mouseX +7, n1posY, 5, 20);
  text("Score: "+currScore, 10, 10);
  line(gposX, gposY, gposX + width, gposY);
  println(arrObj);
  
    for (int k=0; k< players.length; k++){
      players[k].pX = players[k].pX -100;
      players[k].drawPlayer();
    }
    for (int i = 0; i < meteors.length; i++) {
    meteors[i].fall();
     }
     for (int j=0;j<lasers.length;j++){
       lasers[j].shoot(); 
     }
     for (int c=0;c<coins.length;c++){
       coins[c].fall();
     }
     for (int v =0; v<meteors.length; v++){
       if (meteors[v].radiusRandom < 90){
         selectedImage = 1;
       } else if (meteors[v].radiusRandom >=90){
         selectedImage =0;
       }
     if (meteors[v].destroyed==true){
       selectedImage =2;
     }meteors[v].fall();
       }
    }

class player {
  float pY = gposY;
  float pX = mouseX;
  String nameP = "player";
  void drawPlayer() {
    rect(pX, pY, 20, -50);
  }
  }
class laser {
  float pposY = gposY;
float n1posY = pposY - 70;
  float lX = 0;
  float lY = n1posY-50;
  float ldY = -20;
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


class coin {
  float cX = random(width);
  float coinRadius = 70;
  String nameC = "coin";
  float cY = random(-height);
  void fall() {
      cY = cY +8;
      fill(189);
      //ellipse(cX,cY, coinRadius, coinRadius);
      imageMode(CENTER);
      image(coinImg, cX, cY, coinRadius, coinRadius);
      if (cY>gposY - coinRadius){
       cX = random(width);
       cY = random(-coinRadius);
      }
  }
}
class meteor{
 
  float mX = random(width);
  float radiusRandom = random(50, 130);
  String nameM = "meteor";
  boolean destroyed;
  
    float mY = random(-height);
   
     void fall(){
       
       mY = mY +6;
       fill(229, 175, 57);
       //ellipse(mX, mY, radiusRandom, radiusRandom);
       image(meteorImages[selectedImage], mX, mY, radiusRandom, radiusRandom);
       if (mY>gposY-radiusRandom){
         mX = random(width);
         mY = random(-radiusRandom);
     }
}}

void mousePressed() {
  mousePressedv = true;
}
