class Population {
  Player[] player;

  float fitnessSum;
  int gen = 1;

  int bestDot = 0;//the index of the best dot in the dots[]

  int minStep = 1000;

  Population(int size) {
    player = new Player[size];
    for (int i = 0; i< size; i++) {
      player[i] = new Player();
    }
  }


  //------------------------------------------------------------------------------------------------------------------------------
  //show all dots
  void show() {
    for (int i = 1; i< player.length; i++) {
      player[i].show();
    }
    player[0].show();
  }

  //-------------------------------------------------------------------------------------------------------------------------------
  //update all dots 
  void update() {
    for (int i = 0; i< player.length; i++) {
      if (player[i].brain.step > minStep) {//if the dot has already taken more steps than the best dot has taken to reach the goal
        player[i].dead = true;//then it dead
      } else {
        player[i].update();
      }
    }
  }

  //-----------------------------------------------------------------------------------------------------------------------------------
  //calculate all the fitnesses
  void calculateFitness() {
    for (int i = 0; i< player.length; i++) {
      player[i].calculateFitness();
    }
  }


  //------------------------------------------------------------------------------------------------------------------------------------
  //returns whether all the dots are either dead or have reached the goal
  boolean allDotsDead() {
    for (int i = 0; i< player.length; i++) {
      if (!player[i].dead) { 
        return false;
      }
    }

    return true;
  }



  //-------------------------------------------------------------------------------------------------------------------------------------

  //gets the next generation of dots
  void naturalSelection() {
    Player[] newDots = new Player[player.length];//next gen
    setBestDot();
    calculateFitnessSum();

    //the champion lives on 
    newDots[0] = player[bestDot].gimmeBaby();
    newDots[0].isBest = true;
    for (int i = 1; i< newDots.length; i++) {
      //select parent based on fitness
      Player parent = selectParent();

      //get baby from them
      newDots[i] = parent.gimmeBaby();
    }

    player = newDots.clone();
    gen ++;
  }


  //--------------------------------------------------------------------------------------------------------------------------------------
  //you get it
  void calculateFitnessSum() {
    fitnessSum = 0;
    for (int i = 0; i< player.length; i++) {
      fitnessSum += player[i].fitness;
    }
  }

  //-------------------------------------------------------------------------------------------------------------------------------------

  //chooses dot from the population to return randomly(considering fitness)

  //this function works by randomly choosing a value between 0 and the sum of all the fitnesses
  //then go through all the dots and add their fitness to a running sum and if that sum is greater than the random value generated that dot is chosen
  //since dots with a higher fitness function add more to the running sum then they have a higher chance of being chosen
  Player selectParent() {
    float rand = random(fitnessSum);


    float runningSum = 0;

    for (int i = 0; i< player.length; i++) {
      runningSum+= player[i].fitness;
      if (runningSum > rand) {
        return player[i];
      }
    }

    //should never get to this point

    return null;
  }

  //------------------------------------------------------------------------------------------------------------------------------------------
  //mutates all the brains of the babies
  void mutateDemBabies() {
    for (int i = 1; i< player.length; i++) {
      player[i].brain.mutate();
    }
  }

  //---------------------------------------------------------------------------------------------------------------------------------------------
  //finds the dot with the highest fitness and sets it as the best dot
  void setBestDot() {
    float max = 0;
    int maxIndex = 0;
    for (int i = 0; i< player.length; i++) {
      if (player[i].fitness > max) {
        max = player[i].fitness;
        maxIndex = i;
      }
    }

    bestDot = maxIndex;

    //if this dot reached the goal then reset the minimum number of steps it takes to get to the goal
  }
}
