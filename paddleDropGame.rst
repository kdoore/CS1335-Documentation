.. _paddleDropGame:

==================
Paddle Drop Game
==================

Based on `Shiffman's`_ RainDropGame, and on the program code for Learning Processing: `exercise 10.4`_, 
we want to build a slightly more complicated game based on this program.  Our game will use a paddle
object to try and catch the falling drops.  We'll also use object inheritance to have several different
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
- score: int                 
- gameState: int			  
- missedCount: int  		  
- maxAllowedMisses: int       
- startButton: button		  
- resetButton: button 


Next, we'll want a few methods, we may add more methods later, but we can immediately 
imagine we'll need the following methods:

Game: Methods
--------------
- display( )
- reset( )
- isGameOver( )

Child classes of the Drop Class
================================

The next modification for our game is that we're going to use several different drop types.  
So, we'll have 2 different classes that inherit from the Drop class.  Let's say we'll have SeaHorses
and Stars.  Since the behavior of these objects will be almost identical to `Shiffman's`_ Drop class,
it makes sense for us to use object inheritance when defining these objects.  

Method Override
===================
It's obvious that these objects will have unique display() methods which display their unique 
shapes.  Other methods like move() might be identical to the Drop method: move( ).

When one class inherits from another class, any method that is not specified in the child 
class, will be implemented using the method in the parent class.  This a major benefit
of using inheritance, we only need to make changes to methods or features that are different 
in the child class. 

For now we can simply create a Seahorse class that inherits from the Drop class using the 
code class code below::

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



Questions: 


.. _Exercise 10.4:  http://www.learningprocessing.com/exercises/chapter-10/exercise-10-4/

.. _Shiffman's: http://learningprocessing.com