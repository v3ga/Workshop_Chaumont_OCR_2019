class UST_Photo
{
  String name = "";
  String pathJson = "";
  String pathImg = "";

  String strOrientation = "";

  PImage img;
  JSONObject json;
  JSONArray textAnnotations;
  ArrayList<UST_Rect_Text> listRecttextAnnotations = new ArrayList();

  JSONArray colors;
  ArrayList<UST_Couleur> listColors = new ArrayList();

  float xImg, yImg, wImg, hImg;

  // ----------------------------------------------
  UST_Photo(String name)
  {
    this.name = name;
    this.pathJson = pathDb+name+".json";
    this.pathImg = pathImages+name+ext;

    println("Photo "+name);
    println("  > "+this.pathJson);
    println("  > "+this.pathImg + " — "+sketchPath(this.pathImg));


    this.readMetadata();
    json = loadJSONObject(this.pathJson);

    // Text annotation
    textAnnotations = json.getJSONArray("textAnnotations");
    println("  > text annotations length="+textAnnotations.size());
    String mots = "";
    String sep = "";
    for (int i=0; i<textAnnotations.size(); i++)
    {
      JSONObject ta = textAnnotations.getJSONObject(i);
      UST_Rect_Text taRect = new UST_Rect_Text(this, ta.getString("description"), ta.getJSONObject("boundingPoly"));
      listRecttextAnnotations.add( taRect );
      if (i > 0)
      {
        mots += sep + ta.getString("description").toLowerCase();
        sep = " / ";
      }
    }
    println("  > mots = "+mots);    

    // Couleurs
    this.colors = json.getJSONObject("imagePropertiesAnnotation").getJSONObject("dominantColors").getJSONArray("colors");
    println("  > colors = "+colors.size());    
    for (int i=0; i<colors.size(); i++)
    {
      listColors.add( new UST_Couleur(this, this.colors.getJSONObject(i) ) );
    }
  }

  // ----------------------------------------------
  void readMetadata()
  {
    File f = new File( sketchPath(this.pathImg) );
    try 
    {
      Metadata metadata = JpegMetadataReader.readMetadata(f);
      for (Directory directory : metadata.getDirectories()) 
      {
        for (Tag tag : directory.getTags()) 
        {
          if (tag.getDirectoryName().equals("Exif IFD0"))
          {
            if (tag.getTagName().equals("Orientation"))
            {
              strOrientation = tag.getDescription();
//              System.out.println(tag);
            }
          }
        }
      }
    }

    catch (JpegProcessingException e) {
      print(e);
    } 
    catch (Exception e) {
      print(e);
    }
  }

  // ----------------------------------------------
  int getTextAnnotationsSize()
  {
    return textAnnotations.size()-1;
  }

  // ----------------------------------------------
  String getTextAnnotationDescriptionAll(boolean inline, String separator)
  {
    String s = "";
    if (inline == false)
    {
      s = getTextAnnotationDescription(0);
    } else
    {
      String sep="";
      for (int i=1; i<textAnnotations.size(); i++)
      {
        s += sep+getTextAnnotationDescription(i);      
        sep = separator;
      }
    }
    return s;
  }

  // ----------------------------------------------
  String getTextAnnotationDescription(int index)
  {
    JSONObject ta = getTextAnnotation(index);
    if (ta != null)
    {
      return ta.getString("description");
    }
    return "";
  }

  // ----------------------------------------------
  JSONObject getTextAnnotation(int index)
  {
    if (index < textAnnotations.size())
      return textAnnotations.getJSONObject(index);
    return null;
  }

  // ----------------------------------------------
  void loadImg()
  {
    if (img == null)
      img = loadImage(pathImg);
  }

  // ----------------------------------------------
  void makeTextAnnotationsSVG()
  {
    loadImg();
    if (this.img != null)
    {
      background(255);
      beginRecord(SVG, pathTextAnnotation+"svg/"+name+".svg");
      drawTextAnnotations( new Rect(0, 0, img.width, img.height) );
      endRecord();
    }
  }

  // ----------------------------------------------
  void makeTextAnnotationsVignettes()
  {
    loadImg();
    for (UST_Rect rect : listRecttextAnnotations)
      rect.saveAsImage();
  }

  // ----------------------------------------------
  void drawIn(float x, float y, float w, float h)
  {
    loadImg();
    if (img != null)
    {
      float rImage = float(this.img.width) / float(this.img.height);
      float rCanvas = w / h;

      // Canvas paysage
      if (rCanvas >= 1)
      {
        if (rImage >= 1)
        {
          this.wImg = w;
          this.hImg = this.wImg / rImage;
          this.xImg = x;
          this.yImg = y + (h-hImg)/2;
        } else
        {
          this.hImg = h;
          this.wImg = this.hImg * rImage;
          this.xImg = x+(w - wImg)/2;
          this.yImg = y;
        }
      } else
      {
      }

      pushMatrix();
      translate(xImg, yImg);

      // Image
      image(img, 0, 0, wImg, hImg);

      // Cadre
      pushStyle();
      strokeWeight(4);
      noFill();
      stroke(UST_COLOR_PURPLE);
      rect(0, 0, wImg, hImg);

      // Vignette + texte
      float padding = 5;
      float wName = textWidth(name);
      float hName = textAscent() + textDescent();
      float wRect = wName + 2*padding;
      float hRect = hName + 2*padding;
      translate(-1, -hRect);
      fill(UST_COLOR_PURPLE);
      noStroke();
      rect(0, 0, wRect, hRect);
      fill(UST_COLOR_BLUE);
      textFont(fontCurrent);
      textSize(16);
      translate(padding, padding+textAscent());
      text(name, 0, 0);

      popStyle();
      popMatrix();
    }
  }


  // ----------------------------------------------
  void draw()
  {
    if (img != null)
    {
      image(img, 0, 0);
      for (UST_Rect rect : listRecttextAnnotations)
        rect.draw();
    }
  }

  // ----------------------------------------------
  void drawTextAnnotations(Rect r)
  {
    for (UST_Rect rect : listRecttextAnnotations)
      rect.drawIn(r);
  }  

  // ----------------------------------------------
  void drawWords(Rect r)
  {
    String s = "# " + getTextAnnotationsSize() + " text annotations :\n\n";
    s+=getTextAnnotationDescriptionAll(true, "\n");
    pushStyle();
    fill(UST_COLOR_GREEN);
    textFont(fontCurrent);
    float y = 5+textAscent();
    text(s, 5, y);
    popStyle();
  }

  // ----------------------------------------------
  void drawColors(Rect r, float size)
  {
    pushStyle();
    noStroke();
    pushMatrix();
    translate(r.xMin, r.yMin);
    float x = 0;
    for (UST_Couleur couleur : listColors)
    {
      fill(couleur.c);
      rect(x, 0.0, size, size);
      x+=size;
    }
    /*
    int nbRows =  listColors.size() / nbPerRow + ( listColors.size() %  nbPerRow > 0 ? 1 : 0);
     float size = r.w / nbPerRow;
     float y = 0;
     int indexColor = 0;
     for (int j=0; j<nbRows; j++)
     {
     float x = 0;
     for (int i=0;i<nbPerRow;i++)
     {
     UST_Couleur couleur = listColors.get(indexColor);
     fill(couleur.c);
     rect(r.xMin+x,r.yMin+y,size,size);
     x+=size;
     indexColor++;
     if (indexColor == listColors.size())
     break;
     }
     
     y += size;
     }
     */
    popMatrix();
    popStyle();
  }

  // ----------------------------------------------
  String toString()
  {
    String s = "---- Photo "+name+"\n";
    s += "-- Annotations : \n"+getTextAnnotationDescriptionAll(true, " ")+"\n";

    s += "-- Couleurs : \n";
    String sep="";
    for (UST_Couleur c : listColors)
    {
      s += sep+c; 
      sep = "\n";
    }

    return s;
  }
};
