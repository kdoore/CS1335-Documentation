.. _buttons:

================
Button States
================

In this project, we'll look at button states like hover, pressed, and clicked, as well as how buttons can be used to provide users with control over states of other elements of our programs.


In the code below, we create a very simple program with 2 rectangles::

	int state=1;

	void setup(){
		size(300,300);
	}

	void draw(){
	  	background(255);
	  	switch(state){
	    	case 1: 
	     		fill(200);
	     		break;
	    	case 2: 
	    		fill(100);
	    		break;
	  }
		rect(10,10,100,100);
		drawButton();
	}

 	void drawButton(){
    	fill(100);
    	stroke(20);
    	strokeWeight(3);
    	rect(200,40,50,50);
    	fill(255,0,0);
    	ellipse(200+25,40+25,25,25);
		
  		}


	
The switch statement provides a variation on the conditional branching structure, we could use if(), else(), but for some situations, switch provides a cleaner, simpler structure.


End of code for this section

