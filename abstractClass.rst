.. _abstractClass:

=================
Abstract Classes
=================

An Abstract class cannot be used to create objects.  Instead, Abstract classes function to  
provide a base class for sub-classes to inherit; the idea is that we can define a generic class
that has common instance variables and methods that will be shared by all sub-classes so they 
are defined in this abstract base-class.  

The generic idea of a Dropping object in a game inspired us to create the Drop class, and we 
also decided that we'd like to have a variety of specialized Drop objects, like SeaHorse so we used sub-classes 
to make these specialized versions of the generic Drop class.

In the games we are designing, we have used the Drop class as a base class for sub-classes 
like SeaHorse and Star.  We can use the powerful structure of polymorphism to allow us to 
refer to all sub-class objects, such as SeaHorse objects, as if they were actually Drop objects.  
This has allowed us to create Arrays and Array Lists of Drop objects, and we've been able to 
put SeaHorse, Star, and Drop objects in these containers.

We can decide that we only want to allow sub-class objects in our game, since we've created 
each of them to use distinctive .SVG icons to enhances our game's aesthetic appeal. 

In our code, to make the Drop class abstract is very simple, we just include the abstract keyword
before the class definition.  Once we add this ``abstract`` keyword to a class, we can no longer
make objects directly from that class.::

	abstract class Drop{
			///class definition code 
	}
	

No Abstract Objects
====================

Once we've made this decision to never create 'plain old' Drop objects, do we still even need 
the Drop class?  The answer is YES!  The Drop class is helpful because it allows us to define a common 
set of properties or instance variables, and a common set of behaviors, called methods.  
In addition, we can also require that all child classes provide their own implementation of certain methods, 
like ``display()``, which we have decided are essential Drop object behaviors, yet they are distinct for each child object.  
These required method over-rides are called 'abstract methods'. 

Abstract Methods
=================

Abstract Methods are methods that we require to be implemented within each inheriting sub-class.  For
our programs, ``display()`` is a method that would probably be abstract because we know that each different type 
of child object will have some unique type of object display.  For some sub-class objects, their display may
include some type of special animation like rotation or scaling etc. 

When we define a method as ``abstract``, we don't include any part of the method body in the base-class, we only 
include the method signature, so we know what return type and parameters that we must implement in sub-classes.
In addition, the compiler will give us an error if we forget to implement that method in a sub-class.  However,
it's important to note that the abstract class can still have methods like ``move()`` that are not abstract. These
methods have code within the curly braces that is executed when the method is called.  A method like ``move()``, which
has the same code for all sub-classes, should not be abstract, and the method should be implemented in the base-class
so it can be used by all sub-classes. Below is the syntax for creating an abstract method in the base-class::

	abstract class Drop{
		// instance variables
		// constructor
		
		abstract void display();   //abstract method declaration syntax
		
		void move(){   //move is not an abstract method
			y += speed;
		}
	
	}  
	
Abstract Method - Sub-class Implementation
===========================================

The ``display()`` method was declared as ``abstract`` in the Drop base-class.  So any class which
extends Drop must now implement ``display()`` or there will be a compiler error. In the SeaHorse
class, we have already written code to implement this method, so no changes are required. 


Summary:  This added `abstract` class structure might seem like a lot of extra work for no benefit, 
however these added structures makes our programs easier to extend and easier to debug.  




