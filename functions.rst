.. _functions: 

===============
 Functions
===============

Functions allow modular design and reusability of program components. Functions should be designed to perform a well-defined and specific task. Functions should be designed so that they are not inter-dependent on code external to the function and so that they don't cause unintended side-effects to code outside of the function.  

Function Syntax
================

When writing a code for function, the following components define the syntax of a function definition.

For an example function that adds an int and a float values, the function syntax is

- **function name:**  ``addNumbers``

- **function return type:** ``int  //the variable type of the function's return type must be declared``

- **function arguments:**  ``int arg1, float arg2``   ``//arguments must have a declared variable type and a name``::
	
		int addNumbers( int arg1, float arg2){   //function signature
		// body code of a function
			int sum= arg1 + int(arg2);
			return sum;
			}
	

HSB Color-Slider Example
===========================	

The :ref:`hsbSlider` project creates an interactive HSB color selector to demonstrate the iterative design process for designing functions.  In order to create this UI-widget, first we need to figure out the required components. First, let's plan to create a simple rectangle that is filled with the full HSB hue-range.  Then we'll need to figure out how to let the user interact with it to select a color.  Then we'll want provide a way to  use that selected color in another part of the program.

- **Input values:**  position and size of the slider widget. 

- **Output values:**  a hueValue that has been selected.

- **Display:** some  representation of a range of hues, and indication of currently selected hue value. 

- **Interactivity:**  a means for the user to modify and select a hue value.
	
The image below shows the widget we'll design.  Here's a link to the project and code: :ref:`hsbSlider`

.. image:: /images/HSBSlider.png


