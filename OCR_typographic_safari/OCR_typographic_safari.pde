// ----------------------------------------------
// OCR - A typographic Safari
//
// Liens
// https://cloud.google.com/vision/
// https://cloud.google.com/vision/docs/reference/rest/v1/images/annotate

// ----------------------------------------------
import java.util.*;
import processing.svg.*;
import treemap.*;

// ----------------------------------------------
//String user = "Cite_numérique";
String user = "Chaumont dimanche soir";

// ----------------------------------------------
String pathUser = "Data/OCR/"+user+"/";
String pathImages = pathUser+"Photos/";
String pathTextAnnotation = pathUser+"TextAnnotations/";
String pathDb = pathUser+"Db/";

// ----------------------------------------------
color UST_COLOR_PURPLE = #FC28FC;
color UST_COLOR_GREEN = #42FD2F;
color UST_COLOR_BLUE = #071AC8;
color UST_COLOR_YELLOW = #FFFF00;

// ----------------------------------------------
ArrayList<PFont> fonts = new ArrayList<PFont>();
PFont fontCurrent;

// ----------------------------------------------
UST_Photo photo;
UST_DirPhoto dirPhoto;
Rect rectPhoto, rectInfos, rectColors;
int indexPhoto = -1;

boolean bDrawTextAnnotations = true;
boolean __DEBUG__ = false;


// ----------------------------------------------
void setup()
{
  size(1300, 768);
  frame.setTitle("OCR — Un safari typographique — Chaumont 2019 / "+user);
  loadFonts();

  rectPhoto = new Rect(0.25*float(width)+2, 0.15*float(height), 0.75*float(width)-2*2, 0.75*float(height));
  rectInfos = new Rect(0, 0, 0.25*float(width), float(height));

  dirPhoto = new UST_DirPhoto(pathUser);
  dirPhoto.saveInfos();

  setPhoto(0);
}

// ----------------------------------------------
void draw()
{
  background(UST_COLOR_BLUE);

  // Image
  dirPhoto.drawPhotoImage(indexPhoto, rectPhoto);

  // Text annotations
  if (bDrawTextAnnotations)
  {
    dirPhoto.drawPhotoTextAnnotations(indexPhoto, rectPhoto);
    dirPhoto.drawPhotoWords(indexPhoto, rectInfos);
  }

  // Dominant colors
  rectColors = dirPhoto.getRectColors(indexPhoto, 5.0);
  if (rectColors != null)
    dirPhoto.drawPhotoColors(indexPhoto, rectColors, 15.0);

  // Debug
  drawDebug();
}

// ----------------------------------------------
void keyPressed()
{
  if (key == CODED)
  {
    if (keyCode == RIGHT) { 
      drawNextPhoto();
    } else if (keyCode == LEFT) {
      drawPreviousPhoto();
    }
  } else
  {
    if (key == '+')
    {
      int indexFont = (fonts.indexOf(fontCurrent)+1)%fonts.size();
      fontCurrent = fonts.get(indexFont);
    } else if (key == '-')
    {
      int indexFont = fonts.indexOf(fontCurrent)-1;
      if (indexFont < 0) indexFont = fonts.size()-1;
      fontCurrent = fonts.get(indexFont);
    } else if (key == 's')
    {
      dirPhoto.saveTextAnnotationsVignettes();
      dirPhoto.saveTextAnnotationsSVG();
    }
  }
}

// ----------------------------------------------
void setPhoto(int index)
{
  if (index != indexPhoto)
  {
    indexPhoto = index;
    dirPhoto.loadPhotoImg(indexPhoto);
  }
}

// ----------------------------------------------
void drawNextPhoto()
{
  setPhoto( (indexPhoto+1)%dirPhoto.photos.size() );
}

// ----------------------------------------------
void drawPreviousPhoto()
{
  int index = indexPhoto-1;
  if (index < 0) index = dirPhoto.photos.size()-1;
  setPhoto(index);
}

// ----------------------------------------------
void drawDebug()
{
  if (__DEBUG__)
  {
    rectPhoto.draw(UST_COLOR_YELLOW);
  }
}

// ----------------------------------------------
void loadFonts()
{
  fonts.add( loadFont("Assets/Fonts/Monaco-10.vlw") );
  fonts.add( loadFont("Assets/Fonts/Monaco-12.vlw") );
  fonts.add( loadFont("Assets/Fonts/Monaco-14.vlw") );
  fonts.add( loadFont("Assets/Fonts/Monaco-16.vlw") );

  fontCurrent = fonts.get(1);
}
