Population test;

PVector goal = new PVector(450,10);


void setup() { //code for opening the window that the dots are on
  size(900,900);
  test = new Population(1000);  
}

void draw() {
  background(255);
  fill(255,0,0);
  ellipse(goal.x, goal.y, 10, 10);
  
  fill(0,0,255);
  rect(300,730,300,20);
  rect(300,730,20,300);
  rect(300,480,600,20);
  rect(0,180,550,20);

  
  if(test.allDotsDead()) { //if true then make a new generation of dots
    test.calculateFitness();
    test.naturalSelection();
    test.mutateBabies();
  } else {
    
  
  
  test.update();
  test.show();
  }
}
