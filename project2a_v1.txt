.. _project2a:

==============================
CS1335 - Spr 15 - Project 2a
==============================

Based on `Shiffman's`_ RainDropGame, and on the program code for Learning Processing: `exercise 10.4`_, 
we want to build a slightly more advanced game based on this program. 

	1.  We will add a start and stop button to enable the player to start and stop the game. The buttons are labeled Start and Stop respectively.
	2.  We will have two varieties of falling objects: regular drops and tiny drops. Tiny drops are smaller than regular drops and drop faster, with a more unpredictable trajectory, but catching a tiny drop will earn extra bonus points.
	3.  The score will still be displayed after the game is over


You are required to implement:

	- a Game object, which uses other objects
	- the regular and tiny drops as child classes of a parent "Drop" class
	- the labeled buttons as child classes of a parent "Button" class
 

Game class
===========

To begin design of our game, let's look at the changes we'll need to make, to modify 
`Shiffman's`_ exercise 10.4 project code. In `Shiffman's`_ project, he has all of the game type 
code simply implemented within the processing draw loop.  

We'd like to re-factor his program and
make a separate Game class in order to make it easier to organize and understand our program code.  
If we look at his Draw loop code, we can see that he's incrementing a score-type variable, he's 
keeping track of misses, etc.  So, let's create a Game Class with the following
instance variables. Some of them are the game related variables from exercise 10-4 moved inside the Game class.


Game: Instance Variables
-------------------------

	- score: ``int`` // current score
	- level:``int``   // level the game is currently in              
	- state: ``int`` // Game can be in inactive or active state			  		         
	- numberDropsDone: ``int``// a drop is done if it is caught by the catcher or if it reaches the bottom of the canvas (this is called levelCounter in 10.4)
	- numberLivesLeft: ``int``// counter value initialized at MAX_NUMBER_LIVES and decremented when a drop reaches the bottom. (this is called lives in 10.4)
	- totalDrops: ``int`` // number of drops generated
	- gameOver: ``boolean``// set to true when a game is over
	- Wbar: ``float``// width of the background bar behind the buttons
	- startBtn: ``LabeledButton`` // Button to start the game	  
	- stopBtn: ``LabeledButton`` // Button to stop the game
	- catcher:``Catcher``// Catcher class
	- timer: ``Timer``// Timer class
	- drops: array of drop objects // size of array is MAX_NUMBER_DROPS

We can use integer values to indicate the possible game state values, this will allow
us to use a switch(gameState)  structure. We can use the keyword ``final`` to make it clear that
these are values that shouldn't be changed within the program ::

	final int INACTIVE=0;
  	final int ACTIVE=1;
  	
In a similar fashion::

	final int MAX_NUMBER_DROPS = 50;
  	final int MAX_NUMBER_LIVES = 10;

Next, we'll want a few methods:

Game: Methods
--------------

	- start(): ``void`` // initializes the proper Game variables when the game starts
	- drawButtons(): : ``void``// draws the startBtn and stopBtn buttons by invoking the drawButton() methods of the two LabeledButtons 
	- displayScore: ``void`` // displays score, even when game is over. SCore is reset when a new game starts
	- displayLevel(): ``void``
	- drawBar(): ``void`` // draws the background bar behind the buttons
	- displayGameOver(): ``void`` // displays the "Game Over" message. This is essentially copy and paste of the block code under if(gameOver) in 10.4's draw loop
	- play(): ``void``// generates and displays the drops, tracks the catcher, updates the game variables. This is essentially copy and paste of the remaining part of the draw loop from 10.4



Button Objects
===============

If we want to include some Button objects in our game, like a startButton and a stopButton,
then we'll need to look at what a Button object would look like.  Shiffman provides an example of
a Button object in `Exercise 9.8`_  Our buttons will be created from the "LabeledButton" class, a child class of
the "Button" class. Unlike the "Button" class in Shiffman, our "Button" class does not have an "on" variable, but it has 
a "col" variable of type color. We will refer to our "labeled button" as "button". To integrate a button in the Game class, it's 
important to remember to create and initialize the buttons in the Game constructor by invoking the constructor of the
buttons with the new clause ::

	Game(){
		score = 0;
    		level = 1;
    		state = 0;
    		Wbar = width/7;
    		startBtn = new LabeledButton(width - Wbar + 5, 10, 40, 30, colYellow, "Start");
    		stopBtn = new LabeledButton(width - Wbar + 5, 50, 40, 30, colYellow, "Stop");
		. . . 
	}

To take startBtn as an example, 
width-Wbar + 5 is the x coordinate of the button
10 is the y coordinate of the button
40 is the width of the button
30 is the height of the button
colYellow is the normal color of the button
"Start" is a String used to label the button when it is displayed

LabeledButton class
=====================

The LabeledButton class inherits all the variables of the Button class, namely:

	- X:  ``float`` // x coordinate of button
	- Y:  ``float`` // y coordinate of button
	- W: ``float``// width of button
	- H: ``float`` // height of button
	- col: ``color`` // color of button
	
	The child has in addition the label variable
	
	- label: ``String`` // Button label

