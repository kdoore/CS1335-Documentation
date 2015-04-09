.. _paddleDropGame:

==================
Paddle Drop Game
==================

Based on `Shiffman's`_ RainDropGame, and on the program code for Learning Processing: `exercise 10.4`_, 
we want to build a slightly more complicated game based on this program.  Our game will use a paddle
object to try and catch the falling drops.  We'll also use :ref:`Object Inheritance` to have several different
objects that fall during our game, and we'll use the PShape object to allow the use of .svg images for
interesting drop objects.  Also, we'll use a Game class for methods and variables related to the game state,
this will include Button class to start the game and to allow the game to be reset.  A more advanced 
version of the game could also include gameLevels and other more advanced features

Planning
=========

To begin design of our game, let's look at the changes we'll need to make, to modify 
`Shiffman's`_ exercise 10.4 project code. In `Shiffman's`_ project, he has all of the game type 
code simply implemented within the processing draw loop.  We'd like to re-factor his program and
make a separate Game class in order to make it easier to organize and understand our program code.  
If we look at his Draw loop code, we can see that he's incrementing a score-type variable, he's 
keeping track of misses, etc.  So, let's create a Game Class, initially we can begin with the following
instance variables, we will probably expand on these at some point:

Game: Instance Variables
-------------------------
- score: ``int``                 
- gameState: ``int``			  
- missedCount: ``int``  		  
- maxAllowedMisses: ``int``       
- startBtn: ``button``		  
- resetBtn: ``button`` 

We can use integer values to indicate the possible gameState values, this will allow
us to use a switch(gameState)  structure. We can use the keyword ``final`` to make it clear that
these are values that shouldn't be changed within the program ::

	final int START=0;
  	final int ACTIVE=1;
  	final int END=2; 

Next, we'll want a few methods, we may add more methods later, but we can immediately 
imagine we'll need the following methods:

Game: Methods
--------------
- display( ) : ``void``
- reset( )   : ``void``
- isGameOver( ) : ``boolean``

Game Button Objects
=====================
If we want to include some Button objects in our game, like a startButton and a resetButton,
then we'll need to look at what a Button object would look like.  Shiffman provides an example of
a Button object in `Exercise 9.8`_  To integrate the a start button in the Game class, it's 
important to remember to initialize the button in the Game constructor, aslo, for the simple button
class and click methods that we've created, we want to make sure out buttons don't have the same position
values because we are using the position to determine if the button has been clicked::

	Game(){
		int gameState=START;
		int score=0;
		startBtn=new Button(width/2, height/2+20,70,50);  //make sure buttons aren't in the same location
		resetBtn=new Button(width/2, height/2-50,70,50);
		}

Game Display - Buttons
========================
Then, in the Display method for the game, we can display the buttons depending on what 
the gameState is::

	//this code is in the Game class tab

	void display(){
		switch(gameState){
		  case 0:  //Game is in 'Start' mode - show start button
			fill(255);
			rect(0,0,width,height);
			startBtn.display();   //here's where we display the start button
			fill(0);
			text("Push to Start",width/2,height/2-10);
			break;
		 case 1:  //game is in 'ACTIVE' mode 
			fill(100,150,200);
			rect(0,0,width,height);
			fill(0);
			stroke(0);
			text("Score: " + score,20,20);
			break; 
		  case 2:   //game is in 'END' mode
		  	resetBtn.display();   //here's where we display the reset button
		  	fill(0);
			text("Push to Restart",width/2,height/2-10);
			break;
			}
		} 

Button State
=========================
The button objects have a display method which we've called above in the game.display( ) method. So, the
button knows what to look like based on it's internal state.  That is the button's responsibility.  However
the main reason that we want to use a button is so we can change something in the program whenever someone
clicks on the button and changes the button's internal state.  So, the Button objects have an internal state
that is boolean: on, which is either true or false.  This state is changed when the button.click() method is called::

	/// this code is in the Button Class:: notice that we'll have a problem if the buttons have the same position
	/// which might not be obvious if they're displayed at different times.
	
	void click(int mx, int my) {  //input is mouseX, mouseY
    		// Check to see if a point is inside the rectangle
    		if (mx > x && mx < x + w && my > y && my < y + h) {
      		on = !on;
    }
  }

