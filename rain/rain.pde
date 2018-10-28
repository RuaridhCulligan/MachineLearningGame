
int numDrops = 40;
n1[] drops = new n1[numDrops]; // Declare and create the array

void setup() {
  size(600,600);
  background(255);
  smooth();
  noStroke();
  //Loop through array to create each object
  for (int i = 0; i < drops.length; i++) {

    drops[i] = new n1(); // Create each object
    
  }
}

void draw(){
  fill(255,80);
  rect(0,0,600,600);
  //Loop through array to use objects.
  for (int i = 0; i < drops.length; i++) {
    drops[i].fall();
  }

}

class n1 {
  float r = random(600);
  float y = random(-height);
  float randomRad = random(5, 150);
  void fall() {
    y = y + 7;
    fill(0,10,200,180);
    ellipse(r, y, 10, 10);

   if(y>height){
   r = random(600);
   y = random(-10);
   }

  }
}
