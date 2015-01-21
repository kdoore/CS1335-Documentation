.. _hsbSlider:

=========================
HSB Color-Slider Example
=========================

Overview
=========

The project below creates an interactive HSB color selector as an example project to demonstrate the iterative design process for designing functions.  In order to create this UI-widget, first we need to figure out the required components. First, let's plan to create a simple rectangle that is filled with the full HSB hue-range.  Then we'll need to figure out how to let the user interact with it to select a color.  Then we'll want provide a way to  use that selected color in another part of the program.

- **Input values:**  position and size of the slider widget. 

- **Output values:**  a hueValue that has been selected.

- **Display:** some  representation of a range of hues, and indication of currently selected hue value. 

- **Interactivity:**  a means for the user to modify and select a hue value.
	
The image below shows the widget we'll design.

	.. image:: /images/HSBSlider.png

HSB ColorMode
===============

	HSB Color works well for a color picker because it allows for a full color spectrum to be represented by making incremental changes to a single color variable.  In `Processing`_, we can use the ``ColorMode(HSB)`` function so that the ``fill()`` and ``stroke()`` functions can use the HSB color values instead of the default RGB color values.  Whereas when using the ``fill(float redVal,float greenVal,float blueVal )``, the input values specify red, green, and blue color components.  With HSB, the 3 input parameters for ``fill(float hueVal,float saturationVal, float brightnessVal)``  specify hue, saturation and brightness values. 
 
	For the HSB slider, we'll keep the saturation and brightness fixed at the maximum values of 255, so the only value that changes for this widget is the hue value, which will range from 0-255. The image below shows that the top surface of the HSB color-space cone represents values where the Brightness value is maximum.  The top surface of the cone represents a color wheel with saturation varying from 0 at the middle of the cone to a maximum saturation at the outer perimeter of the wheel.  At the outer perimeter, the saturation and brightness are at the maximum values, the hue varies in values from 0 to 360 degrees.  So, the minimum value of hue = the maximum value of hue = Red.  
	
	Our color slider (above) also shows that red occurs at the both the maximum and minimum values.  Although the circular values for hue range from 0 to 360 degrees, we will use the `Processing`_ convention of having color values that range from 0 - 255, which corresponds to 8 bits of color information for each color input parameter.  We will have to insure that our slider shows the full range of hue values, so we'll need to transform the 0-255 values to fit within the width of our rectangular slider ``sWidth`` dimensions.

	.. figure:: /images/HSB_Cone.png

		Image from:  `TomJewett.com <http://www.tomjewett.com/colors/hsb.html>`_

Function Declaration
=====================

Because this will be an interactive widget, then we'll need to use the processing ``draw()`` loop.  We'll also start with the ``setup()`` function so we can set the canvas size.  We also know that we're going to create a function that displays an HSB Slider so we can create the declaration that function using the information we identified above::

	void setup(){
	size(300,100); 
	}
	
	void draw(){
		float hueValue = drawSlider(20,20,200,50);  //draw the slider at x=20,y=20, 200px wide, 50 px tall
	}
	
	//function to create interactive HSB slider, returns the selected hueValue
	float drawSlider(int xPos, int yPos, int sWidth, int sHeight){
	 		
	}
		
Function Design - Step 1
==========================

So, now we need to think about what code we will write inside of the function. The things we need to do in the function are:

- Draw an HSB hue gradient inside a rectangle to show available colors for selection.

- Draw another small rectangle to show the selected color.

- Draw an indicator rectangle that slides along the slider to modify the color.

- Write code to allow changing values when the user drag the slider indicator.

Hue Spectrum Rectangle
========================

The first thing to do is to draw a basic rectangle using our function's input values.  Then we need to figure out how to create a RoyGBiv rainbow spectrum inside the rectangle that corresponds to the full range of hue values from 0-255. One idea is that we could fill the rectangle with points of color, where we vary the hue value of each point along the x and y values of the rectangle.  However, for our needs, we can actually use lines since we don't need to vary the color along the y-axis, all points in the rectangle that have the same y value will have the same hue value.  So, to color lines, we need to use the ``stroke()`` function in `Processing`_. We'll want to use a loop, and for each value of x in the rectangle, we'll want to vary the hue value.  We can do that with a for loop, where each value of i corresponds to a 1 pixel increment in the x direction. If our rectangle was 255 pixels wide, each pixel would represent 1 possible hue value. That code would be something like this::

	colorMode(HSB);   //set the colors to HSB
	
	for( int i = 0; i <= 255 ; i ++ ){
	
		stroke( i , 255, 255 )  // i is hue value, 255 is max value for saturation and brightness
		
		line(i, yPos, i, yPos + sHeight )  // the line is vertical at x=i, y values are yPos, and yPos+ sHeight
		
	}

This would work fine if we always wanted to have our slider have a width of 255 pixels, however we'd like to give ourselves more flexibility so that we can create sliders of any width, based on the input value sWidth of our function parameters.  We basically need to determine the fractional position for each location and multiply that by the max hue value of 255. We could write a separate function to do that calculation like below ::

	float hueMapping( int i, float sWidth ){  // i is the current value of 'i' in the for loop 
		
		return ( i / sWidth ) *  255 ;  // will return values in range of 0.0 - 255.0
	}


Then we could use in the following manner in the for-loop of our function ::

	for( int i = 0; i <= 255 ; i ++ ){
		
		float hueVal = hueMapping( i, sWidth) // values in the range of 0-255 for any width slider
		
		stroke( hueVal , 255, 255 )  // i is hue value, 255 is max value for saturation and brightness
		
		line(i, yPos, i, yPos + sHeight )  // the line is vertical at x=i, y values are yPos, and yPos+ sHeight
		
	}
	
This type of calculation is a mapping between 2 value ranges, we have a *current* range of 0-sWidth of the rectangle and we need to map that to the *target* range of hue values which is 0-255.  This is such a common type of calculation that `Processing`_ provides us with a function to do this called:  ``map()`` with the function signature:  ``map(value, start1, stop1, start2, stop2)`` The map_ function takes 5 values:  the first parameter is the actual value you're trying to determine the mapping for and the other 4 parameters are the min-max values for the 2 different numeric ranges which are the *current* and *target* ranges; the return value is the answer for your conversion calculation, so in our case we'd use::

	float hueVal = map( i, 0 , sWidth , 0 , 255 );  //current range is the 0-sWidth, target range is 0-255 possible hueValues
	
So we can change our conversion function 


.. literalinclude:: /codeExamples/HSBSlider/HSBSlider2.pde

.. _Processing:  http://www.processing.org

.. _map: https://processing.org/reference/map_.html
