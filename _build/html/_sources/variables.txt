.. _variables:

============
 Variables
============

Variables can be considered as named containers to hold values that can be modified.  Since `Processing`_ is based on the Java language, it uses :ref:`Typed-Variables`. Variables can hold *primitive* values which involve a single piece of information like integers: :code:`int`, decimal numbers: :code:`float`, booleans: :code:`boolean`, and characters: :code:`char`.  


Declaration and Initialization
===============================

In the example code below, the first line of code prints the sum of 2 integer literal values.  In the code that follows, :code:`int` and :code:`float` variables are declared and assigned values.   ::

	println( 5 + 7 );  //two integer literal values are added together
	
   	int num1;  //declare an integer variable

	int num2 = 5;   // declare an integer and assign it a literal integer value
	
	float num3 = 5.0 //declare a floating point variable and assign it a literal decimal value;
	

.. _typed-variables:

Typed Variables
================

When using P5js and the Khan-Academy Javascript Tutorials, variables were all of the type :code:`var`.  There was no distinction between different types of variables. However, with Processing, all variables must be declared as a specific data-type such as :code:`int`, :code:`float`, :code:`boolean`, :code:`char`, etc. Typed variables allows the computer to allocate enough memory to hold the value.  

Integers
=========

Whole numbers like -1, 0, 1, 2.

Integer Division
-----------------

When using the math division operator with integers, the resulting value is also an integer, so any fractional division remainder is truncated::

 	println( 5 / 3 );     // 1 
	
	int num1 = 5 / 2;   // 2   the remainder from division is truncated.
	 
	int num2 = 5.0 / 2  // error cannot convert from a float to an int	

Floats
======

Decimal numbers like 1.0, 5.5, -1.0.  Also, whole numbers like 1, 0, 1 can be stored as floating point numbers.

When initializing floating point numbers which are created using math operators, it's important to realize that integer division can cause unexpected results.  Multiplying each division expression by the :code:`float` value *1.0* can help insure no truncation occurs.

In the code below, since both 2 and 5 are written as integer literals, then expression 5/2 is evaluated using integer division. Make sure that at least 1 value is a decimal value to insure correct division of numbers assigned to :code:`float` variables::

	float someFraction = 5 / 2;   // 2.0   integer division of 5/2 is truncated so the result is 2.0
		
	float correctFraction = 5.0 / 2;    // 2.5  
		
	float correctFraction2 = (5 / 2) * 1.0  // 2.5  multiplication by 1.0 insures decimal division

Integer and Float Type-Conversion
==================================

Care must be taken when using :code:`float` and :code:`int` variables in expressions or mathematical operations together, particularly when doing division.  In general, an error will be generated if an operation will result in truncation. Processing can automatically convert an :code:`int` to a :code:`float` value, however an error will occur when trying to convert a :code:`float` value to an :code:`int` value. ::

	int num1 = 5; 
	int num2 = 2;
	
	float val1 = num1 / num2;	//2.0  integer division expression is evaluated then assigned to val1.
	
	int num3 = val1;	// error cannot convert from a float to an int 

Processing provides type conversion functions to allow conversion between :code:`int` and :code:`float` variable types.  There are 2 different but equivalent syntax conventions for type conversion displayed in the example code below::

	float val1 = 5.2;  
	
	int num1 = int( val1 );  // 5	With this syntax, int( ) works like a function to convert a float value to an integer.  The value is truncated.
	
	int num2 = ( int )val1;   //5	This syntax also works to convert a float to an  int, and results in truncation of the number.
	
Modulus Operator
=================

The modulus operator :code:`%` calculates the remainder of integer division. Modulus is often used to determine if a number is odd or even where n % 2 equals 0 if n is even.::
 	
	println( 5 % 2 );   // 1	2 goes into 5 two times with a remainder of 1
	println( 5 % 3 );   // 2	3 goes into 5 one time with a remainder of 2
	println( 12 % 2 );  // 0	test to determine if 12 is even, for any number n, if n % 2 = 0 then n is even.
	println( 2 % 5 );   // 2	5 goes into 2 zero times with a remainder of 2

Booleans
========

Boolean variables can have the value :code:`true` or :code:`false`;  Boolean variables are useful for storing the state some program element to control some branch option within the program, often within a conditional branch, the boolean variable value is changed to indicate the state of the program has changed.::

	var isActive = true;
	if(isActive){ 
		doSomething();	//trigger some state dependent behavior 	
		isActive=false	//change the state variable after the state behavior has been triggered
		}
	

Characters
===========

Single letters or other unicode symbol like 'a', 'b', 'A', '%' .  The :code:`char` variable type must use single quotes around a single character.  When multiple characters are used in a single variable, then the :code: `String` variable type should be used. ::
	
	char someChar = 'a';
	char otherChar = '&';
	  
Random Numbers
===============

The :code:`random( )` function in Processing_ can be used to generate psudo-random variables. The :code:`random(float min, float max)` function takes 2 input parameters and returns a floating point number ranging from the first argument to the second argument.  If only 1 argument is used, then 0 is the default minimum value.::
	
	float randVal1 = random( 1 , 100 );   //returns a float between 1 and 100.
	float randVal2 = random( 100 );	//returns a float between 0 and 100.
	

Questions
==========

	What are the values of the following?
	
		1. :code:`int num1 = 2 % 10;`
		2. :code:`int num2 = 10 % 2;`
		3. :code:`int num3 = int(4.999);`
		
		
	

.. _Processing: http://processing.org