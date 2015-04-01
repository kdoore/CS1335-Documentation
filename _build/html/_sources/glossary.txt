.. _glossary.rst:

===============
Glossary
===============

.. _Abstract Class:

Abstract Class
--------------------

An abstract class is a class 


.. _Function Overloading:

Function Overloading
------------------
Function overloading occurs when there are several different variations of a single function. 
Each version of a function must have a unique function signature, specifically, the arguments
for a function must be unique between function versions, the compiler must be able to determine
which version of the function is being called, the compiler can distinguish between versions based
on the argument types used when a function is executed.  A common example of this in Processing
is seen with the color-type functions like ``fill()``.  There are several versions of the fill() function; 
if there is only 1 input parameter such as: fill(float grayVal), then the function interprets that to set the grayscale value.
If there are 2 input parameters, then the second argument is used to set the alpha value.  
fill( float grayVal, float alphaVal).  Function overloading is a powerful way to implement
slightly different behaviors depending on the number and type of input parameters for a function.  
Another example of overloading occurs with class constructors, a default constructor takes no
input parameters, while other constructors for an object take input parameters to set some default
values for initialization of instance variables. 


.. _Method Override:

Method Overriding
------------------
Method overriding is a feature of Inheritance in many Object-Oriented languages; where both the parent and child class
implement identical versions of a specific method.  In the Processing language, many of our custom classes
have implemented a  `` display()`` method, since many of our programs create visual designs, animations,
or games.  The parent class and child class both implement displqy() methods that have identical
method signatures, so the compiler follows a specific protocol to determine which method should be
executed when a child object calls a method.  When a parent class object executes a method, then the
parent class's method code is executed.  However, when a child class executes a method, the compiler first
looks at the child class definition to see if the method has been implemented within the child class definition,
if it has been implemented in the child class, then that child version of the class method is executed.    

.. _Object Inheritance:

Object Inheritance
-------------------

Inheritance is an important feature in most Object-Oriented languages.  Inheritance in programming reflects
the idea that the concepts that we're trying to represent in our code often have natural hierarchical relationships, 
where objects can be categorized as belonging to a broader type of object.  These object hierarchies can be useful for
organizing our program code and is one of the main benefits of Object-Oriented languages.  We easily understand that 
`animal` is a broad category of creatures, where there are many different types of 



.. _Polymorphism:

Polymorphism
-------------

Polymorphism is one of the main benefits of using the Object-Oriented concept of Inheritance, where a child
class is designed as an extension of the base or parent class.  Polymorphism means 'many-shaped`, and in Object-
Oriented programming, it means that we can create a child object, using a reference variable of the parent
base class.  In our paddle game, we created an array of Drop objects, where `polymoprhism` allows us to have
Star and SeaHorse objects contained within the array of Drop objects.  For a single element, the code below 
uses a Drop object reference which we then assign a SeaHorse object, then we can re-assign a Star object. It is 
important to note that this is a directional, or one-way relationship, we can't use a reference from a child class
to point to a base or parent class object as shown in the last line of code below::
	
	Drop drop1;      //Drop object reference can point to Drop objects and objects which extend the Drop Class
	Star star1;
	drop1 = new SeaHorse();    //SeaHorse is a child class of the Drop class
	drop1 = new Star();			//Star is a child class of the Drop class
	
	star1= new Drop();    ///ERROR
	
.. _Static Variables:

Static Variables
-----------------
Processing does not support traditional static variables, the only way to have static variables
is to have the entire class declared as a static class.  