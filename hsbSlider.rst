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

So, now to think about what code we will write in the function. The things we need to do in the function are:

- Draw an HSB hue gradient inside a rectangle to show available colors for selection.

- Draw another rectangle to show the selected color

- Draw an indicator rectangle that slides along the slider to modify the color

- Write code to allow changing values when the user drag the slider indicator

HSB Color works well for a color picker because it allows for a full color spectrum to be represented by making incremental changes to a single color variable.  In Processing, we can use the ``ColorMode(HSB)`` function so that the ``fill()`` and ``stroke()`` functions can use the HSB color values instead of the default RGB color values.  Whereas when using the ``fill( redVal, greenVal, blueVal )``, the input values which range from 0-255 specify red, green, and blue color components.  With HSB, the 3 input parameters for ``fill(hueVal, saturationVal, brightnessVal)``  specify hue, saturation and brightness values.  





.. literalinclude:: /codeExamples/HSBSlider/HSBSlider.pde