Game Button Integration
=========================
Now we need to figure out how to integrate the button event handler into the game.  So, if we look 
back at the main program code, we have a MouseClicked( ) event and this is where the game.startButton.click() 
code must be located so it's executed when the user clicks the mouse.  There are 2 different types of game 
methods called here, first is the Button click() method for each button.  The second is game1.checkState( ). 
It might not be obvious that we would want to have this type of method, but it makes it easier within the Game
objects to determine what the impact of the button clicks has on the game::

	//this code is in the main program tab

	void mouseClicked(){
		  game1.resetBtn.click(mouseX,mouseY);
		  game1.startBtn.click(mouseX,mouseY);
		  game1.checkState();    /// this helps us determine what to do when there are multiple buttons in the Game
	}

So, now we need to write the code for this checkState( ) method  within the Game Class. So, first thing we
do is see if the button states have been activated so that 'on' == true.  If so, then we want to use this
as a trigger to change the game state.  However, it's important to remember to set the button  ``on`` state 
back to false. See the code below::  	
 
    //this code is in the Game class tab
    
 	void checkState(){
		if(startBtn.on==true){
			gameState=ACTIVE;   //change game to active state
			startBtn.on=false;
		}
		if(resetBtn.on==true){
			gameState=START;   //change game to start screen
			resetBtn.on=false;
		}
  }
  
Game Instance
==============
All of the above code assumes that we will define, initialize and utilize a Game object in 
the main program tab. Since we need access in the draw loop, as usual, we'll declare the object
above the setup function, initialize in the setup function, and then use in the draw loop::

	//this code is in the main tab
	 
	//other global variables
	Game game1;
	
	void setup(){
	//other initializations
	
	game1= new Game();   //call the Game constructor, here we call the default constructor
	}  //end setup
	
	void draw(){   //here is how we might use this code
	
		game1.display();
		
		if(game1.gameState==game1.ACTIVE){ // put most active game code in here
			if (timer.isFinished()) {
      			if (totalDrops < drops.length) {
        		drops[totalDrops] = new Drop();
        		totalDrops++;
      			}  // end if
     	 		timer.start();
    			}  //end timer
			for(int i=0;i<totalDrops;i++){
			if(drops[i].isActive==true){  //only look at active drops
			   boolean isHit=false;
			   drops[i].move();
			   isHit= drops[i].isIntersecting(paddle1);
			  	if(isHit){
					println("isHit");
					drops[i].isActive=false;
					drops[i].y= height + drops[i].getBottomY();  //move off screen
					game1.score++;  
			   } 
			drops[i].display();  
       			}  //end isActive
       		}//end drop[] loop
   		paddle1.display();
   		}  //end game1.Active
   		
	}  //end draw

Inheritance
============

Child classes of the Drop Class
--------------------------------

The next modification for our game is that we're going to use several different drop types.  
So, we'll have 2 different classes that inherit from the Drop class.  Let's say we'll have SeaHorses
and Stars.  Since the behavior of these objects will be almost identical to `Shiffman's`_ Drop class,
it makes sense for us to use object inheritance when defining these objects.  

Method Override
-----------------
It's obvious that these objects will have unique display() methods which display their unique 
shapes.  Other methods like move() might be identical to the Drop method: move( ).

When one class inherits from another class, any method that is not specified in the child 
class, will be implemented using the method in the parent class.  This is called :ref: `Method Override`, 
and it means that when a child class has code that implements the same method that's also in
parent class, then it is the child method code which is executed, if a child object calls that method.  
In essence, we end up with 2 different versions of one method, each with the same function signature, 
but with different code within the function	body.  So we need to understand the rules the compiler uses 
when determining which method to execute.  So, to summarize, when an object from a child class executes 
a method call, the compiler first looks in the class definition for the child object to see if that 
method is implemented in the child class, if so, then that's the version that is executed.
This a major benefit of using inheritance, we only need to make changes to methods or features that are different 
in the child class. 

