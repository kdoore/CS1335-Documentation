.. _interface:

===========
Interface
===========

An interface defines a set of behaviors that are meaningful across several different types
object classes.  Because a class can only have a single parent or base class, interfaces provide
another method to define organizational structures for our programs.  Whereas a child-class can `extend` 
a base-class through `inheritance`, a class `implements` an `interface.`  An interface is similar
to an `abstract class` because it is defining methods that must be implemented in class that implements
the interface. 

For our game, we might want to have some of our game drops explode if they hit our paddle. 
However, if we don't want all of the drops to explode, how can we take advantage of polymorphism, 
where we have an ArrayList of Drop objects, where some of these objects can explode and 
some don't explode?  We have defined the Drop class to be an ``abstract class``,  where the
display() method is an abstract method that must be implemented by all child classes.  

For the example code below, we have 2 sub-classes, CircleDrop and SquareDrops, where we only want 
the CircleDrop objectsto be Explodable. To do this,  we'll have it implement the explode() method from
the Explodable interface.   

To use an interface, first we must define the interface, this is similar to the syntax for defining a class.
Since an interface is similar to an abstract class, we will only provide method signatures, and no method
body code for the methods that we are defining for the class. The methods are abstract by default, so the abstract 
keyword is not required, however only the method signature can be part of the interface definition. The second 
thing we need is a class that will implement the interface, and that class must provide method definition code 
for each method defined in the interface that it is implementing. 

Part 1:  Define the interface
===============================

Interface Definition::

  	//an interface is not a class, but has a similar syntax, notice the keyword: interface
  	
	interface Explodable{
	
	void explode();  //  method signature only
	
	float getExDimension();  // method signature only, provides access to child class attribute 
							 //this is the dimension that we'll expand for explosion display
	}
	

Part 2:  Some Class implements the interface
==================================================

Interface Implementation::

    // class circleDrop implements the Explodable interface
    
	class CircleDrop implements Explodable{
		float x,y,radius;
		
		CircleDrop(){   //default constructor
			x=random(0,width);
			y=random(0,height);
			r=10;
		}
		
		void explode(){   //this Explodable method must be defined in this class
		    r = r + 5;
		}
		
		float getExDimension(){ //this Explodable method must be defined in this class
			return r;      
		}
		
	}
	

Part 3:  Combine Inheritance and Interface 
===========================================

It is important to note that a child class can use both inheritance and multiple interfaces 
using the keyword syntax below: 

	- Inheritance: extends
	- Interface: implements

The use of Inheritance and Interfaces can be combined, for our project this allows us
to create a child class that extends Drop, and implements Explodable::

    class CircleDrop extends Drop implements Explodable{
    		
    		float radius;
    		
    		circleDrop(){
    			super();   //call the Drop constructor
    			radius=10;
    		}
    		
    		void display(){  // this Drop abstract method must be defined in this class
			ellipse(x,y,r*2,r*2);
			}
			
			void explode(){
				r = r + 5;
			}
			
			float getExDimension(){ //this Explodable method must be defined in this class
			return r;      
			}
    	
    }
    
Part 4:  Polymorphism and Interfaces:
======================================

For our game, we have used polymorphism to allow us to create a Drop Array which 
contained child objects.  We can also use polymorphism with interfaces, similar to how we have
used the abstract Drop class, once we made Drop an abstract class we could no longer 
create Drop objects.  Similarly, while we never create an Explodable object, we can create
a reference to an object that implements Explodable, and we can check whether each Drop object 
instance is an Explodable type of object.  The use of abstraction through polymorphism means we can have
many different types of drop objects, where only some of these are explodable, and we can operate
on all of these Explodable using an Explodable reference.  

Instanceof and TypeCast
=========================

We can use the ``instanceof`` keyword to determine if a dropList instance is an object that 
implements Explodable. Here we have an ArrayList: droplist of Drop sub-class objects, we
are iterating through the list in reverse order in case we want to remove an element from the list

	- Check to see ``if(d instanceof Explodable)``
	- Create an reference variable of type ``Explodable e``
	- Use `typeCasting` to convert ``d`` to an object that can call ``explode()``
	 
Below is the code for this::

	for (int i = dropList.size()-1; i >= 0; i--) { 
	
	Drop d=dropList.get(i);
    //test to see if the object instance implements the explodable interface
    
    if(d instanceof Explodable){
       Explodable e=(Explodable)d;   //type cast
       e.explode();   //call explode() on the objects that implement Explodable
       
       if((e.getExDimension())>80.0){  //check size limit 
           dropList.remove(i);
       }
     }
     
Below is a link to the example program.

https://utdallas.box.com/InterfaceExampleZip