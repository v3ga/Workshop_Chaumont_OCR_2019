// ----------------------------------------------
// OCR - A typographic safari
// 19 to 26 may 2019 @ Le Signe, Chaumont, France.
// Julien Gachadoat (www.2roqs.com / www.v3ga.net) & Benjamin Ribeau (www.kubik.fr)
// 
// Links
//
// https://github.com/v3ga/Workshop_Chaumont_OCR_2019
//
// https://cloud.google.com/vision/
// https://cloud.google.com/vision/docs/reference/rest/v1/images/annotate

// ----------------------------------------------
import java.util.*;
import processing.svg.*;
import com.drew.imaging.*;
import com.drew.metadata.*;

// ----------------------------------------------
// TODO : change this
String user = "Pauline";
String ext = ".jpg";

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
  size(1024, 768);
  surface.setTitle("OCR — a typographic safari — Chaumont 2019 / "+user);
  loadFonts();

  rectPhoto = new Rect(0.35*float(width)+2, 0.15*float(height), 0.65*float(width)-2*2, 0.75*float(height));
  rectInfos = new Rect(0, 0, 0.35*float(width), float(height));

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

/*
UST_Photo photo = dirPhoto.photos.get(indexPhoto);
  if (photo !=null)
  {
    fill(255,0,0);
    text(photo.strOrientation,width-200,20);
  }
*/

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
    }
    else if (key == 's')
    {
//      dirPhoto.saveTextAnnotationsVignettes();
//      dirPhoto.saveTextAnnotationsSVG();
        dirPhoto.saveTextAnnotationsSVGFor(indexPhoto);

    }
  }
}

// ----------------------------------------------
void setPhoto(int index)
{
  if (index != indexPhoto)
  {
    dirPhoto.unloadPhotoImg(indexPhoto);
    
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
