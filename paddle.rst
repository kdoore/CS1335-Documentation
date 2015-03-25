.. _paddle:

======================
Paddle Object
======================

In the previous section, we reviewed Daniel `Shiffman's`_ Rain Game, Object-Oriented Game.  Now, we want
to customize the game to make it a bit more interesting.   The next change we'll make is to add a
paddle that can catch or hit the falling objects.  If we allow the objects to bounce, then that could
provide a user with extra scoring opportunities.  For now, let's just look at how we can implement
a paddle that moves left and right in response to keyboard input.  

Pong Game
===========

`Dr Doane`_, in his online article: `Thinking Through a Basic Pong Game in Processing` provides a nice tutorial 
on how to create a pong game using processing.  While it's not an object-oriented approach, it still provides 
a very good overview and details of ideas we'll want to implement. To start with, he discusses how we can use 
the processing keyboard functions to control movement of the paddle.  Just as with mouseEvents, 
when a user presses a key, we can use that input to allow interaction with our program. 

The initial code in Dr Doane's tutorial describes the motion of a ball as it bounces against the
edges of the canvas.  The main idea is that there are boundaries of the canvas where we need
to test to see if the ball has reached those boundries and if it has, then we need to change 
the direction of the ball object's speed.  In an object oriented approach, this behavior would
be implemented in the Ball class definition, in the ``move( )`` method.

KeyPressed Event
=================

Dr. Doane then refers to the processing reference code in order to determine how to move the
paddle object in response to a user's keyboard interaction.  Below is the processing example 
code::
	
	// based on code from http://processing.org/reference/keyCode.html
	
	void keyPressed() {
  		if (key == CODED) {
  			if (keyCode == UP) {
      			paddleY = paddleY – 30;
    		} else if (keyCode == DOWN) {
      			paddleY = paddleY + 30;
      			}
      		}
      	}

In the code above, the first thing is to note that we want to know if the user has interacted with
our program using the keyboard.  If that's happened, then a keyPressed event is triggered.
Similar to mousePressed events Processing provides a function keyPressed( ) that is triggered
when the user interacts with the keyboard. Then, within the keyPressed( ) function, we need 
to determine how we want our program to respond to the keyPressed event. The keyPressed event
stores the a key value, and it remembers the most recent key that has been pressed.  For special
keys like arrow keys, we need to also use the keyCode values, so we can tell if the key that was 
most recently pressed corresponds to a special key, the arrow keys.  In the code above, 
keyCode == UP, is used to determine whether to move the paddle upwards.  

For our project, we'll be using a paddle that moves horizontally, so we'll look at whether
keyCode == LEFT, or KeyCode == RIGHT, and then we'll need to create code that changes the
behavior of our paddle's movement based on these keyCode comparisons.

KeyPressed Event Handlers
===========================

First we need to create a Paddle class:  This will be simliar to the Ball class, but we'll have
a rectangular object that moves based on the users keyboard interactions.  So, instead of the
move() method, we'll have  pressedLeft() and  pressedRight() methods::
	
	//this code is part of the Paddle class definition
	
	void pressedLeft(){
       if(x>0){   //check to make sure that the paddle doesn't move off the left edge
          x=x-speed;  // decrease x position to move the paddle left
        }
      }
      void pressedRight(){
     	if(x+pWidth<width){  //make sure paddle stays within the right canvas border
       		x=x+speed;
     	}
     }

The other methods and constructors are basically just like the Ball object, where we have 
paddle position coordinates: x,y and paddle dimensions pWidth, pHeight.  We also have a speed
variable that controls how fast the paddle moves.

KeyPressed Paddle Method Calls
================================

