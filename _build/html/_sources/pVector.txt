.. _PVector:

========
PVector
========

On the processing website, there is a comprehensive `PVector tutorial`_ about the PVector object.  The PVector object is used to represent vector objects, and provides data elements and methods for vector math operations. `A vector is a collection of values that describe relative position in space.`  D. Shiffman - `PVector Tutorial`_. A vector represents the difference between 2 points in space.  When representing a point location, it is assumed that the 0,0 origin is one of the vector endpoints.  The simple ball bouncing animation below gives an example of using the ball's x,y location and adding horizontal speed and vertical speed to the balls current location to animate the motion of the ball.  Location, velocity (speed), and acceleration can all be represented using the PVector object.  The PVector object has methods to add vectors which simplify working with motion in multiple dimensions.  In addition, the PVector object provides a good introduction to object oriented programming.

Bouncing Ball - No Vectors
===========================

In the PVector tutorial and in `Learning Processing`_ Section 5.7, the example programs create a bouncing ball. The bouncing ball programs provide a good example of how to program object motion.
The code below is from the Processing.org `PVector tutorial` and it creates a simple bouncing ball.::

	float x = 100;
	float y = 100;
	float xspeed = 1;
	float yspeed = 3.3;

	void setup() {
	  size(200,200);
	}

	void draw() {
	  fill(255,10);
	  rect(0,0,width,height);  //transparent overlay background

	  // Add the current speed to the location.
	  x = x + xspeed;   
	  y = y + yspeed;

	  // Check for bouncing
	  if ((x > width) || (x < 0)) {
	    xspeed = xspeed * -1;  //reverse speed
	  }
	  if ((y > height) || (y < 0)) {
	    yspeed = yspeed * -1;   //reverse speed
	  }

	  // Display at x,y location
	  fill(175);
	  ellipse(x,y,16,16);
	}
	
Bouncing Ball with PVector
===========================
	
The PVector object provides variables to hold the data of the ball's location coordinates and also provides methods that allow for easy use of vector operations for movement.  In the code above, the ball's location is updated during each loop, so the new location = location + speed, and this is calculated separately for each of our canvas's 2 dimensions: x and y.  We can instead use a PVector to hold the location and speed, and then we can use the PVector add() method to calculate the new location of the ball. Below is the same bouncing ball program using PVectors for location and velocity.::
	
	PVector speed = new PVector(1 ,  3.3);  // create a new PVector object instance
	PVector location = new PVector(100,100);  

	void setup() {
	    size(200,200);
	}

	void draw() {
	    fill(255,10);
	    rect(0,0,width,height);  //transparent overlay background

	    // Add the current speed to the location: vector addition
	    location.add(speed);

	    // Check for bouncing
	    if((location.x > width) || (location.x < 0)) {
	      	speed.x = speed.x * -1;  //reverse speed
	    }
	    if ((location.y > height) || (location.y < 0)) {
	      	speed.y = speed.y * -1;   //reverse speed
	    }

	    // Display at x,y location
	    fill(175);
	    ellipse(location.x,location.y,16,16);
	  }
	

Below is a processing sketch for the PVector Bouncing ball. Click on the image to stop / start the animation.

.. raw:: html

	<div class="figure">
	<iframe width="228" height="280" scrolling="no" frameborder="0" src="http://www.openprocessing.org/sketch/184103/embed/?width=200&height=200&border=true"></iframe>	
	</div>
		
PVector Object
================





.. _PVector Tutorial:  https://processing.org/tutorials/PVector/
.. _Learning Processing:  http://learningprocessing.com