.. _moreObjects:

==================
More Objects
==================

In this section, we'll continue to explore the concepts of classes and objects using the context of the Ball class.  

this Keyword
=============

When referring to properties and methods from within a class definition, the keyword ``this`` is used to refer to the actual object itself.  We can use the keyword ``this`` to clarify some of the code we write when creating a class definition.  For example, if we create 2 different class constructors, we can use the keyword with function notation: ``this()``, as a way to call one constructor from within another constructor. For example, the default constructor can call another constructor using ``this()`` as a way to simplify the class code like below::

	class Ball{
		color c;
		PVector position;
		PVector speed;
		float diameter;
		int hitCount;
		
		Ball(){
			this(color(255,0,0), 100.0, 100.0, 2.0, 2.0, 30.0);  //call the other constructor from the default constructor to initialize variables
		}
		
		Ball(color c, float x, float y, float xspeed, float yspeed, float diameter){
			
			this.position.x=x;
			this.position.y=y;
			this.speed.x=xspeed;
			this.speed.y=yspeed;
			this.diameter=diameter;
			this.hitCount=0;
		}
	}

Comparing Objects
==================

So far, the methods we've written have only concerned 1 ball object.  How can we write a method to allow comparison between 2 Ball objects?  What would it mean for 2 unique Ball objects to be *equal*.  If we try to use the same syntax that we've used to compare primitive variable values, we will have problems!  With primitive variables, we can directly compare their values.  We may need to use type-casting if we try to compare an integer with a float but the syntax would be as follows::

 	//Compare Primitive types
	float float1 = 5.0;
	float float2 = 4.999;
	int int1 = 5;
	boolean equalFloats = (float1 == float2 );  //false
	boolean equalNumbers = ( int1 == float1 ); //error 
	boolean equalTypeCast1 = (int1 == int(float1) );  //true
	boolean equalTypeCast2 = (int1 == int(float2) );  //false
	
	// compare PVector objects
	PVector vector1 = new PVector( 10, 4 );
	PVector vector2 = new PVector( 5, 7 );
	boolean equalVectors = ( vector1 == vector2 );  // false
	
	vector1 = vector2;   // assignment
	boolean equalVectors2 = (vector1 == vector2 );  //true, both variables point to the same memory location, 
	
	println( vector1.x )  // 5   since the variable vector1 now refers to the same objects as vector2
	

So, to continue the discussion in terms of our Ball objects, let's write a method that will allow us to check whether 2 ball objects occupy the same space on the canvas.
We can look at some of the PVector methods like add(PVector pvec) to have an idea of how one object can interact with another one using methods.  We'll need to use the keyword ``this`` in order to write our equals function.  Let's agree that 2 balls are equal if they have the same size and position. Finally, our method must take a Ball as an input parameter and return a boolean as the return value::

	boolean isEqual(Ball otherBall){
		if(this.position.x == otherBall.position.x  && this.position.y == otherBall.position.y  && this.diameter = otherBall.diameter){
			return true;
		}
		else
		return false;
	}
	
	
With bouncing balls, it's unlikely that many ball objects will actually have the exact same values for position and size, so instead let's look at what collision would look like. Here we want to see if the distance between the centers of the balls is less than the sum of the 2 ball radiuses::
	
	boolean isIntersecting(Ball otherBall){
		float distance=dist(this.position.x, this.position.y, otherBall.position.x, otherBall.position.y);
		if( (distance <= this.diameter / 2) + (otherBall.diameter / 2)){
			this.highlight();    
			otherBall.highlight();
		}
	}
	
	void highlight(){
		this.c = color(255,255,0,80);
	}
	
	void reset(){
	    this.c=resetColor;
	}


Here is the full code for the Ball class that includes a test for intersection between 2 balls::

	class Ball{

	  // Variables
	  color c;
	  color resetColor;  //store color to reset after highlighting
	  PVector position;
	  PVector speed;
	  float diameter;  

	  //Constructor
	  Ball(){  //default constructor
	    this(color(255,0,0), width/2, height/2, 3, 5 );  //call the constructor with initialization values
	    
	  }

	  // constructor with initialization arguments
	  Ball(color tempc, float tempXpos,float tempYpos, float tempXspeed, float tempYspeed){
	    c=tempc;
	    resetColor=tempc;
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

	   boolean isIntersecting(Ball otherBall){
	      float distance=dist(this.position.x, this.position.y, otherBall.position.x, otherBall.position.y);
	      if( distance <= (this.diameter / 2) + (otherBall.diameter / 2)){
	        this.highlight();    
	        otherBall.highlight();
			this.hitCount++;
	        return true;
	      }
	      this.resetColor();
	      otherBall.resetColor();
	      return false;
	  }

	  void highlight(){
	    this.c = color(255,255,0,40);
	  }

	  void resetColor(){
	    this.c=resetColor;
	  }

	}

Here is the main sketch code::
	
	Ball ball1;
	Ball ball2;

	void setup(){
	  size(300,300);
	  color ballColor=color(100,200,100);
	  ball1=new Ball(ballColor,25,20,3,6);
	  background(255);
	  ball1.diameter=50;
	  ball2=new Ball(color(255,0,0),20,20,2,4);
	  ball2.diameter=40;
	}

	void draw(){
	   background(255);
	   ball1.isIntersecting(ball2);
	   ball1.move();
	   ball1.display();
	   ball2.move();
	   ball2.display();
	}
	



