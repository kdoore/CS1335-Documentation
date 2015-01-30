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

Here is code for a button that shows hover states and switches the color of a rectangle::

	int rectState=5;
	int btnHover=0;
	void setup(){
		size(300,300);

		}

	void draw(){
  		background(255);
  		switch(rectState){
    		case 4: 
      			fill(200);
      			break;
    		case 5: 
      			fill(50);
      			break;
  			}
  		noStroke();
  		rect(10,10,100,100);
  		drawButton(200,40,50,50);
}

	void drawButton(float xPos,float yPos,float bWidth,float bHeight){
    	boolean hover=true;
    	boolean pressed=false;
    	boolean clicked=false;
    	fill(100);
    	stroke(20);
    	strokeWeight(3);
    	rect(xPos,yPos,bWidth,bHeight);
    	fill(200,0,0);
    	hover =mouseIsOver(xPos,yPos,bWidth,bHeight);
    	if(hover){
      		fill(255,0,0);
      		btnHover=1;
    	}
    	else{
      		btnHover=0;
    	}
    	if(mousePressed && hover){
      		fill(0,255,0);
      		stroke(200);
    	}
    	ellipse(xPos+25,yPos+25,bWidth-5,bHeight-5);
  	}
  
	boolean mouseIsOver(float xPos, float yPos, float rWidth, float rHeight){
   		if( mouseX>xPos && mouseX<(xPos+rWidth) && mouseY>yPos && mouseY <yPos+rHeight){
      		return true;
    		}
    		return false;
  	}
  
	void mouseClicked(){
  	if(btnHover==1){
    	if(rectState==4)
      		rectState=5;
    	else
      		rectState=4;
  		}
 
	}

End of code