.. _objects:

===========
Objects
===========

In the previous section we used the PVector object to create a bouncing ball animation and learned about dot notation used by objects to access object properties and object methods.  Now we're ready to create our first object, and we do this by creating a ``class``.  A ``class`` is the specification of all of the information for our object, we create a ``class`` to define our object's properties and methods, so we can consider that a ``class`` is like a recipe to make instances of objects.  In `Shiffman's book`_, he gives an analogy of the class definition as being like a cookie cutter, and a particular instance of an object being a cookie.  In the code below, the Ball class would be the cookie cutter and a single ball object that's created using the constructor syntax would be like a cookie.

For our bouncing ball, we can try to come up with a set of properties and behaviors that we will use to represent our ball in our program.  There are many other features of a ball that we're going to ignore as we try to come up with an abstract concept of a bouncing ball's features.  We can ignore whether the ball was made by an artist, or whether it came in a box when purchased.  We can ignore whether it's old and dirty, or brand new and shiny.  For our simple example of a bouncing ball, we'll limit our description to the following properties and behaviors:

	- **Name:**  Ball
	- **Properties:**  size, color, location x, location y, speed x, speed y
	- **Behaviors:**  move, display

Ball Class
===========

We'll continue with the last example of a bouncing ball for our first class.  The syntax for a creating a class involves first naming the class, and this introduces a completely new type of syntax::

	class Ball{
	
	}
	
Notice there is no return type and there are no ``( )``, so this is not like declaring a function. Next we need to declare the class outside of all other functions.  The processing environment is setup so that we can use a new tab for creating our class code, but we could create our class on the current, main tab.  It's also a convention that we use capitalization for class names.  If we create a new tab, processing will prompt for the tab name, and we'll name it the same as the class name.  Below we've created the code for the Ball property variables and we've also created the default constructor which has no input arguments, we have given default initialization values to the property variables::

	class Ball{
	  // Variables or Properties
	  color c;
	  float xpos;
	  float ypos;
	  float xspeed;

	  //Constructor

	  Ball(){  //default constructor
	    c=color(255,0,0);
	    xpos=width/2;
	    ypos=height/2;
	    xspeed=1.0;
	  }

	}
	
In the image below we have a new tab, named Ball,  where we've created the code for the Ball class.  The tab must have the same name as the class in order for us to access this class from the main ball_sketch tab where we'll have our setup() and draw() functions.

	.. image:: /images/ballClass.png
	
Next we can create another constructor that allows us to set initial values for the property variables when we create the object instance.  The syntax is similar to what we've used in writing other functions, except now we'll use the input parameters to initialize the class property variables, so this may seem a bit strange::
	
	
	Ball(color tempColor, float tempXpos, float tempYPos, float tempXspeed){
	
		c=tempColor;   //initialize c with input tempColor
		xpos=tempXpos;   
		ypos=tempYpos;
		xspeed=tempXspeed;
	
	}

PVector Ball Class
===================
	
Let's define the Ball class using PVectors and see what that looks like.  We will need to initialize our PVector objects as part of the object constructor functions.  Again here we have defined 2 different constructors.::

	class Ball{
	  // Variables
	  color c;
	  PVector position;
	  PVector speed;
	  float diameter;

	  //Constructor
	  Ball(){  //default constructor
	    c=color(255,0,0);
	    position=new PVector(width/2,height/2);  // create new PVector objects and initialize them
	    speed=new PVector(3,5);
	  }

	  // constructor with initializations
	  Ball(color tempc, float tempXpos,float tempYpos, float tempXspeed, float tempYspeed){
	    c=tempc;
	    position=new PVector(tempXpos,tempYpos);
	    speed=new PVector(tempXspeed,tempYspeed);
	  }

Class Methods
==============
	
Then the final part of the class definition is that we need to define methods for the class, these methods are the code we'll write to create the behaviors for our ball.  As mentioned in the previous section, it's convenient to create a method that will allow you to print out the values for the Ball Ojbect's property values that might be changing during a program execution, one way to do that is to create a function called ``toString()`` as shown below, this can be called from the processing global print() function because it takes a string as an input argument. This code would be included within the Ball class tab. ::

	// class methods  
	  void display(){
	     fill(c);
	     ellipse(position.x,position.y,diameter,diameter);
	  }

	  void move(){
	    position.add(speed);
	    if(position.x > (width-diameter/2) || position.x < (0+diameter/2)){  
	      speed.x *= -1;
	    }
	    if(position.y > (height-diameter/2) || position.y <(0+diameter/2)){
	      speed.y *=-1;
	    }
	  }

	  String toString(){
	    return " [ " + this.position.x + " , " + this.position.y + " ]";
	  }

Main Sketch
============
	
Then, let's include the code that is in the main sketch page where we'll actually create our Ball object instance::

	Ball myBall;

	void setup(){
	  size(300,300);
	  color ballColor=color(100,200,100);
	  myBall=new Ball(ballColor, 20,20,3,5);
	  background(255);

	}

	void draw(){
	   background();
	   myBall.move();
	   myBall.display();
	   println(myBall.toString());
	}

	void background(){  //over-ride the processing background function to allow trails.
	  fill(255,15);
	  rect(0,0,width,height);  //background alpha doesn't work in processing
	}
	
Below is the full code for the Ball class which includes 3 methods and 2 constructor functions and is called in the above main sketch code.::

	class Ball{

	  // Variables
	  color c;
	  PVector position;
	  PVector speed;
	  float diameter;  

	  //Constructor
	  Ball(){  //default constructor
	    c=color(255,0,0);
	    position=new PVector(width/2,height/2);
	    speed=new PVector(3,5);
	  }

	  // constructor with initialization arguments
	  Ball(color tempc, float tempXpos,float tempYpos, float tempXspeed, float tempYspeed){
	    c=tempc;
	    position=new PVector(tempXpos,tempYpos);
	    speed=new PVector(tempXspeed,tempYspeed);
	  }

	  // class methods  
	  // this method is responsible for creating the displayed ball object
	  void display(){
	     fill(c);
	     ellipse(position.x,position.y,diameter,diameter);
	  }

	  //this method is responsible for determining movement of the ball
	  void move(){
	    position.add(speed);
	    if(position.x > (width-diameter/2) || position.x < (0+diameter/2)){  
	      speed.x *= -1;
	    }
	    if(position.y > (height-diameter/2) || position.y <(0+diameter/2)){
	      speed.y *=-1;
	    }
	  }

	  // this is a convenience method to help with debugging
	  String toString(){
	    return " [ " + this.position.x + " , " + this.position.y + " ]";
	  }

	} //end of the Ball class definition
	
To review, in order to create a class, we need the following things which are all specified within a class definition:

	1.  Class Name
	2.	Instance Variables - these are properties / attributes of an object
	3.  Constructor functions
	4.  Methods, which are functions that control behavior of an object
	
.. _Shiffman's book: http://www.learningprocessing.com	

Questions
==========

	1.  Can you modify the speed attribute of a ball so that it's speed is dependent on the size of the ball?  Smaller Balls move faster than bigger ones?
	2.
	