For now we can simply create a Seahorse class that inherits from the Drop class using the 
code class code below::

	//this code is in the Seahorse Class tab   

	class Seahorse extends Drop{
			PShape s;
  			float sWidth;
  			float sHeight;
  			float bottomY;
  			float bottomX;
			
			Seahorse(){
				super();   //call the Drop constructor
			}
			
			void display(){
			    //some code to display the seahorse which is different than a drop
			}
	}
	
Making Drops
-------------

In `Shiffman's`_ game, there are several important distinctions we need to think about, which control
the structure and behavior of our game, in `Shiffman's`_ game, this structure is created in the main 
program tab.  The general idea is that he has an array:  drops[] that stores the Drop objects,
we'll modify this so that it can also contain Drop sub-class objects like Stars or Seahorses.


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

As discussed above, we used inheritance to extend the Drop class, we created a child class: Seahorse.
So, the beauty of this is that we can now put Seahorse objects in an array of that has been declared to contain Drop objects.
This is polymorphism, it means that a parent class 'reference' can be used to refer to a sub-class object.  So, we can do the 
following::
	
	Drop someDrop = new Seahorse();    //someDrop is a Drop reference, it points to a Seahorse object.
	
This might not seem like a very important feature on initial inspection, however, it is one of the powerful
features that result from the Object-Oriented concept of Class Inheritance.  So, now we can change the
game code so that when the timer goes off, we can create Seahorse objects instead of Drop objects::

			drops[totalDrops] = new Seahorse();
			
This is a start, but in addition, to make our game interesting, we want to have a variety of drop type objects
falling in the game, yet we only want to create 1 drop each time the timer goes off.  So we need some way
to control this.   We're looking for random behavior, like flipping a coin.  Also, using a switch statement will 
allow us to easily add more types of dropping objects without making big changes to the code.  The switch statement
can't use a randomly generated float value, it needs an integer. So, first thing we need to generate a random integer 
and we can do this by type casting the random number to an integer.  This will result in truncation of the integer value, so
if we used Random(0,1), we'd only ever get the integer ``0`` as a generated value.  So, the code below generates 2 different
values, 0 and 1, then we can use that to randomly generate different types of drops.::

		int choice = (int) random(0,2);  //  gives 0,1 vaules
		
		switch(choice){
		
		case 0:  drops[totalDrops]= new Seahorse();
				break;
		
		case 1:  drops[totalDrops] = new Star();
				break;
		}
		
The code as Shiffman has written it, means that there will never be more than 50 drops created, in other words,
once totalDrops>=50, no new drops will be created.  It would not be much more difficult to have additional logic
to have an else{ } block where, once we know the entire array has been filled with drops, to continue the game, 
we could just loop through the array and find inActive drops and then create new drops in those spots.  Below I have
just pasted in the duplicated code from above, this would not be the most elegant or efficient way to do this but it
should at least convey the idea of how this might be implemented::

	if(game1.state==game1.ACTIVE){
	  	if(totalDrops < drops.length){   
          int choice = (int)random(0,2);  //  gives 0,1 vaules
             println("choice " + choice);
             switch(choice){
                case 0:  drops[totalDrops]= new Seahorse();
                          break;
                case 1:  drops[totalDrops] = new Drop();
                          break;
              }    //end switch
     totalDrops++;
   	 }  //end if
	  else{  //the array is already full of drops, some are not active, find one isFinished and create a new drop.
	  	for(int i=0; i< drops.length, i++){
	  		 if(drops[i].isFinished){   //or !drops[i].isActive
	  		 		int choice = (int) random(0,2);  //  gives 0,1 vaules
					switch(choice){
					case 0:  
							drops[i]= new Seahorse();
							i=drops.length; //  since we've found one, drop out of the loop by resetting i to the max value
							break;
					case 1:  
							drops[i] = new Star();
							i=drops.length;
							break;
							}   //end switch
	  		 }  //end if
	  	}  //end for
	  }  //end else
	  
		///the rest of the game1.ACTIVE code

		}

Questions: 


.. _Exercise 10.4:  http://www.learningprocessing.com/exercises/chapter-10/exercise-10-4

.. _Exercise 9.8:  http://www.learningprocessing.com/exercises/chapter-9/excercise-9-8

.. _Shiffman's: http://learningprocessing.com