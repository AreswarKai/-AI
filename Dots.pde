class Dots{
  PGraphics pg;
  PVector position;
  PVector velocity;
  PVector acceleration;
  boolean dead = false;
  boolean reachedGoal = false;
  boolean isBest = false;
  boolean isInScore = false;
  Brain brain;
  
  float fitness = 0;
 
 //===========================================================================================================================================================
 
  Dots() {
   brain = new Brain(800);
   
    
   position = new PVector(width/2,height-100);  //summons dots in the middle of the screen
   velocity = new PVector(0,0); //starts with a velocity of 0
   acceleration = new PVector(0,0); //starts with an acceleration rate of 0
  }
  
//===========================================================================================================================================================

  void show() { //code for actually showing the dots on screen
    if(isBest) {
      fill(0,255,0);
      ellipse(position.x,position.y,8,8);
    } else {
    fill(0);
    ellipse(position.x, position.y, 4, 4);
    }
  }
  
//===========================================================================================================================================================

  void move() { //code for moving the dots
    if(brain.step < brain.directions.length) {
      acceleration = brain.directions[brain.step];
      brain.step++;
    } else {
      dead = true; //making the dot die if it has no more directions to follow
    }
  
    velocity.add(acceleration);
    velocity.limit(5);
    position.add(velocity);
  }
  
//===========================================================================================================================================================
  
  void update() {   //code for the dots not moving when they die
  if(dead == false && reachedGoal == false) {
     move();
     if(position.x<2 || position.y<2 || position.x>width-2 || position.y>height-2) {
       dead = true;
      } else if(dist(position.x, position.y, goal.x, goal.y) <= 5) { //if any dots reach the goal
        reachedGoal = true;
      }
     obstacleCollision(300, 750, 300, 20);
     obstacleCollision(300, 900, 20, 150);
     obstacleCollision(300, 500, 600, 20);
     obstacleCollision(0, 200, 550, 20);
   }
  }
  
//===========================================================================================================================================================
  
  void calculateFitness() { //code for calculating how genetically superior dots were
    if(reachedGoal) {
      fitness = 1.0/16.0 + 10000/(float)(brain.step*brain.step);
    } else {
      float distanceToGoal = dist(position.x, position.y, goal.x, goal.y);
      fitness = 1.0/(distanceToGoal * distanceToGoal);
    }
  }
  
//===========================================================================================================================================================

  Dots produceBaby() { //could clone the baby using parent genetal crossover but fuck it we cloning them
    Dots baby = new Dots();
    baby.brain = brain.clone();
    return baby;
  }
    
//===========================================================================================================================================================
    
  void obstacleCollision(int tlx,int tly,int widthlol,int heightlol) {
    int brx = tlx+widthlol;
    int bry = tly-heightlol;
    if(position.x>=tlx && position.x<=brx && position.y<=tly && position.y>=bry) {
      dead = true;
    }
  }
    
}