The LabeledButton class inherits all the methods of the Button class, namely:
	- rollOver(x, y): ``boolean`` // returns true if the point (x,y) is over the button
	- drawButton(): ``void`` // displays the button with the appropriate color (highlighted color if the mouse is over the button, normal color otherwise)

The LabeledButton has an overriding drawButton() method which displays the button and the label on top.

Use of objects by the Game class
=================================

The Game class uses several objects, namely: startBtn, stopBtn, catcher, timer and drops. These objects are members of the Game class.
Each of these member objects must be 
created and initialized in the Game constructor by invoking the constructor of the corresponding classes with the "new" clause. A more
complete version of the Game constructor with these invoked constructors is shown below ::

	Game() {
		score = 0;
		level = 1;
		state = 0;
		Wbar = width/7;
		startBtn = new LabeledButton(width - Wbar + 5, 10, 40, 30, colYellow, "Start");
		stopBtn = new LabeledButton(width - Wbar + 5, 50, 40, 30, colYellow, "Stop");
		catcher = new Catcher(32); // Create the catcher with a radius of 32
		numberDropsDone = 0;
		numberLivesLeft = MAX_NUMBER_LIVES;
		totalDrops = 0;
		drops = new Drop[MAX_NUMBER_DROPS];    // Create spots in the array 
		timer = new Timer(300);   // Create a timer that goes off every 2 seconds
		gameOver = false;
	  }

Additionally, to refer to a member of an object which is member of the Game class, you may have to use multiple levels of dots. For example,
in the main tab, only the myGame object is known. To refer to the rollOver() member method of the startBtn member of myGame, you have to refer first to the
startBtn member, then to the rollOver() member of startBtn, and that is denoted myGame.startBtn.rollOver().


Game Button Integration
=========================

Now we need to figure out how to integrate the button event handler into the game. We will use the MouseClicked( ) event.:: 


	//this code is in the main program tab

	void mouseClicked() {
  		switch(myGame.state) {
  		case INACTIVE: 
    			if (myGame.startBtn.rollOver(mouseX, mouseY)) { // Start the game if the player clicks start button
      			myGame.gameOver = false;
      			myGame.start();
    			}
    			break;
  		case ACTIVE:
    			if (myGame.stopBtn.rollOver(mouseX, mouseY)) { // Stops the game if the player clicks stop button
      			myGame.gameOver = true;
      			myGame.state = INACTIVE;
    			}
  		}
	}


  
Game Instance
===============

All of the above code assumes that we will define, initialize and utilize an object of the Game class in 
the main program tab. Since we need access in the draw loop, as usual, we'll declare the object
above the setup function, initialize in the setup function, and then use in the draw loop::

	//this code is in the main tab
	 
	//other global variables
	Game myGame;
	
	void setup(){
	//other initializations
	
	myGame= new Game();   //call the Game constructor, here we call the default constructor
	}  //end setup
	
	void draw() {
  	background(255);
  	switch(myGame.state) {
  	case INACTIVE: // Game inactive
    		if (myGame.gameOver)
      			myGame.displayGameOver(); // Display the "Game Over" message
    		break;
  	case ACTIVE: // Playing
    		myGame.play();
    		break;
  	} // end switch
  	myGame.drawBar();
  	myGame.drawButtons();
  	myGame.displayScore();
  	myGame.displayLevel();
	}


Inheritance
============

Child classes of the Drop Class
--------------------------------

The next modification for our game is that we're going to use different drop types: regular drops and tiny drops.  
Because they are both very similar to the drop class in 10.4,  we will use inheritance and 
define them as child classes of drop. 

Adaptation of Drop
-------------------

To the Drop class in 10.4, we add a "score" variable and a getScore() method.


RegularDrop
------------

RegularDrop is a child of the Drop in 10.4.::

	class RegularDrop extends Drop {
		  int score;

		  RegularDrop() {
			super();
			score = 1;
		  }

		  int getScore() {
			return score;
		  }
		}


TinyDrop
--------

TinyDrop is also a child of the Drop in 10.4.Because TinyDrop moves differently than a drop, we define
an overriding move() method. We also have a getScore() method.

When one class inherits from another class, any method that is not specified in the child 
class, will be implemented using the method in the parent class.  This is called :ref:`Method Override`, 
and it means that when a child class has code that implements the same method that's also in
parent class, then it is the child method code which is executed, if a child object calls that method.  
In essence, we end up with 2 different versions of one method, each with the same function signature, 
but with different code within the function	body.  So we need to understand the rules the compiler uses 
when determining which method to execute.  

