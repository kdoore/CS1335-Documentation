.. _arrayList:

============
ArrayList
============

An ArrayList is a `data structure` that allows us to store objects in our programs, and is
similar to Arrays in many ways, in-fact, the ArrayList Class uses Arrays, but provides convenience
methods to allow us to dynamically resize by adding or removing elements during our program's execution.  
An ArrayList can be considered a resizable array, we can add and remove elements to an ArrayList using ArrayList methods. An ArrayList provides a  good
example of how we'll want to build our own classes because it provides access to features like size
using a method: size().  That is different than Array because when we use Arrays, we could 
access the size using dot notation to access the ``length`` instance variable.  


Declaration
--------------
So, we'll create an ArrayList object by calling the ArrayList constructor., however it's slightly
different than what we've seen when creating objects because we also need a way to tell the compiler what type
of objects we'll store in our ArrayList.  For this, we'll use a special syntax ``< Type >``, where we'll
use angle brackets when we declare and initialize our ArrayList.  This may seem odd at first, but
you will get used to it and will see it used for other similar types of Classes that hold 'Collections' of
Objects.

Here is how we can declare an ArrayList, we need to use a special `type` syntax to specify
what `type` of objects we'll use the ArrayList for. This syntax is a `type parameter`.  

	``ArrayList<Drop> dropList;``

For an Array, we would have specified this way:

	``Drop[] dropArray;``

Notice that we use the angle brackets to specify the type of object ``<Drop>``

Initialization
---------------
Since we will normally do initialization separate from the declaration, below is the syntax for
initializing an ArrayList compared to how to initialize an Array.::

	ArrayList<Drop> dropList;  //declare
	dropList = new ArrayList<Drop>();   //we're calling the ArrayList constructor
	
Below is the Array syntax we've been using where we have to declare the size of the Array when
we initialize it, the Array syntax is quite different from other object constructors we've worked 
with, it has it's own unique syntax whereas the ArrayList is similar to other objects.::

	Drop[] dropArray;       // declare
	dropArray = new dropArray[ 6 ];   //initialize
	

Add an element
-----------------------

Below we'll add an element to an array, we use the array name and bracket with index value to initialize an element::

	``dropArray[1]= new Drop();    //standard Array notation``

For an ArrayList we use the ``add()`` method of the ArrayList object, and our new element is added to the leftmost
end of the ArrayList.  In the example below we are creating a new Drop element that has not been assigned to a
reference variable. This is a convenient way to create and add objects to an ArrayList::

	dropList.add(new Drop());  //ArrayList add( Object e ) method takes an object as the input parameter
	
Or, if we already have an element, we can just add that by passing the reference variable as the 
input argument to the add() method as below::
	
	Drop drop1 = new Drop();   
	
	dropList.add(drop1);
	
	
Access Elements
-----------------
	
One common method to access and use an element in the ArrayList is to use a ``for loop`` and an iterator
variable, ``i`` , and loop through the ArrayList using the ArrayList size() method to control the for loop.
If you are not making any modifications such as adding or removing elements, a normal for loop syntax works 
fine as shown below, however this syntax won't work if you're adding or removing elements in the array.::

	for(int i=0; i< dropList.size() ; i++){
			Drop d= dropList.get(i);   //you must create a Drop reference variable to retrieve an object instance using get()
			d.display();  //do something with the current drop
	}

	
	
Remove Elements - Caution when Looping
----------------------------------------

In order to use a for loop to access ArrayList elements when we know we'll be removing some elements,
we need to remember that the ArrayList is actually using an Array, so we need to be careful to stay within
the bounds of the array, and to make sure we're able to access each element as we expect.  

Let's look at a simple example.  If we create an ArrayList with 2 elements, 
then they will have index values of 0 and 1.  If we were to use the loop above, then i would start at 0, we'd
use get(i) to retrieve the first element.::
	
	//if dropList has 2 elements, 

	for(int i=0; i< dropList.size() ; i++){     //incorrect syntax, this causes problems
			dropList.remove(i);
	}	

The first time through, i=0, we remove the first element from the array.  Then, we increment i, so i=1.  We
still check to make sure that i < droplist.size(), and now the size() is 1.  So, we don't enter the for loop,
and we haven't actually examined the remaining element in the list.  Let's look at another way to do this.

Reverse For Loops
==================

A simple syntax change so that we go through the loop in reverse will prevent the problems from above.  
So, we need to restructure the for loop:  We'll start at the largest value:  droplist.size(),
then we'll stop once we've reached the first element and it has an index of 0.  Each time, we'll subtract 1 from i. 
If we have a list of 2 elements, size() = 2 and their indexes are 0,1.  So we want to make sure to subtract 1 from the 
starting value so our starting value is ``droplist.size( ) -1`` 
The for-loop structure is:  (initializer ; test-condition; iterator)  ::
		
		for( int i= droplist.size() -1; i > 0 ; i--){    //correct syntax, this works
		 		droplist.remove(i);     
		}
		
So, the first time through, i=2-1, so i= 1.  So we'll remove the last element in the list, so the list now has 1 element 
in position 0.  The value of i is updated by subtracting 1:  i=1-1, so i=0.  So, now when we enter the loop, we're looking
at the element at position '0'.  So we've at least looked at each of the elements, the code above removes this as well, but 
the take-away is that a reverse for-loop allows us to make sure we iterate through each element in the list.

So, if we need to change the code in our game so that we're using ArrayLists instead of Arrays, then we can
eliminate some of the book-keeping variables and simplify the code.

Paddle Drop Game using ArrayList
----------------------------------

