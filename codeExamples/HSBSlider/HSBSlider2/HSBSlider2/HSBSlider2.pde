//global values

float _barWidth=300.0;    //slider-bar width;
float _hueVal=_barWidth/2;  //initial hueValue global value
  
void setup(){
  background(255);
  size(400,400);
  colorMode(HSB);
  stroke(0,0,0);
}

void draw(){
  _hueVal= drawSlider(20.0,300.0,_barWidth,30.0,_hueVal); 
 fill(_hueVal,255,255);  //use the new _hueValue to set fill for drawing canvas object
 rect(10,10,100,50);  // verify color changes when slider is moved
}

float drawSlider(float xPos, float yPos, float sWidth, float sHeight,float hueVal){
  fill(255);
  noStroke();
  rect(xPos-5,yPos-10,sWidth+10,sHeight+20);  //draw white background behind slider
  
  float sliderPos=map(hueVal,0.0,255.0,0.0,sWidth); //find the current sliderPosition from hueVal
  
  for(int i=0;i<sWidth;i++){  //draw 1 line for each hueValue from 0-255
      float hueValue=map(i,0.0,sWidth,0.0,255.0);  //get hueVal for each i position //local variable
      stroke(hueValue,255,255);
      line(xPos+i,yPos,xPos+i,yPos+sHeight);
  }
  if(mousePressed && mouseX>xPos && mouseX<(xPos+sWidth) && mouseY>yPos && mouseY <yPos+sHeight){
     sliderPos=mouseX-xPos;
     hueVal=map(sliderPos,0.0,sWidth,0.0,255.0);  // get new hueVal based on moved slider
  }
  stroke(100);
  fill(hueVal,255,255);  //either new or old hueVal 
  rect(sliderPos+xPos-3,yPos-5,6,sHeight+10);  //this is our slider indicator that moves
  rect(sWidth+40, yPos, sHeight,sHeight); // this rectangle displays the changing color to the right side
  return hueVal;
}


