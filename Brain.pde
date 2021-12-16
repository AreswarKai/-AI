class Brain {
 PVector[] directions;
 int step = 0;
 
 Brain(int size) {
   directions = new PVector[size];
   randomize();
 }
 
 //===========================================================================================================================================================
  
 void randomize() { //code for randomizing the direction the dots will move
  for(int i = 0; i < directions.length; i++) {
    float randomAngle = random(2*PI);
    directions[i] = PVector.fromAngle(randomAngle);
  }
 }
 
 //===========================================================================================================================================================
 
 Brain clone() { //cloning new offspring because we can't be fucked to genetically modify generations
   Brain clone = new Brain(directions.length);
   for(int i = 0; i<directions.length; i++) {
     clone.directions[i] = directions[i].copy();
   }
   
   return clone;
 }
   
 //===========================================================================================================================================================
 
 void mutate() { //setting the mutation chance and actually doing the mutation by overwriting the cloned dot
   float mutationRate = 0.01;
   for(int i = 0; i<directions.length; i++) {
     float rand = random(1);
     if(rand<mutationRate) {
       float randomAngle = random(2*PI);
       directions[i] = PVector.fromAngle(randomAngle);
     }
   }
 }

}
