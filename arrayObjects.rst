.. _arrayObjects:

==================
Arrays of Objects
==================

`Shiffman's`_ RainDrop Game uses an array to store Drop objects, so let's look at how to use ``arrays`` to 
store objects.  

On the processing website, the Array_ reference provides several examples of how to create an Array and how
to initialize the values within an array.  It's important to note that Arrays can only contain one type of
object. 

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
isFinished() that will determine if a Drop object is no longer visible on the canvas.  This is another example
of creating a simple method( ) that does 1 simple task.  We can call it from another method like ``move( )``. So, 
some methods are helper methods that are only called from within the class, in Java, we would make this method 
private so it couldn't be accessed outside of the class.

	//Drop
	
.. _Array: https://processing.org/reference/Array.html

.. _Shiffman's: http://learningprocessing.com