.. _moreRainGame:

======================
Rain Game - Extended
======================

In the previous section, we reviewed Daniel Shiffman's Rain Game, Object-Oriented Game.  Now, we want
to customize the game to make it a bit more interesting.   The first change we'll make is to add a
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
the direction of the ball object's speed.  

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

First we need to create a Paddle class:  This will be simliar to the Ball class, but we'll have
a rectangular object that moves based on the users keyboard interactions.  So, instead of the
move() method, we'll have  pressedLeft() and  pressedRight() methods::


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

For our program, we'll actually want to use these pressedLeft() and pressedRight() methods
within the keyPressed event.  The pressedLeft( ) method is an event handler.  It's code that
we want to be executed when the keyPressed event occurs.  So, in the main program, we would
create a Paddle object, for example paddle1.  Then in the keyPressed event, we'd use the
paddle1 object to call it's pressedLeft( ) method as in the code below::

	void keyPressed() {
  		if (key == CODED) {
  			if (keyCode == LEFT) {
      			paddle1.pressedLeft( );
    		} else if (keyCode == RIGHT {
      			paddle1.pressedRight( );
    		}
  		}
		}


.. _Dr Doane: http://drdoane.com/thinking-through-a-basic-pong-game-in-processing/