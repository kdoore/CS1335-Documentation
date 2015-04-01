.. _inheritance:

============
Inheritance
============

For our game, we want to have a variety of Drop objects.  The easiest way to do this is to 
create new Classes that inherit from the Drop Class. Inheritance represents a hierarchical
relationship between object classes, which we can think of as being an `is-a` relationship.  
In Processing, there can only be 1 level of class inheritance. Other languages allow for deeper
object hierarchies.  For our example, we'll say that a Seahorse `is-a` Drop, and a Star `is-a`
Drop object. 

Polymorphism
==============

One huge benefit of having  child class objects is that we can still refer to all of these objects as Drop objects, 
this is referred to as `polymorphism`.  This will allow us to have an array of Drop objects where
we can loop through an array of Drop objects, with the actual objects in the array being child objects
such as Stars or SeaHorse objects. When we define the Star and SeaHorse classes of objects, we
must ``extend`` the Drop class, the child classes will inherit all instance variables and methods
from the Drop class. This will allow us to manage multiple types of dropping objects in the game code, 
while still referring to these objects as Drop objects.

Let's create 2 child Classes:  Star and Seahorse  These objects will use the PShape object 
for their visual display.  Let's start with the Seahorse class.  We need to use the `` extends`` 
keyword to indicate that the SeaHorse class is a child class of the Drop class.  As noted above, 
they will implement PShape for their display, in-fact we'll use an .svg file to create the shape
for these objects, so the display() method will need to be implemented in these child classes, so 
it will over-ride the Drop class display method::
 	
 	//class definition for the SeaHorse class
 
	class SeaHorse extends Drop{
		PShape s;
		
		SeaHorse(){
			super();  
			s=loadShape("seahorse.svg");
		}
	
	display(){
			//code in here to display the .svg file
			println("seaHorse method");
		}
	
	} //end of SeaHorse class

Method Over-ride
==================

So, both the Drop class and the SeaHorse class have code that implements the display() method.
So, the compiler must determine which display() method to use if a SeaHorse object calls the
display() method.  The compiler first checks the child, SeaHorse class, if it has code implemented for 
a method, when a method has been called by a child object, then the child method code is implemented.  
Let's clarify this concept of method over-ride. In the main program tab, we'll have a SeaHorse object, and 
then it will call the display() method.  We'll expect that it'll print the text "seaHorse method" 
to the console since that's the code we've written above in the Seahorse display() method.::

	//this code is in the main program tab
	
	Drop shorse=new Seahorse();
	
	draw(){
		shorse.display();
	}


Arrays of Multiple Types of Objects
====================================

An array must be declared to contain a specific type of element.  Above we've looked at an 
array that's been declared to hold Drop elements: ``Drop[] drops``.  However using the Object 
concept of Inheritance will allow us to use this ``drops`` array to hold several different
types of Drop objects, as long as these other objects are from a class that is a child class
of the Drop class.  We 