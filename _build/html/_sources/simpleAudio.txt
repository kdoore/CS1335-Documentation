.. _simpleAudio:

=============
Simple Audio
=============

The Minim library in processing can be used to add sound to programs.  Look in the processing 
examples from the edit menu.  Then go to the Minim Library and select the example: PlayAFile.  
The code in this project will play a .mp3 audio fole that is contained in the data folder 
in your sketch folder.  

Below is an extremely simple code example demonstrating how to create a sound based on 
whether the user's mouse is pressed and is on the red ellipse.::

	//Main project code
	///you must include the sound file in a data folder inside your sketch folder

	//import the Mimin library
	import ddf.minim.*;

	//declare minim object and AudiPlayer objects

	Minim minim;
	AudioPlayer sound_hit;


	void setup(){
	  size(300,300);
	  //you must call the Minim constructor so it can find the audio file in the data folder
	   minim=new Minim(this);  //pass a reference to the current 'sketch' to the constructor
	   sound_hit= minim.loadFile("missile.mp3"); 
	}

	void draw(){
	  background(255);
	  fill(255,0,0);
	  ellipse(width/2,height/2,40,40);
	  if(mousePressed && mouseX < (width/2+20) && mouseX >(width/2-20) && mouseY <(height/2+20) && mouseY > (height/2-20)){
			///rewind and play each time through the draw loop if mousePressed is true
			sound_hit.rewind();
			sound_hit.play();
		}
   
	}  



Here is a link to a zip file of the code so you can see how to create a data folder to hold
your mp3 file.

https://utdallas.box.com/simpleAudio

