import processing.pdf.*;
import java.util.Calendar;

boolean bStartRecord = false;
boolean bStopRecord = false;
PShape letterForm;


// ------------------------------------------------------------------------------------
float letterWidth = 100.0; // Change the width of the letter
float letterHeight = 0;
String letterName = "2.svg";
float angleRotation = 0;

// key E : begin exports
// key S : stop exports
// ------------------------------------------------------------------------------------


void setup()
{
  size (900, 1200);
  letterForm = loadShape(letterName);
  println(letterForm.width);
  println(letterForm.height);
  letterHeight = letterWidth / ( letterForm.width/ letterForm.height );
}

void draw()
{
  if (bStartRecord)
  {
    beginRecord(PDF,"exports/"+timestamp()+"_export.pdf");
    bStartRecord = false;
  }
  
  if (letterForm != null)
  {
    if (mousePressed)
    {
      translate(mouseX-letterWidth/2, mouseY-letterHeight/2);
      // rotate( map( mouseY-height/2,-height/2,height/2,-PI/5,PI/5 ) );
      rotate( radians(angleRotation) );
      shape(letterForm, 0,0, letterWidth,letterHeight);
    }
  } else
  {
    if (mousePressed)
      ellipse(mouseX, mouseY, 100, 100);
  }
  
  if (bStopRecord)
  {
    endRecord();
    bStopRecord = false;
  }
}

void keyPressed()
{
  if (key == 'e')
  {
    bStartRecord = true;
  }
  else if (key == 's')
  {
    bStopRecord = true;
  }
}

// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
