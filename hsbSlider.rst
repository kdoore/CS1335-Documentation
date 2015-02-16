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

	.. raw:: html

		<div class="figure">
		<iframe width="428" height="155" scrolling="no" frameborder="0" src="http://www.openprocessing.org/sketch/184101/embed/?width=400&height=75&border=true"></iframe>
		</div>	
	

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

Hue Spectrum- Rectangle
=======================

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
		
		float hueValue = hueMapping( i, sWidth) // local variable within for loop: values in the range of 0-255  
		
		stroke( hueValue , 255, 255 )  // i is hue value, 255 is max value for saturation and brightness
		
		line(i, yPos, i, yPos + sHeight )  // the line is vertical at x=i, y values are yPos, and yPos+ sHeight
		
	}

Map() Function
===============
	
This type of calculation is a mapping between 2 value ranges, we have a *current* range of 0-sWidth of the rectangle and we need to map that to the *target* range of hue values which is 0-255.  This is such a common type of calculation that `Processing`_ provides us with a function to do this called:  ``map()`` with the function signature:  ``map(value, start1, stop1, start2, stop2)`` The map_ function takes 5 values:  the first parameter is the actual value you're trying to determine the mapping for and the other 4 parameters are the min-max values for the 2 different numeric ranges which are the *current* and *target* ranges; the return value is the answer for your conversion calculation, so in our case we'd use::

	float hueValue = map( i, 0.0 , sWidth , 0.0 , 255.0 );  //current range is the 0-sWidth, target range is 0-255 possible hueValues
	
So we can actually just use the map function, no need to create our own function mapping function. The benefit of using a separate function for such a calculation is that we can test code to make sure it's working correctly.  

Inline Calculation with Integer Values
----------------------------------------

If we had simply done the conversion as an inline mathematical operation, it might be difficult to track down any math errors such as truncation issues since we had declared our sWidth to be an int variable type ::

	float hueValue= ( i / sWidth ) * 255;  // hueValue=0.0  division with integers i and sWidth causes truncation
 
Therefore, let's change our function signature so that the input variables are all floats, just to insure any division operations using these values results in a correct value.  So, now we should modify our drawSlider function as below::

	float drawSlider( float xPos, float yPos, float sWidth, float sHeight )  //new function signature using floats for input params
	
Interactivity
=================
We have decided to provide a narrow rectangle to represent the interactive component of the slider, so we need to create this rectangle and set it's fill color to the currently selected hueValue.  Then we'll need to use a conditional statement to determine when the user is moving the slider so that we can change the hueValue.  The code below tests to see if a users mouse is within the rainbow filled rectangle and if the mouse is pressed, if this is true, then we need to store the x-location of the mouse within the rainbow filled rectangle. We will use the variable sliderPos to store the position of the pressed-mouse, and we need to subtract the rectangle's xPos so that we're recording the location within the rectangle, not the mouseX position relative to the overall canvas as seen in the image below this code example::
	
	
	if(mousePressed && mouseX>xPos && mouseX<(xPos+sWidth) && mouseY>yPos && mouseY <yPos+sHeight){
     		sliderPos=mouseX-xPos;  //only change sliderPos if the user is within the slider area
			hueVal=map(sliderPos,0.0,sWidth,0.0,255.0);  // get new hueVal based on moved slider
  	}


.. raw:: html

	<div class="figure">
	<iframe width="428" height="155" scrolling="no" frameborder="0" src="http://www.openprocessing.org/sketch/184101/embed/?width=400&height=75&border=true"></iframe>
	</div>	

Global Variables
=================

The ``sliderPos`` variable is used to capture the current location of the slider due to the user's interactivity, but we need to keep track of this value between each function call, so we know where to position the slider, and what the current selected hueValue is. We also need a means to initialize this value before it's been moved by the user. These 2 variables are related to each other as discussed above when using the ``map()`` function.  We have determined that we need access to the hueValue in the draw loop so we can use it to set color for other items that the user draws, but we really don't have a need for this ``sliderPos`` value outside of this function, therefore, it should be a local value to this function, it has no meaning outside of this function.  

However, the _hueValue variable should be a global variable because it will be an input to our function as well as an output value from our function, and we need to set an initial value for the slider so that there's a default color even if a user hasn't touched the slider. However, if we created and initialized it as a local variable within the draw loop then it would be re-initialized each time the draw loop code was executed, therefore, this is justification for why we can declare this as a global variable, although there would be other ways we could achieve this initialization and we'll cover that when we learn object-oriented program design.  We'll name the global variable using an underscore at the beginning of the word ``_hueValue`` so that we can distinguish it from the local ``hueValue`` variable that we're modifying within the drawSlider function itself. The ``sliderPos`` value will be created and initialized using the map() function each time our function executes, based on the input value of ``hueValue``, it will only change if the user drags the slider. 

So, we need to modify our function so that we're passing hueValue in as a parameter, and then we return that value from the function so that any changes to the hueValue caused by user-interaction with the slider are reflected in the updated global _hueValue. Below is our final function signature, and the complete code is shown at the bottom of this page::

	float drawSlider(float xPos, float yPos, float sWidth, float sHeight,float hueVal){
		//function body
		return hueVal;
	}

Finally, the last bit of code for this slider is that we want to draw a white rectangle behind our slider, so our animation doesn't have 'trails'.  We don't want to use a background(255) in the actual draw loop because we want to allow the user to be creating drawings when dragging the mouse. Below is the final code for this slider.  We also have put a ``fill()`` and ``rect()`` functions in the draw loop to verify that shapes drawn in our app are being updated as the slider is moved.
	
Final Version of Code
======================

.. literalinclude:: /codeExamples/HSBSlider/HSBSlider2/HSBSlider2.pde

Questions
==========

	1.  Can you create a Saturation Slider to let the user change the HSB saturation value.
	2.  Can you create a Brightness Slider?
	3.  Can you create an Alpha Slider?
	4.  What representations can you use so the user understands how interaction with these sliders changes their selected color?
	5.  Can you create a small random variation in these values so when the user draws artwork, the colors show very slight random variation?
	6.  How can you incorporate these sliders into a drawing program so the user can create interesting artwork?
	7.  Why is it better to have hueValue as an input parameter to our function rather than modifying the global variable _hueValue within the function itself?
	8.  How would you use the ``map()`` function to determine the xPosition for the indicator rectangle if you only know the current hueValue? 
	9.  When using i as the x-postion of our colored lines that fill the slider rectangle, what adjustments do we need to make to insure that we can draw our 		slider anywhere on the canvas.  How can i be determined, relative to the slider xPostion? 

.. _Processing:  http://www.processing.org

.. _map: https://processing.org/reference/map_.html