For our program, we'll actually want to use these pressedLeft() and pressedRight() methods
within the keyPressed event.  The pressedLeft( ) method is an event handler.  It's code that
we want to be executed when the keyPressed event occurs.  So, in the main program, we would
create a Paddle object, for example paddle1.  Then in the keyPressed event, we'd use the
paddle1 object to call it's pressedLeft( ) method as in the code below::  

	// This code is in the main program, below the draw() function
	
	void keyPressed() {
  		if (key == CODED) {
  			if (keyCode == LEFT) {
      				paddle1.pressedLeft( );
      			} 
      		else if (keyCode == RIGHT {
      				paddle1.pressedRight( );
      			}
      		}
      	}

Arrows: State Indicators
=========================

The example below displays left and right arrows when the user presses the arrow keys.  In order to 
display the correct arrow, I've created some additional variables as part of the paddle class, these
are `state` variables that keep track of the last keyPress event.  I'm using ``int`` variables, since
I want to have 3 possible values:  pLEFT, pRIGHT, pNONE (which is the starting position).  

Click inside the sketch to activate, then use the right and left arrows to move the paddle. 

.. raw:: html

	<div class="figure">
		<iframe width="228" height="180" scrolling="no" frameborder="0" src="http://www.openprocessing.org/sketch/190143/embed/?width=200&height=100&border=true"></iframe>
	</div>

Final Keyword - Constant Values
=================================

This introduces 4 new instance variables in order to keep track of and display the red arrows
which indicate direction, Note the use of the ``final`` keyword::

   // new instance variables for the Paddle class
   
  int direction;  //this variable stores the current direction 
  final int pNONE=0;   //initial direction state variable
  final int pLEFT=1;   // left direction state variable
  final int pRIGHT=2;  //right direction state variable
 
The ``final`` keyword is used to indicate that this value should not be ever be changed, these
values are used as 'constants' within the program. The use of capital letters also indicates that
these are special values which are constants and shouldn't be modified in the program.  The constants
are used to set the value of direction, the use of ``int`` makes it easy to use a switch statement
for our program logic.  In the ``display()`` method of the Paddle class, we use the switch statement
to determine which arrow method to call.  Note that we've created separate display functions for each arrow
within the Paddle class, this makes our code logic easier to understand.  Below is part of the ``display()`` code
for the Paddle class, showing how we've used switch to control which arrow is displayed::

	 // this code is in the Paddle class: display() method
	 
	 switch(direction){   //test the current value of direction
	 		case(pNONE):       //if the initial value, do nothing
         		break;
       		case(pLEFT):       //if pLEFT, display left arrow
         		this.displayLeftArrow();   // call this Paddle method
         		break;
       		case(pRIGHT):     //if pRIGHT, display right arrow
         		this.displayRightArrow();   // call this Paddle method
         		break;
         }
 
Set the State Variable
========================    
So, next we need to figure out `where` to change the value of direction.  We have already created
the Paddle methods: ``pressedLeft()`` and ``pressedRight()``, and we know these methods are
executed when the user presses the left or right keyboard arrows, these Paddle methods are `event handlers`
that we have created, and they are executed in the global ``keyPressed( )`` event by a Paddle object. 
So, it makes sense that we would want to change the direction state variable when this event occurs, and we'll want to 
do that within the Paddle class itself, because a paddle object should be responsible for knowing what
behaviors need to occur when the Paddle method: ``pressedLeft()`` event handler is executed.  
Below is the new code::

	 // this code is in the Paddle class: pressedLeft() method
	 
	 void pressedLeft(){
	 	if(x>0){
	 		x=x-speed;
          	direction=pLEFT;  //here we set the direction state value to pLEFT
          }
    }
    
    
Summary
==========

So, in the Paddle class, we have created event handler methods: ``pressedLeft()`` and ``pressedRight()``
When we create a Paddle object, paddle1, then we'll have that object call these event handler methods
within the global ``keyPressed( )`` event.  The event handler methods are used to trigger object behavior 
code that we'll need to create within the Paddle class itself, one example of this behavior is the
``displayLeftArrow()`` method.

Using Object-oriented programming means that we provide more structure to our code.  It can be a little confusing
to figure out how to organize code when initially learning object-oriented programming.  It can be helpful to think
about objects as being responsible for knowing how to implement their own behavior.  From this perspective, within the 
main program, either in the ``draw()`` or ``setup()`` functions, we want to tell objects when to implement behavior, either
as part of a sequence of functions, or as the result of some event being triggered, but then we want to let the object
itself be responsible for knowing how to implement it's own behavior, so that code should be contained within the 
Class definition.

Questions:
==========

1.  Why have we decided to use ``int`` as the type for the state variable ``direction``?  
2.  What is the benefit of creating simple methods like displayLeftArrow( ) which do one specific task 
	instead of just writing that additional code within the pressedLeft( ) method?  

.. _Dr Doane: http://drdoane.com/thinking-through-a-basic-pong-game-in-processing/

.. _Shiffman's: http://learningprocessing.com