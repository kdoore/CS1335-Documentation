.. _drawing

======================
Drawing Application
======================

This project builds on the previous 2 projects where we implemented code to create a hue color slider and an interactive button.  Both of these previous projects emphasize the use of functions to simplify programs.  In this section we'll explore some options for a creative drawing application.  As with many drawing programs, when the user drags the mouse, we'll write a program to create a brush-type of pattern.  We'll use functions to provide structure and organization for our code.

If we imagine ourselves as the brush in a drawing application, we should consider what information we'd have available as input, each time there's a new frame in the drawing loop.  We'll have access to the global values: ``mouseX`` and ``mouseY`` and that will determine the location of the shapes drawn in a current time-frame.  We also have access to the global values: ``pmouseX`` and ``pmouseY``, which represent the location of the mouse in the previous execution time-frame of the draw loop.  Using these values together can allow us to create more interactive drawing patterns. 

In `Learning Processing`_ chapter 3, exercise 3.6, Daniel Shiffman uses the mouseX, mouseY and pmouseX, pmouseY variables to draw a line following the mouse movement::

	line( pmouseX, pmouseY, mouseX, mouseY);
	
We can determine the distance that the has mouse moved since the last frame by observing that in the x direction, the mouse has moved the absolute value of (mouseX-pmouseX) and the same can be determined in the y direction. This provides a few interaction parameters that we can use to create a more interactive drawing brush than just drawing a line between successive mouse positions.  So, the speed of the mouse would be the distance traveled in a given amount of time.  We can use the fact that the time between frame execution is a measure of time, so one measure of speed would be::

	float speed = abs(pmouseX-mouseX) + abs(pmouseY -mouseY);
	
Then we can use that speed value to control some aspect of the elements drawn.  In Shiffman's example, he suggests using speed to vary the value of the ``strokeWeight``, below is one possible expression which could create an interesting  : 

	strokeWeight( 1 + (.05* speed));
	
Processing_ provides a distance function we can use to determine the distance between points.  It takes as input, the x,y positions of 2 points. We can use the pmouse and mouse positions to determine the distance between 2 points, or we can create some global position variables _x, _y and use those to determine distance from the mouse position.  This will allow us to control how far the mouse must move between drawing positions.  If we were to draw ellipses at the current mouse position, and only want to allow the drawing application to allow drawing another circle if the mouse has moved atleast some minimum distance between each circle before drawing the next circle, these global location values can provide more control than using pmouseX, pmouseY which are updated by the system each frame execution. ::

 	float _x;  //global variables which are initialized outside of draw
	  float _y;

	  void setup(){
	    size(400,400);
	    _x=width/2;
	    _y=height/2;
	  }
	  void draw(){
	    float distance=dist(_x,_y,mouseX, mouseY);
	    if((distance > 1) && mousePressed){
	      ellipse(mouseX,mouseY,20,20);
	      println(distance);
	    }
	  _x=mouseX;
	  _y=mouseY;  
	  }

.. _Learning Processing: http://www.learningprocessing.com/
.. _Processing:  http://processing.org
