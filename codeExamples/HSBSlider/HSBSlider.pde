/*Program to create an interactive HSB color picker*/

//global values
float _barWidth=300.0;
float _sliderPos=100.0;  //initial slider position
float _hueVal=getHSBVal(_sliderPos,_barWidth);  //initial hueValue
 
void setup(){
  background(255);
  size(400,300);
  colorMode(HSB);
  stroke(0,0,0);
  println(_hueVal);
}

void draw(){
  _hueVal= drawSlider(20.0,20.0,_barWidth,30.0,_hueVal);
}

/* Function that draws an interactive HSB color-slider bar. 
Input is the current value of selected hue.  
Return value is the updated value of the selected hue
*/
float drawSlider(float xPos, float yPos, float bWidth, float bHeight,float hueVal){
  fill(255);
  noStroke();
  rect(xPos-5,yPos-10,bWidth+10,bHeight+20);  //draw white background behind slider
  float sliderPos=getSliderPos(hueVal,bWidth);  //find the current sliderPosition from hueVal
  
  //Create Slider background by getting sliderVal for each x position in the slider
  for(int i=0;i<bWidth;i++){  //draw 1 line for each hueValue from 0-255
      hueVal=getHSBVal(i,bWidth);  //get hueVal for each position in the bar
      stroke(hueVal,255,255);
      line(xPos+i,yPos,xPos+i,yPos+bHeight);
  }
  //if the user is moving the slider, determine the new sliderPos
  if(mousePressed && mouseX>xPos && mouseX<(xPos+bWidth) && mouseY>yPos && mouseY <yPos+bHeight){
     sliderPos=mouseX-xPos;
  }
  //determine the color of the slider indicator at the current slider position 
  stroke(100);
  hueVal=getHSBVal(sliderPos,bWidth);
  fill(hueVal,255,255);
  rect(sliderPos+xPos-3,yPos-5,6,bHeight+10);
  rect(bWidth+40, yPos, bHeight,bHeight);
  return hueVal;
}

/* function to map slider position to determine HSB value
sliderPos: current value of the slider
sliderWidth: width of slider bar
*/
float getHSBVal(float sliderPos, float sliderWidth){
  float val=map(sliderPos,0.0,sliderWidth,0.0,255.0);
  return val;
}

/* function to map slider HSB value to determine slider position
sliderPos: current value of the slider
sliderWidth: width of slider bar
*/
float getSliderPos(float val, float sliderWidth){
  float sliderPos=0.0;
  sliderPos=map(val,0.0,255.0,0.0,sliderWidth);
  return sliderPos;
}
