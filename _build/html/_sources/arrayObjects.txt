.. _arrayObjects:

==================
Arrays of Objects
==================

`Shiffman's`_ RainDrop Game uses an Array to store Drop objects, so let's look at how to use ``Arrays`` to 
store objects. Shiffman's `Exercise 10.4`_ provides the code that we'll review here.

On the processing website, the Array_ reference provides several examples of how to create an Array and how
to initialize the values within an array.  It's important to note that Arrays can only contain one type of
object, the ``type`` they are declared with. However, we'll see how Object Inheritance will provide a convenient
way to work with different object types in a single array.

Let's create an Array of Drop objects, first we need to declare the Array, then we need to initialize 
the Array and set the size of the array.  Then we need to create a Drop object for each Array element::

	//Main Program
	
	Drop[] drops;   // here we are declaring the array of Drop objects, with name: drops
	
	void setup(){
		
		drops= new Drop[10];    // here we are initializing the array and setting the size to 10.
		
		for(int i=0; i<drops.length; i++){  //initialize each array element 
			drops[i]= new Drop( );   //here we are creating a new Drop object for each array elelment
		}	
		
	}	 //end of setup()
	
Object Cache
==============

In `Shiffman's`_ RainDrop Game, he uses the Array of Drops as a way to reuse objects.  So, rather
than creating a new object each time a RainDrop falls below the bottom edge of the canvas, he 
identifies it as `finished` so that he can re-use it at a future time.  This is common in game 
programming.  So, we need to add a boolean state variable to the Drop class that will let us indicate
that a raindrop is not actively showing on the canvas.  In addition, we also want to make a method called
finished() that set the state of a drop to ``finished==true``.  This is another example of creating a simple method that does 1 simple task.  
We'll have another method called ``reachedBottom( )`` which we can also use to test for inactive drops::

	//Drop Class Definition
	// New variable to keep track of whether drop is still being used
	
  	boolean finished = false;
  	
	//Drop Methods
	 // If the drop is caught
  
  	void finished() {
  		finished = true;   //sets the finished state to true so the drop can be reused
  	}
  	// Check if it hits the bottom
  	
  	boolean reachedBottom() {
  		if (y > height + r*4) {  // If we go a little beyond the bottom
  			return true;
  			} 
  		else {
  			return false;
  			}
  	}
  
  
In the main program these methods, and the boolean ``finished``  variable are used to control the game.
The ``finished`` variable is used to filter the Drop objects so that the methods are only called on 
active objects.  This type of optimization is common in games.  It's much less ``expensive`` to check the	
value of a variable than to call a method or function, so the drop methods are only called on active drops.
The code below shows that within the main game ``draw()`` loop, the entire game is based on calling methods 
of game objects like Drop, Timer, and Catcher.  Below is a code snippet where a for loop is used to iterate over
the Array of Drop objects and then to call the appropriate Drop methods and increment game variables as needed::

	// Move and display all drops
    for (int i = 0; i < totalDrops; i++ ) {
      if (!drops[i].finished) {   //this is a filter so we only process drops which are active
        drops[i].move();
        drops[i].display();
        if (drops[i].reachedBottom()) {
          levelCounter++;
          drops[i].finished(); 
          // If the drop reaches the bottom a live is lost
          lives--;
          // If lives reach 0 the game is over
          if (lives <= 0) {
            gameOver = true; 
          }
        } 

        // Everytime you catch a drop, the score goes up
        if (catcher.intersect(drops[i])) {
          drops[i].finished();
          levelCounter++;
          score++;
        }
      }
    }

 Summary
 ========
 
In this section we have looked at how to use an Array to hold objects and then to allow 
looping through the array to check an object's instance variables like ``finished`` which 
can act as a filter to minimize the number of method calls that are executed by the program.
In addition, we discussed how the ``finished`` instance variable lets us identify objects that
are un-used so we can re-use them at a later time.  These types of optimizations are important
in game development so the game can execute at a fast speed. 
  
.. _Array: https://processing.org/reference/Array.html

.. _Shiffman's: http://learningprocessing.com

.. _Exercise 10.4:  http://www.learningprocessing.com/exercises/chapter-10/exercise-10-4/