.. _inheritance:

============
Inheritance
============

For our game, we want to have a variety of Drop objects.  The easiest way to do this is to 
create new Classes that inherit from the Drop Class.  In Processing, there can only be 1 level of
class inheritance.  In an earlier example, we had the Drop class inherit from the Ball class, let's
eliminate the Ball class and create the Drop class as a top level class.  Then we'll create
several different child classes that inherit from the Drop class.  One huge benefit of having 
child class objects is that we can still refer to all of these objects as Drop objects.  This
will allow us to loop through an array of Drop objects, to manage the game code more easily.

Let's create 2 child Classes:  Star and Seahorse  These objects will use the PShape object 
for their visual display.  Let's start with the Star Class.  