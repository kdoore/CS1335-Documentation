.. _buttonObjects:

===================
Buttons As Objects
===================

In the previous section, we discussed buttons in terms of features like: structure, function, and behaviors.  Then
we wrote code to implement these features, and this code is what turned a simple geometric shape into a user-interface
element.  How is a button different than a rectangle?  A button is different than a rectangle only when we write the code
to make it different. 
It is not difficult to imagine our program's buttons as objects because we all have experience using physical buttons
in our daily routines, and we have an intuitive understanding of how buttons operate. 

Physical Objects
=================
When we use a physical button, like the on-off button of a light-switch, we understand that the button has a physical 
configuration that controls electrical current to the bulb.  The physical movement of the switch itself is responsible for controlling
the state of the lightbulb as well as controlling the state of the switch itself, so we can look at the switch and understand if it's
in the on or off position. However, when we think about a virtual button on a device such as our mobile phone, there is not a tangible, 
physical configuration of the button that controls these behaviors.  To be intuitive for a user, the virtual button should behave analogously 
to the physical version, so it is helpful for us to think of buttons that we create as if they were physical objects.  

Object Responsibilities
=========================
If we think of our button as a physical object, then it makes sense for our button object to be responsible for it's own behaviors and states.  
A physical button has a configuration that controls and indicates if it's on or off. For our button, we need to create a *state variable*, ``on``, 
so the button object can remember whether it is currently on or off.  Similarly, we want the button to be responsible for responding to user-events
whether it is  and it's display (behavior), and for knowing it's current state, size, position and orientation (state and configuration).  Then we
can have many button instances, each responsible for is own object properties, and the object behaviors (methods) will be consistent across all instances.  

Objects and Classes
=========================
To create objects, we write code to define a **class**, which we can think of as the **blueprint** for creating objects. When creating objects in code, 
it's helpful to think of object responsibilities in terms of what information an object knows about itself, and the behaviors an object can do.
In our code, we will use **instance variables** to store an object's state and configuration information. 
To implement an object's behaviors, we'll write functions, these are referred to as the object's **methods**.  Once we write code to define 
the Button class, then we can create an unlimited number of button objects.  When our code is executed, then the button objects are
created where the compiler uses the class code as the blueprint.  

Object - Class Structure
==========================
The image below is a **UML Class Diagram**.  `UML`_ *Unified Modeling Language* is modeling language specification that provides formal structures
for designing models of systems.  The `UML`_ website states that 'modeling is the designing of software applications before coding.'    

.. image:: /images/buttonClass2.png

The class diagram shows the name of the class, the instance variables, and the methods.  In UML, we can use class diagrams to show relationships between
several different classes.  There are a wide variety of UML diagrams, some are designed to show structure like this class diagram, while other UML diagrams are
designed to model behavior and interaction of system entities.  

Processing Tabs
================

Processing provides tabs to allow us to organize our code when using classes, the main tab is the name of the sketch, while each other 
tab should be the name of the class, such as `Button`.  The image below shows the Button tab with the basic code elements which define the
class. 

.. image:: /images/buttonTab.png

When looking at the code in a Class definition, we can see a similarity with the structure of code that we've been writing in our previous examples.
The table below shows these similarities, in the left column, we can see that the code we write in the main tab can be though of as having 3
sections, the top of our programs is where we declare global variables, then the setup() function is executed once, while the draw() function is where
the main behavior of our program is typically executed.  When we write code for a class definition, we are required to write our instance variables at 
the top, then we must write the constructor functions, these are similar to setup() in that the constructor for an object is a function that is only executed
once, when the object is first created and it's used to initialize all of the instance variables for our object. Finally, the bottom of the tab contains
all of the functions / methods that we write for our object's behaviors.  Within these methods, we can also have local variables, but they will only exist
for the duration of that method's execution.  The instance variables exist for the life of the object instance, store all of the information about the state and
configuration of our object instances throughout the duration of an object's lifetime.

.. image:: /images/MainVsClass.png

.. Buttons in digital applications are considered to be components of a *Graphical User-Interface* (GUI).  These elements are designed
.. to respond to user interaction events such as mouse movement, mouse clicks, button presses etc.  
 


Questions
==========
1.  What is the difference between a class and an object?


.. _uml: http://www.omg.org/gettingstarted/what_is_uml.htm

.. _Learning Processing: http://www.learningprocessing.com/	