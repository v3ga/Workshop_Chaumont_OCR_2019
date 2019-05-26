import processing.pdf.*;
import java.util.Calendar;

boolean bStartRecord = true;
boolean bStopRecord = true;
PShape letterForm;
boolean bMousePressed = false;
PVector mouse = new PVector();

// ------------------------------------------------------------------------------------
float letterWidth = 400.0; // Change the width of the letter
float letterHeight = 0;
String letterName = "29bis.svg";
float angleRotation = 0;
float distance = 8; // try change this
float freq = 1 ; // try change this like 6 or 2 or 5


// key E : begin exports
// key S : stop exports
// ------------------------------------------------------------------------------------


void setup()
{
  size (640, 900);
  letterForm = loadShape(letterName);
  println(letterForm.width);
  println(letterForm.height);
  letterHeight = letterWidth / ( letterForm.width/ letterForm.height );
}

void draw()
{
  if (bStartRecord)
  {
    beginRecord(PDF, "exports/"+timestamp()+"_export.pdf");
    bStartRecord = false;
  }

  if (letterForm != null)
  {
    /*    if (mousePressed)
     {
     // rotate( map( mouseY-height/2,-height/2,height/2,-PI/5,PI/5 ) );
     if (dist(mouse.x, mouse.y, mouseX, mouseY)>distance)
     {
     translate(mouse.x-letterWidth/2, mouse.y-letterHeight/2);
     rotate( radians(angleRotation) );
     shape(letterForm, 0,0, letterWidth,letterHeight);
     mouse.x = mouseX;
     mouse.y = mouseY;
     }}
     */
    for (float y=0; y<height-40; y+=distance)
    {
      float x = width/2+sin(map(y, 0, height-40, 0, freq*TWO_PI))*width/2*0.3 ;    
      pushMatrix();
      translate(x-letterWidth/2, y-letterHeight);
      rotate( radians(angleRotation) );
      shape(letterForm, 0, 0, letterWidth, letterHeight);
      popMatrix();
  }
  }
  /*} else
   {
   if (mousePressed)
   ellipse(mouseX, mouseY, 100, 100);
   */
  if (bStopRecord)
  {
    endRecord();
    bStopRecord = false;
  }
}



void mousePressed()
{
  mouse.set(mouseX, mouseY);
}

void keyPressed()
{
  if (key == 'e')
  {
    bStartRecord = true;
  } else if (key == 's')
  {
    bStopRecord = true;
  }
}

// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
