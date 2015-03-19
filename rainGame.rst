.. _RainGame:

==================
Rain Catcher Game
==================

In Shiffman's book, he creates a very simple game based on a simple ball-like objects 
and a few other simple objects like a timer object and a catcher object.  He uses arrays 
of objects so that we can use a loop to update objects for each iteration of the draw loop.

In Chapter 10, Shiffman introduces the idea of using algorithmic thinking to figure out
 how to design our program.  So one idea is to first try to figure out the components of any
 program that we're trying to create.  Let's follow Shiffman's project where he designs the
 RainCatcher game.  Below he specifies the details of the game.
 
 
Rain Game Code 
==================
 
 The object of this game is to catch raindrops before they hit the ground. 
 Every so often (depending on the level of difficulty), a new drop falls from the top 
 of the screen at a random horizontal location with a random vertical speed. The player 
 must catch the raindrops with the mouse with the goal of not letting any raindrops reach 
 the bottom of the screen
 
 He breaks down the game program design into 4 steps:
 
 	1. Develop code for a circle object that is controlled by the mouse.  This is the 'rain catcher'
 	2. Write a program to see if the 2 circles intersect
 	3. Write a timer program that executes a function every N seconds
	4. Write a program with circles falling from the top of the screen.
 
 
Psudocode
=============
 
  Psudocode is a way to write the main concepts for the program
  
  Setup:  
  	Initialize catcher object
  Draw:
  	Erase Background
  	Set catcher location to mouse location
	Display catcher
	
Catcher Class Code
===================
	
Here is code for the Catcher class::
	
	class Catcher{
        float r;  //radius
        PVector position;
        
        Catcher(){
          this(15);
        }
        Catcher(float _r){
                r=_r;
                position =new PVector(width/2, height/2);
        }
        void setposition(float _x, float _y){
                position.x=_x;
                position.y=_y;
        }
        void display(){
                stroke(0);
                fill(175);
                ellipse(position.x,position.y,r*2, r*2);
        }
	}
	
It's critical to note that in the constructor ``Catcher(float r)``, we are initializing the PVector object.  
This is an important function of a constructor:  to create any objects that are instance variables of the
class.  We can't use any of these objects until they've been initialized.  

	
Ball Class Code
=================
Here is the code for the Ball class  Note that we're using PVector for speed and location::
	
	class Ball{

    // instance variables
    color currentColor;  //current color of the ball
    color ballColor;  //store color to reset after highlighting
    color highlightColor;  //highlight color of the ball
    PVector position;
    PVector speed;
    float diameter;  

    //Constructor
    Ball(){  //default constructor
      	this(color(255,0,0), width/2, height/2, 5, 3, 5 );  //call the constructor with initialization values
    }

    // constructor with initialization arguments
   Ball(color _c, float _x,float _y, float _d, float _xspeed, float _yspeed){
      currentColor=_c;
      ballColor=currentColor;
      highlightColor=color(255,255,0,40);
      position=new PVector(_x,_y);
      speed=new PVector(_xspeed,_yspeed);
      diameter=_d;
    }

    // class methods  
    // this method is responsible for creating the displayed ball object
    void display(){
       fill(currentColor);  //this may be highlighted or ballColor
       ellipse(position.x,position.y,diameter,diameter);
       currentColor=ballColor; //reset ballColor back to original color
    }

    //this method is responsible for determining movement of the ball using the PVector function ``add()``
    void move(){
      position.add(speed);
      if(position.x > (width-diameter/2) || position.x < (0+diameter/2)){  
        speed.x *= -1;
      }
      if(position.y > (height-diameter/2) || position.y <(0+diameter/2)){
        speed.y *=-1;
      }
    }

   //comparison method:  do comparison and return true or false
  
     boolean isIntersecting(Ball otherBall){
        float distance= PVector.dist(this.position, otherBall.position);  //PVector distance between 2 points
     
        if( distance <= (this.diameter / 2) + (otherBall.diameter / 2)){
          return true;
        }
        return false;
    }

    void highlight(){
      this.currentColor = this.highlightColor;
    }

	} //end of Ball class
	
This is the end of the code for the Ball class.  This class has 4 different methods.  Each of these methods does a simple task. It is best to 
have your object methods designed to perform one well defined task.  If we have a more complex task, we can break that down into simpler methods 
we can also call methods from within other methods if it makes our code easier to understand.
			
Timer Class Code
=================

