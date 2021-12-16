class Population {
  Dots[] dots;
  
  float fitnessSum;
  int generation = 1;
  int bestDot = 0;
  int minStep = 400;
  
  Population(int size) {
   dots = new Dots[size];
   for(int i = 0; i<size; i++) {
     dots[i] = new Dots();
   }
  }
  
//===========================================================================================================================================================

  void show() { //moves functions calculateFitness(), show() and update() from class Dots to use here
    for(int i = 1; i<dots.length; i++) {
      dots[i].show();
    }
    dots[0].show();
  }
  
//===========================================================================================================================================================

  void update() {
    for(int i = 0; i<dots.length; i++) {
      if(dots[i].brain.step > minStep) {
        dots[i].dead = true;
      } else {
        dots[i].update();
      }
    }
  }
  
//===========================================================================================================================================================

  void calculateFitness() {
    for(int i = 0; i<dots.length; i++) {
      dots[i].calculateFitness();
    }
  }
  
//===========================================================================================================================================================

  boolean allDotsDead() { //checks to see if all dots are dead so program doesn't have to keep updating itself
    for(int i = 0; i<dots.length; i++) {
      if(!dots[i].dead && !dots[i].reachedGoal) {
        return false;
      }
    }
    return true;
  }
  
//===========================================================================================================================================================
  
  void naturalSelection() { //making a new array to store all the info of the dots in the new generation, seleting a parant and getting their baby
    Dots[] newDots = new Dots[dots.length];
    getBestDot();
    calculateFitnessSum();
    
    newDots[0] = dots[bestDot].produceBaby();
    newDots[0].isBest = true;
    
    for(int i = 1; i<newDots.length; i++) {
      
      //select parent based on fitness
      Dots parent = selectParent();
      
      //get babeh
      newDots[i] = parent.produceBaby();  
    }
    
    dots = newDots.clone();
    generation++;
    println("generation:",generation);
  }
    
//===========================================================================================================================================================

  void calculateFitnessSum() { //calculating the fitnesses of all dots
    fitnessSum = 0;
    for(int i = 0; i<dots.length; i++) {
      fitnessSum += dots[i].fitness;
    }
  }
  
//===========================================================================================================================================================

  Dots selectParent() {  //making the chance of a dot being a parent proportionate to its fitness, and then creating a baby
    float rand = random(fitnessSum);
    float runningSum = 0;
    
    for(int i = 0; i<dots.length; i++) {
      runningSum += dots[i].fitness; 
      if(runningSum > rand) {
        return dots[i];
      }
    }
    
    return null;
  }

//===========================================================================================================================================================

  void mutateBabies() {
    for(int i = 1; i<dots.length; i++) {
      dots[i].brain.mutate();
    }
  }

//===========================================================================================================================================================
  void getBestDot() { //getting the dot that was closest, or was the fastest, to the goal
    float max = 0;
    int maxIndex = 0;
    for(int i = 0; i<dots.length; i++) {
      if(dots[i].fitness > max) {
        max = dots[i].fitness;
        maxIndex = i;
      }
    }
    bestDot = maxIndex;
    
    if(dots[bestDot].reachedGoal) {
      minStep = dots[bestDot].brain.step;
      println("steps:", minStep);
    }
  }
}
