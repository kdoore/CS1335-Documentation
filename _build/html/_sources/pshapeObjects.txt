.. _pshapeObjects:

===============
PShape Objects
===============

The Processing website has a good tutorial about `PShape`_ objects, so it's advisable that you
review that tutorial in order to have a basic understanding of `PShape`_ objects.  The idea is
that `PShape`_ allows us to create geometric primitives that we can use as objects.  There are 
a variety of ways to use PShape, let's start by creating a Star class. 

Stars
=======
In the Processing `PShape`_ tutorial, the authors create a Star class, and they use the createShape(), beginShape()
and endShape() functions, along with a list of vertices in the Star constructor to create the geometry for the
Star object.  

However, they go on to describe a subtle concept; the idea of creating the star geometry one time in
the main setup() function, and then passing that PShape object as an input parameter to the Star constructor.  This 
can cut down on rendering costs, where Processing can essentially 'memorize' the geometry of the single PShape object, 
rather than having to render the geometry for each one.  For now, let's ignore these suggestions, and we'll create
the geometry in the Star constructor function.  Below are snippets of code for the Star class, where it inherits
from the Drop class.  For our current version of the RainDrop game, the Drop class does not inherit from any other class::

	class Star extends Drop{  
		PShape s;
		
		Star(float _x){  // constructor lets us set the x-position
			super(_x);  // call the Drop constructor as the first line of code
		// First create the shape
			s = createShape();
			s.beginShape();
			// You can set fill and stroke
			s.fill(102);
			s.stroke(255);
			s.strokeWeight(2);
			// Here, we are hardcoding a series of vertices
			s.vertex(0, -50);
			s.vertex(14, -20);
			s.vertex(47, -15);
			s.vertex(23, 7);
			s.vertex(29, 40);
			s.vertex(0, 25);
			s.vertex(-29, 40);
			s.vertex(-23, 7);
			s.vertex(-47, -15);
			s.vertex(-14, -20);
			s.endShape(CLOSE);
			}
		}
	
The code above is taken directly from the Processing `PShape`_ Tutorial, except that we've made the
Star class a child class of the Drop class. 

Because the Star class inherits from the Drop class, we don't need to explicitly
declare most of the instance variables.  However, notice that in the first line of 
code in the constructor that we're calling ``super()``, this is the Drop class default constructor. 

Shiffman notes in the `PShape`_ Tutorial that by default, a PShape geometry is defined relative to the canvas origin (0,0). 
Therefore, he notes that it's we'll almost always use ``pushMatrix()``, ``popMatrix()``, and ``translate()`` in order to locate
our PShape objects on the canvas.

So, to write a ``display()`` method for our Star, we need to remember to translate the origin of the canvas
to the x,y coordinates of our shape before displaying using the `shape()` function.  Here's a display method that
also lets us set the color of the PShape object::

	 void display(){
		pushMatrix();
		translate(x,y);    //x,y were given default settings
  		s.setFill(color(0,200,127));   //we can change the fill color here if we want
		shape(s,0,0);
		popMatrix();
  }
  
If we want to determine where the center of the PShape is, what code can we write?
The easiest thing to do is to note that we've translated the origin to the x,y position, so
if we create an ellipse at (0,0) then we'll be able to observe where the center is. 

PShape using SVG Image File
============================

Another way that we can use PShape is to load an .svg file.  There are may sources for .svg files, for
this project, I'm using an svg file from `The Noun Project`.  This site has lots of .svg icon files
that are free for use if you provide proper attribution for the designer of the .svg file.  I'm using
an .svg file designed by: Agne Alesiute at http://thenounproject.com/ .

In order to use an svg file for a PShape object, it's necessary to use the following syntax in 
order to load the image.  

	1.  The .svg file must be put inside a folder named: data, inside your sketch folder
	2.  PShape s= loadShape("seaHorse2.svg");  // this loads the image 
	3.  shape(s, x, y, width, height) ;  //this is used to display the svg.

With SVG files, the x,y position refers to the top left corner of the svg file.  If you open the
svg file in a text editor, you can read the width and height dimensions of the svg.  Those can help us
when we try to determine the bounding box for collision detection.  Below is the display function 
that is overriding the default style of the svg to allow us to reset the fill color.  Below that I've
added a rectangle to show the bounding box.  Since we're using translate(x,y) so that we've moved the 
canvas origin to the svg corner point, then we'll draw the rectangle at (0,0).::

	void display(){
		pushMatrix();
		translate(x,y);
		s.disableStyle();  // Ignore the colors in the SVG
		fill(c);    // Set the SVG fill to myColor
		stroke(55);          // Set the SVG fill to gray
		shape(s,0,0,sWidth,sHeight);
		noFill();
		rect(0,0,sWidth,sHeight);  //bounding box 
		popMatrix();
		}

.. _PShape:  https://processing.org/tutorials/pshape/