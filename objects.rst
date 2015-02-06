.. _objects:

===========
Objects
===========

In the previous section we used the PVector object to create a bouncing ball animation and learned about dot notation used by objects to access object properties and object methods.  Now we're ready to create our first object, and we do this by creating a ``class``.  A ``class`` is the specification of all of the information for our object, we create a ``class`` to define our object's properties and methods, so we can consider that a ``class`` is like a recipe to make instances of objects.  

Ball Class
===========

We'll continue with the last example of a bouncing ball for our first class.  The syntax for a creating a class involves first naming the class, and this introduces a completely new type of syntax::

	class Ball{
	
	}
	
Notice there is no return type and there are no ``( )``, so this is not like declaring a function. Next we need to declare the class outside of all other functions.  The processing environment is setup so that we can use a new tab for creating our class code, but we could create our class on the current, main tab.  It's also a convention that we use capitalization for class names.  If we create a new tab, processing will prompt for the tab name, and we'll name it the same as the class name.  Below we've created the code for the Ball property variables and we've also created the default constructor which has no input arguments, we have given default initialization values to the property variables::

	class Ball{
	  // Variables
	  color c;
	  float xpos;
	  float ypos;
	  float xspeed;

	  //Constructor

	  Ball(){  //default constructor
	    c=color(255,0,0);
	    xpos=width/2;
	    ypos=height/2;
	    xspeed=1;
	  }

	}
	
In the image below we have a new tab, named Ball,  where we've created the code for the Ball class.  The tab must have the same name as the class in order for us to access this class from the main ball_sketch tab where we'll have our setup() and draw() functions.

	.. image:: /images/ballClass.png

