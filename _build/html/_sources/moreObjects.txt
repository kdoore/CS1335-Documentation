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
		boolean active;
		
		Ball(){
			this(color(255,0,0), 100.0, 100.0, 2.0, 2.0, 30.0);  //call the other constructor from the default constructor to initialize variables
		}
		
		Ball(color c, float x, float y, float xspeed, float yspeed, float diameter){
		
			this.position.x=x;
			this.position.y=y;
			this.speed.x=xspeed;
			this.speed.y=yspeed;
			this.diameter=diameter;
			this.active=false;
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
	

Interactivity and Events
=========================

We'll look at one method to add interactivity to our ball objects, such that when they are clicked upon by the mouse, we'll have them display a different behavior.  In order to add interactive behavior, we'll want to re-introduce the idea of events and states.  We can say that our ball will be in an 'active state' when clicked on.  We need to add a method to the Ball class that can check the mouse position when a user clicks the mouse and determine if the user is on the ball object. Here's a starting idea::

	void clicked(float mx, float my){  //input values are mouseX and mouseY
		float radius=this.diameter/2.0;
		if(mx > (position.x -radius) && mx < (position.x + radius) && mY > (position.y -radius) && mY < (position.y + radius){
			if(this.active){
			 	this.active=false;
			}
			else{
				this.active=true;
			}
		}
	}
	
	display(){
		if(active){
			this.c=color(255,0,255);
		}
		else
			this.c=color(255,0,0);
	
	}