In the Paddle Drop Game, there are 2 main sections where we need to change the code if we want to 
implement using ArrayLists instead of Arrays:
	
	1.  When we create each new Drop element as the timer isFinished()
	2.  When we loop through to move each drop, check for collision, check for the drop being finished
	
Creating Drop in drops ArrayList
---------------------------------
	
For the part where we create new drops, we still want to use random( ) so that we randomize the type of 
child drops created at each step. We had used the variable totalDrops to limit the total number of drops created
for a level, we actually still need to do that in order to know when to increase the game level. 
Below is the code where we used Arrays to hold our Drop objects in the game::

	if(timer.isFinished()){
        if(game1.totalDrops<drops.length){
            int choice = (int)random(0,2);  //  gives 0,1 vaules
            //println("choice " + choice);
            switch(choice){
                 case 0:  drops[game1.totalDrops]= new Seahorse();   //change this to ArrayList
                     break;
                 case 1:  drops[game1.totalDrops] = new Drop();     //change this to ArrayList
                     break;
               }    //end switch
              game1.totalDrops++;
            }
              timer.start();
      }  //end if
          
          
We'll now change it to use a drops ArrayList::

	if(game1.gameState==game1.ACTIVE){ // put most active game code in here
    if(drops.size() < game1.totalDrops)// totalDrops is the max # of drops per level, we never modify it
        if(timer.isFinished()){
            int choice = (int)random(0,2);  //  gives 0,1 vaules
             switch(choice){
                 case 0:  drops.add( new Seahorse());
                     break;
                 case 1:  drops.add(new Drop());
                     break;
               }    //end switch
            timer.start();
          }  //end if
         
In the above code section, we're using game1.totalDrops in a slightly different way, now it is as 
the maximum number of drops that we'll let the game create.  We never increment that value, 
but we'll use it again to check whether we need to advance the game to the next level. 

Iterating through drops ArrayList
----------------------------------
Now let's look at how we'll access a single drop and process each of the drop steps, first
let's look at how the code was written when we used arrays::

  ///loop through array and deal with each drop[i]      
         for(int i=0;i<game1.totalDrops;i++){
                if(drops[i].isActive==true){  //only look at active drops
                    boolean isHit=false;  //reset each time through for loop
                    drops[i].move();
                    isHit= drops[i].isIntersecting(paddle1);   //check to see if intersect with paddle
                        if(isHit){
                                //println("isHit");
                                drops[i].caught();
                                game1.score++;
                                game1.levelCounter++;  //count caught drop
                
                          }
                   if(drops[i].reachedBottom()){  // reached bottom without getting hit, so lose lives
                     drops[i].finished();   //set drop to be not active
                     
                     game1.dropFinished();
                     game1.levelCounter++;  //count each drop that is no longer active
                     game1.lives--;  //life is lost
                     if(game1.lives<=0){
                       game1.gameState=game1.END;   //set the game to over
                     }
                   }
                drops[i].display();
                }  //end isActive
        }//end drop[] loop     
        
        
Now we need to modify this code so that we're accessing elements from the drops ArrayList.
As mentioned above, we need to modify the for-loop so that we're going in reverse order, using
the syntax that section above.  Instead of using totalDrops as the maximum value, we need to use
the current size of the drops ArrayList.  So we'd start with rewriting the for-loop and then we need
to select a single Drop object to process, instead of using drop[i], we need to create a Drop reference 
variable to act as a pointer for each element we retrieve from the ArrayList::

		         for(int i=(drops.size()-1 ); i > 0 ; i--){
		         	Drop d = drops.get(i);
		         
		         //change all of the following code so we're using d instead of drops[i]	
		         	
		       } 
		       
Then we also need to look at the rest of the code and determine if there are areas where we are using
the drops Array, and we need to fix that code. In Shiffman's code, he used the variable ``levelCounter`` 
as a way to keep track of how many drops have been removed from the game, either due to being hit or to falling 
off the screen.  We need to re-examine this logic.  Currently we have this test to determine if we should increment
the level:  if(game1.levelCounter >= drops.length). As a first step let's compare levelCounter to totalDrops.  
	
	Goal:  Have logic to control changing levels:
	
	1.  levelCounter and totalDrops are now part of the game class, they control how many drops are created for each level
	
	2.  totalDrops is set to some max value like 30, and never changes.
	
	3.  levelCounter is incremented each time a drop is removed from the screen, either isHit or isFinished
	
	4.  drops.length was an Array instance value, it gave the fixed size of the array.
	
	5.  drops.size() is an ArrayList method that gives the current size of the ArrayList
	6.  We need to compare a changing value (levelCounter), with a fixed value:  totalDrops.  Otherwise our game will 
		continue to make and remove drops from the game forever.
	
Here is the old code version::

		// If all the drops are done, that level is over!
     
      if (game1.levelCounter >= drops.length) {
          // Go up a level
          if(game1.levelIndex<levels.length-1){
              game1.levelIndex++;
              currentLevel=levels[game1.levelIndex];
              paddle1.pWidth=currentLevel.paddleWidth;
          }
          // Reset all game elements
          game1.levelCounter = 0;
          game1.lives = 10;
          game1.totalDrops = 0; 
          timer.setTime(constrain(300-game1.levelIndex*25,0,300));
           }
           
In the new code version, we'll replace that if-condition with::

	if(game1.levelCounter >= totalDrops){ 
		// code in here 
	}

This should provide a good start for how we can change our game so that we're using
ArrayLists to hold our drops instead of using Arrays.  
           

		        
     
                       
	
	
	
	
     

	