Here is the code for the timer class.  It uses the processing function ``millis()`` which counts milliseconds since the sketch started::		
			
	class Timer{
   		int startedTime;
   		int totalTime;
   		 
   				//constructors
  		 Timer(int _totalTime){  //constructor
     			totalTime=_totalTime;
   			}
   			
   				//methods
  	 	void start(){
     		startedTime=millis();   //set the start time to the current millis value
   		}
   
   		boolean isFinished(){
     		int passedTime=millis()-startedTime;
     		if(passedTime>totalTime){
       			println("timer finished");
       			return true;
     		}
     		else{
       			return false;
     		}
   		}
  
	}  //end of Timer class
				
Object Inheritance
====================

Here is the code for the Drop class, it is a child class of the Ball class and it inherits the instance variables
and methods from the Ball class.  we use the ``super`` keyword to refer to methods in the parent Ball class::
 
 class Drop extends Ball{
  boolean isActive;  //this is instance variable for drop class
  color dropColor;
  
  Drop(){
    this(random(width), -10);
  }
  
  Drop(float _x, float _y){
    // call the Ball constructor
    super();
    this.position.x=_x;
    this.position.y=_y;
    this.diameter=5;
    this.speed.x=0;
    this.speed.y=3;
    dropColor=color(0,50,255,100);
    this.ballColor=dropColor;
    isActive=true;
  }
  
  void move(){
    if(isActive){
       position.add(speed);  //we've set x speed to 0;
       if(position.y>=height+10){
         isActive=false;
     }
    }
  }
  
  void display(){
    super.display();
  }
  }

In the above code, we have created a class that's a child class of the Ball class.  We have
used the keyword ``super`` within the constructor so that we're calling the constructor for the
``Ball`` class.  We have used the ``extends`` keyword in the first line of the class declaration
to show that this class is a child class of the ``Ball`` class.  Any Drop object has access to the 
methods and instance parameters of the ``Ball`` class.  Since the ``Drop`` class has it's own
``move()`` method, then when a Drop object calls the ``move()`` method, it is this version that
will be executed.  

The Main Program
=================

Here is a start of a main program where we are testing each of our classes.  It's important to 
keep straight the fact that we're declaring our classes in separate tabs, but all of the code
to execute the program is all contained in the first processing tab.  In that tab, we have our
processing setup function and the draw function.  As we've done before, we declare any global variables
above and outside of the ``setup()`` and ``draw()`` functions.  These are object variables so 
we use the Class name, then the name of the object instance to declare the global object

	`class name:`  ``Catcher``   
	    
	`object instance name:`  ``myCatcher``

Here's the code for executing the beginning of our game::

	//rain catcher game: main file
	Catcher myCatcher;   //declare a Catcher object named myCatcher
	Ball ball1;
	Timer timer1;
	Drop drop1;

	void setup(){
 		size(300,300);
 		myCatcher=new Catcher();  // initialize using the Catcher default constructor
 		timer1=new Timer(2000);  // initialize a Timer object 
 		timer1.start();    //call the start( ) method
 		ball1=new Ball(color(0,255,100),15,25,20,3,8);
 		smooth();
 		drop1=new Drop(14,5);   //initialize drop1 using the Drop constructor
  
	}

	void draw(){
  		background(255);
  		myCatcher.setposition(mouseX, mouseY);  //
  		myCatcher.display();
  		drop1.move();
  		drop1.display();
  		ball1.move();
  		ball1.display();
  		if(timer1.isFinished()){
    		timer1.start();  //reset the timer when it is finished
  		}
  }
  

In the code above, the first thing we determine is the location of the catcher object
based on the user's mouse position.  Then we display the myCatcher object.  Similarly, 
with the drop1 and ball1 objects, first we move the objects, then we display the objects.
 
So far, we have several objects moving on the screen, but we need to re-factor this code 
in order to make some type of a game. We'll want to have lots of drop objects moving on the 
canvas.  Also, let's make use a paddle object instead of Shiffman's catcher object.  The 
paddle object will be controlled by keyboard movement, then collisions will be determined 
based on whether a falling drop object intersects with the paddle.  We'll cover this in 
the next section.

Test Driven Development
=========================

Below is an example of the program, here we're just testing the code for each object that
we've created.  It's a good idea to create your code in an incremental manner, so that you 
can discover errors early on.  For each section of code that you create, identify some way
that you can test whether your code is functioning correctly before moving on to create new
code.  This is the idea behind test-driven development (TDD), where you would create some
series of tests for each section of code, to insure it's working correctly, and the code for the 
tests is actually written before the code that you will be testing.   

.. raw:: html

	<div class="figure">
	<iframe width="328" height="380" scrolling="no" frameborder="0" src="http://www.openprocessing.org/sketch/190172/embed/?width=300&height=300&border=true"></iframe>
	</div>
	
Questions:
==========

	1.  How can we test whether the method ``isIntersecting( )`` works correctly? 
	2.  How can we test whether the timer object is working correctly?
