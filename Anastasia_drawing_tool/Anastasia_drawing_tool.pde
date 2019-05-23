import processing.pdf.*;
import java.util.Calendar;

boolean bStartRecord = false;
boolean bStopRecord = false;
PShape letterForm;


// ------------------------------------------------------------------------------------
float letterWidth = 50.0; // Change the width of the letter
float letterHeight = 0;
String letterName = "letters/1.svg";
float angleRotation = 0;

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
  if (key == '1')
  {
    letterName="letters/1.svg";
    letterForm = loadShape(letterName);
  }
  else if (key == '2')
  {
    letterName="letters/2.svg";
    letterForm = loadShape(letterName);
  }
  else if (key == '3')
  {
    letterName="letters/3.svg";
    letterForm = loadShape(letterName);
  }
  else if (key == '4')
  {
//    letterName="letters/4.svg";
//    letterForm = loadShape(letterName);
  }
  else if (key == '5')
  {
    letterName="letters/5.svg";
    letterForm = loadShape(letterName);
  }
  else if (key == '6')
  {
    letterName="letters/6.svg";
    letterForm = loadShape(letterName);
  }
  else if (key == '7')
  {
    letterName="letters/7.svg";
    letterForm = loadShape(letterName);
  }
  else if (key == '8')
  {
    letterName="letters/8.svg";
    letterForm = loadShape(letterName);
  }
  else if (key == '9')
  {
    letterName="letters/9.svg";
    letterForm = loadShape(letterName);
  }
  else if (key == 'a')
  {
    letterName="letters/10.svg";
    letterForm = loadShape(letterName);
  }
  else if (key == 'b')
  {
    letterName="letters/11.svg";
    letterForm = loadShape(letterName);
  }
  else if (key == 'c')
  {
    letterName="letters/12.svg";
    letterForm = loadShape(letterName);
  }
  else if (key == 'd')
  {
    letterName="letters/13.svg";
    letterForm = loadShape(letterName);
  }
  else if (key == 'e')
  {
    letterName="letters/14.svg";
    letterForm = loadShape(letterName);
  }
  else if (key == 'f')
  {
    letterName="letters/15.svg";
    letterForm = loadShape(letterName);
  }
  else if (key == 'g')
  {
    letterName="letters/7.svg";
    letterForm = loadShape(letterName);
  }
  else if (key == 'h')
  {
    letterName="letters/16.svg";
    letterForm = loadShape(letterName);
  }
  else if (key == 'i')
  {
    letterName="letters/17.svg";
    letterForm = loadShape(letterName);
  }
  else if (key == 'j')
  {
    letterName="letters/18.svg";
    letterForm = loadShape(letterName);
  }
  else if (key == 'k')
  {
    letterName="letters/19.svg";
    letterForm = loadShape(letterName);
  }
  else if (key == 'l')
  {
    letterName="letters/20.svg";
    letterForm = loadShape(letterName);
  }
  else if (key == 'm')
  {
    letterName="letters/21.svg";
    letterForm = loadShape(letterName);
  }
  else if (key == 'n')
  {
    letterName="letters/22.svg";
    letterForm = loadShape(letterName);
  }
  else if (key == 'o')
  {
    letterName="letters/23.svg";
    letterForm = loadShape(letterName);
  }
  else if (key == 'p')
  {
    letterName="letters/24.svg";
    letterForm = loadShape(letterName);
  }
  else if (key == 'q')
  {
    letterName="letters/25.svg";
    letterForm = loadShape(letterName);
  }
  else if (key == 'r')
  {
    letterName="letters/26.svg";
    letterForm = loadShape(letterName);
  }
  else if (key == 's')
  {
    letterName="letters/27.svg";
    letterForm = loadShape(letterName);
  }
}

// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
