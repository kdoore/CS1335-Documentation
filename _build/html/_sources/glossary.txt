.. _glossary.rst:

===============
Glossary
===============

.. _Abstract Class:

Abstract Class
-----------------

An abstract class is a class that cannot be used to instantiate objects, it is designed specifically
to be used as a base-class for sub-class inheritance.  Abstract classes provide structure: 
instance variables and methods, that sub-classes will inherit.  Abstract classes must be extended by base classes,
they are explicitly designed to function as a base-class.

In addition, abstract classes can have abstract methods, these methods define a contract that 
child classes must enforce, any child class that extends an abstract class must implement code
for any abstract methods defined in that class.  Abstract methods allow us to use polymorphism, 
for our game, we have defined Drop as an abstract class.  This means that we can never create 
Drop instances.  However, we can create Drop-type references, we can think of these as pointers
that are of type: Drop.  These reference-pointers can point to any object instances that are from
a child class of the Drop class, in our game, these would be starfish, stars, jellyfish, etc.  
The benefit of having Drop as an abstract class is that we can define all common instance variables
within the Drop class, and we can also define any common methods, where all sub-classes use the
base-class method.  move( ) is an example of a method that is the same for all sub-classes, so 
we can define it one time, in the base-class: Drop.  This prevents duplicated code, improves our 
program's organization, and makes it easier to extend our program by simplifying the process of
adding new sub-class objects.

.. _Abstract Methods:

Abstract Methods:
------------------
Abstract methods are used in abstract classes and interfaces.  These methods define a contract that 
child classes must enforce, any child class that extends an abstract class must implement code
for any abstract methods defined in that class. Similarly, any class that implements an interface
must provide code to define the methods that are declared in the interface.  Method declaration 
consists of the signature of a method,  this includes the return type, the method name, and the 
input parameters for the method.  Abstract methods are methods that have unique meaning for each
class, such that it makes sense for them to have their detail specified at the sub-class level. The
use of abstract methods provides a means to define a structure and require that it's enforced by 
all classes that implement or extend that defined parent-class or interface construct.  In contract,
there are many methods that will be identical across sub-classes, these should not be abstract
and should be defined at the base-class level.  There is a defined syntax to specify non-abstract
methods for interfaces, however this is not supported in Processing, and all interface methods
are abstract by default in Processing.


.. _Interface-Def:

Interface:
-----------

An interface is very similar to an abstract class.  Similar to abstract classes, interfaces can't be used to
create object instances.  In fact, by default, methods of an interface are abstract.  This means that there's 
only method declaration in an interface. Typically, interfaces don't have variables, however constant variables
can be defined for use in an interface.  A class can ``implement`` an interface, whereas, a class can
``extend`` other classes when using inheritance.  The important feature of interfaces is that a class
can implement a unlimited number of interfaces, whereas a class can only extend 1 base-class in Processing.  Therefore, interfaces
are used to provide an abstract structure for common concepts such as `comparable`, `clickable`.  For our game
we developed an `Explodable` interface, and determined that only some of the Drop child classes will
implement this interface.  The `Explodable` interface has an ``explode()`` method that must be defined
in any class that implements `Explodable`.


.. _Function Overloading:

Function Overloading
---------------------

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
`animal` is a broad category of creatures, where there are many different types of animals such as dogs and cats.  We
are comfortable with the concept of Animals being a broader category things than the categories of dogs or cats.  If we
were to create a program about an animal shelter, it would be nice for us to be able to make use of these relationships
between these types of objects in our program.  We can do this by using the specific syntax keyword ``extends`` when
we define the Dog and Cat classes, where we would need to first define the Animal class.  The benefit of using inheritance
in our programs is that we can eliminate duplicate code, and we can also use polymorphism as defined below to allow the 
use of the base class as a way to reference sub-class objects.

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
is to have the entire class declared as a static class.  We aren't going to cover Static methods, classes
or variables in this class, however this is an important concept that will be covered in the next course.