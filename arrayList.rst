.. _arrayList:

============
ArrayList
============

An ArrayList is a `data structure` that allows us to store objects in our programs, and is
similar to Arrays in many ways.  An ArrayList can be considered a resizable array, we can
add and remove elements to an ArrayList using ArrayList methods.


Declaration
--------------
Here is how we can declare an ArrayList, we need to use a special `type` syntax to specify
what `type` of objects we'll use the ArrayList for. This syntax is a `type parameter`.  

	``ArrayList<Drop> dropList = new ArrayList<Drop>();``

For an Array, we would have specified this way:

	``Drop[] dropArray = new Drop[ 50 ];``

Notice that we use the angle brackets to specify the type of object ``<Drop>``

Initialize an Element
-----------------------

With an array, we use the array name and bracket with index value to initialize an element

	``dropArray[1]= new Drop();``

For an ArrayList we use the ``add()`` method of the ArrayList object

	``dropList.add(new Drop());
	
Access Elements
-----------------
	
ArrayList give us the ability to access items by their reference name::

	Drop drop1 = new Drop();
	
	DropList.add(drop1);
	
	int theSize=dropList.size();
	
	
	
	
	
     

	



