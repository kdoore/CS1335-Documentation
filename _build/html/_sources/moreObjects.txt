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
		PVector location;
		PVector speed;
		float diameter;
		boolean active;
		
		Ball(){
			this(color(255,0,0), 100.0, 100.0, 2.0, 2.0, 30.0);  //call the other constructor from the default constructor to initialize variables
		}
		
		Ball(color c, float x, float y, float xspeed, float yspeed, float diameter){
		
			this.location.x=x;
			this.location.y=y;
			this.speed.x=xspeed;
			this.speed.y=yspeed;
			this.diameter=diameter;
			this.active=false;
		}
	}


Interactivity and Events
=========================

We'll look at one method to add interactivity to our ball objects, such that when they are clicked upon by the mouse, we'll have them display a different behavior.  In order to add interactive behavior, we'll want to re-introduce the idea of events and states.  We can say that our ball will be in an 'active state' when clicked on.  We need to add a method to the Ball class that can check the mouse location when a user clicks the mouse and determine if the user is on the ball object. Here's a starting idea::

	clicked(float mx, float my){  //input values are mouseX and mouseY
		float radius=this.diameter/2.0;
		if(mx > (location.x -radius) && mx < (location.x + radius) && mY > (location.y -radius) && mY < (location.y + radius){
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
			this.c=
		}
	
	}