So, to summarize, when an object from a child class executes 
a method call, the compiler first looks in the class definition for the child object to see if that 
method is implemented in the child class, if so, then that's the version that is executed.
This a major benefit of using inheritance, we only need to make changes to methods or features that are different 
in the child class. ::

	//this code is in the TinyDrop Class tab


	class TinyDrop extends Drop {
		int score;

  		TinyDrop() {
    			super();
    			r = 6;                 // TinyDrops have smaller size
    			speed = random(5, 7);   // Pick a higher random speed
    			c = color(150, 100, 150); // Color
			score = 2;
  		}
  		void move() {
    			// Increment by speed
    			y += speed; 
   			x += random(3); // unpredictable fluctuation in trajectory
  		}

  		int getScore() {
    			return score; // Score 2 points instead of 1, if catch TinyDrop
  		}
	}
	
Making Drops
-------------

In `Shiffman's`_ game, there are several important distinctions we need to think about, which control
the structure and behavior of our game, in `Shiffman's`_ game, this structure is created in the main 
program tab.  The general idea is that he has an array:  drops[] that stores the Drop objects,
we'll modify this so that it can also contain Drop sub-class objects like RegularDrop and TinyDrop.


	1.  ``Drop[] drops;``    //declares an array of Drop objects
	2.  ``drops = new Drop[50];``  //initializes the array to a size of 50 elements
	3.  ``if(timer.isFinished()){    ....    }``   //inside this block of code is where new drops are
		actually created each time the timer goes off.
	4.  inside the block:  ``if(timer.isFinished()){ ... }``  is where we need to figure out how
		to create different types of drops
		
So, Let's start by focusing inside the block of code where the ``timer.isFinished()`` has evaluated to true::

	if (timer.isFinished()) {
	  // Deal with raindrops
	  // Initialize one drop
	  if (totalDrops < drops.length) {
			drops[totalDrops] = new Drop();//(game.levels[game.currentLevel].dropSpeed);
			// Increment totalDrops
			totalDrops++;
	  }
	  timer.start();
	}
	
In the above code, only 1 drop is created each time the timer goes off!  This drop is created in the
array location:  ``drops[totalDrops]``  The first time a drop is created, it's in the first array positon:  ``drops[0]``
After the drop is created, totalDrops is incremented to ``1``:  ``totalDrops++``  So, the next time the ``timer.isFinished()`` is true,
then the next drop will be created in the array location: drops[1].   For our game, we want to create different 
types of drops so we'll take advantage of the idea that inheritance allows us to use :ref:`Polymorphism`
	
Polymorphism
=============

As discussed above, we used inheritance to extend the Drop class, we created two child classes: RegularDrop and TinyDrop.
So, the beauty of this is that we can now put child objects in an array of that has been declared to contain Drop objects.
This is a manifestation of polymorphism, it means that a parent class 'reference' can be used to refer to a sub-class object.  
So, we can do the following::
	
	Drop someDrop = new TinyDrop();    //someDrop is a Drop reference, it points to a TinyDrop object.
	
This might not seem like a very important feature on initial inspection, however, it is one of the powerful
features that result from the Object-Oriented concept of Class Inheritance.  So, now we can change the
game code so that when the timer goes off, we can create RegularDrop or TinyDrop objects instead of Drop objects::

			drops[totalDrops] = new TinyDrop();
			//or
			
			drops[totalDrops] = new RegularDrop();
			
To make our game interesting, we want to choose randomly between TinyDrop and RegularDrop. In addition, we want to be able to adjust
the statistical percentage of RegularDrop vs TinyDrop. This can be achieved with the following code.::

	if (random(100) < PERCENT_REGULAR) {
          drops[totalDrops] = new RegularDrop();
        } else {
          drops[totalDrops] = new TinyDrop();
	}
        
random(100) will return a float value randomly chosen between 0 and 100. PERCENT_REGULAR is the knob variable to control the percentage of
generated drops which are RegularDrop. For example, if PERCENT_REGULAR is 90, 90% of the drops will be RegularDrop, and 10% will be TinyDrop.
PERCENT_REGULAR can be added as a variable of the Game class. ::

	float PERCENT_REGULAR = 90;

Scoring
=========

In the original code of 10.4 shown below, whenever the player catches a drop, the score is incremented by one.::

	if (catcher.intersect(drops[i])) {
          drops[i].finished();
          levelCounter++;
          score++;
        }

In our project, we want to increment the score by one if the player catches a RegularDrop and increment by 2 if the player catches a TinyDrop.
To achieve that, we add a "score" variable, along with a getScore() method to the parent Drop. The "score" variable is initialized to 1 and 2 for 
the RegularDrop and TinyDrop respectively. When the player catches a Drop, instead of incrementing the score by 1, we increment it by getScore().::

	if (catcher.intersect(drops[i])) {
          drops[i].finished();
          numberDropsDone++;
          myGame.score += drops[i].getScore();
        }

		
Other classes
===============

The Timer, Catcher, Drop classes are as defined in 10.4.


.. _Exercise 10.4:  http://www.learningprocessing.com/exercises/chapter-10/exercise-10-4

.. _Exercise 9.8:  http://www.learningprocessing.com/exercises/chapter-9/excercise-9-8

.. _Shiffman's: http://learningprocessing.com

