class UST_DirPhoto
{
  ArrayList<UST_Photo> photos;
  HashMap<String, UST_Word> words;
  List<UST_Word> wordsByCount;
  String textPhotos;

  // ----------------------------------------------
  UST_DirPhoto(String pathUser)
  {
    println("dir user = "+pathUser);

    // Create the photo list + text photos
    photos = new ArrayList<UST_Photo>();
    File[] filesAll = listFiles(sketchPath(pathImages));
    for (int i=0; i<filesAll.length; i++) 
      if (filesAll[i].isDirectory() == false && !filesAll[i].getName().equals(".DS_Store") ) 
      {
        String name = getBaseName( filesAll[i].getName() );
        if (name.substring(0, 1).equals(".") == false)
        {
          UST_Photo photo = new UST_Photo(name);
          photos.add(photo);
          textPhotos += photo.getTextAnnotationDescription(0);
        }
      }

    // Create an hashmap of words
    words = new HashMap();
    for (UST_Photo photo : photos)
    {
      for (int i=1; i<photo.textAnnotations.size(); i++)
      {
        this.addWord( photo.getTextAnnotationDescription(i).toLowerCase() );
      }
    }

    wordsByCount = new ArrayList<UST_Word>(words.values());
    Collections.sort(wordsByCount, new Comparator<UST_Word>() 
    {
      @Override
        public int compare(UST_Word A, UST_Word B)
      {
        if (A.count < B.count)
        return 1;
        else if (A.count > B.count)
        return -1;
        return 0;
      }
    }
    );
  }

  // ----------------------------------------------
  void addWord(String s)
  {
    if (s.equals("")) 
      return;

    UST_Word word = words.get(s);
    if (word == null)
    {
      word = new UST_Word(s);
      words.put(s, word);
    }
    word.incrementCount();
  }

  // ----------------------------------------------
  int getTextAnnotationsSize()
  {
    int size = 0;
    for (UST_Photo photo : photos)
      size+=photo.getTextAnnotationsSize();
    return size;
  }

  // ----------------------------------------------
  String getTextAnnotationDescription()
  {
    String s="";
    for (UST_Photo photo : photos)
    {
      s+=photo.getTextAnnotationDescriptionAll(true, " ")+"\n";
    }
    return s;
  }

  // ----------------------------------------------
  void saveInfos()
  {
    String s = user+"\n";
    s += "------------------------------------------------\n";
    s += "-- Nombre d'annotations : "+getTextAnnotationsSize()+"\n";
    s += "-- Annotations : \n"+getTextAnnotationDescription();
    s += "-- Statistiques annotations : \n" + getAnnotationsStatistics("\n");
    s += "\n";
    for (UST_Photo photo : photos)
    {
      s += photo + "\n\n";
    }

    saveStrings(pathUser+user+".txt", new String[]{getTextAnnotationDescription()});
    saveStrings(pathUser+user+"_synthese.txt", new String[]{s});
  }

  // ----------------------------------------------
  void saveTextAnnotationsVignettes()
  {

    for (UST_Photo photo : photos)
      photo.makeTextAnnotationsVignettes();
  }

  // ----------------------------------------------
  void saveTextAnnotationsSVGFor(int index)
  {
    UST_Photo photo = photos.get(index);
    if (photo != null)
    {
      photo.makeTextAnnotationsSVG();
    }
  }

  // ----------------------------------------------
  void saveTextAnnotationsSVG()
  {
    for (UST_Photo photo : photos)
      photo.makeTextAnnotationsSVG();
  }

  // ----------------------------------------------
  String getAnnotationsStatistics(String separator)
  {
    String s ="";
    String sep="";
    /*
for (Map.Entry wordEntry : words.entrySet()) 
     {
     UST_Word word = (UST_Word) wordEntry.getValue();
     s+= sep+wordEntry.getKey() + " ("+ word.count +")";
     sep = separator;
     }
     */
    for (UST_Word word : wordsByCount)
    {
      s+= sep+word.string + " ("+ word.count +")";
      sep = separator;
    }

    return s;
  }


  // ----------------------------------------------
  void drawPhotoImage(int index, Rect r)
  {
    this.drawPhotoImage(index, r.xMin, r.yMin, r.w, r.h);
  }

  // ----------------------------------------------
  void drawPhotoImage(int index, float x, float y, float w, float h)
  {
    UST_Photo photo = photos.get(index);
    if (photo != null)
    {
      photo.drawIn(x, y, w, h);
    }
  }

  // ----------------------------------------------
  void drawPhotoTextAnnotations(int index, Rect r)
  {
    UST_Photo photo = photos.get(index);
    if (photo != null)
    {
      photo.drawTextAnnotations(r);
    }
  }

  // ----------------------------------------------
  void unloadPhotoImg(int index)
  {
    if (index < 0) return;
    UST_Photo photo = photos.get(index);
    if (photo != null)
      photo.img = null;
  }

  // ----------------------------------------------
  void loadPhotoImg(int index)
  {
    UST_Photo photo = photos.get(index);
    if (photo != null)
      photo.loadImg();
  }

  // ----------------------------------------------
  void drawPhotoWords(int index, Rect r)
  {
    String underline="--------------------------------\n";
    //    String s = "# statistiques annotations : \n" + underline + getAnnotationsStatistics(" / ") + "\n\n";
    String s = "";
    UST_Photo photo = photos.get(index);
    if (photo != null)
    {
      s += "# " + photo.getTextAnnotationsSize() + " text annotations :\n"+underline+"\n";
      s += photo.getTextAnnotationDescriptionAll(true, "\n");
    }

    pushStyle();
    fill(UST_COLOR_GREEN);
    textFont(fontCurrent);
    float y = 5+textAscent();
    text(s, 5, y, r.w-5, r.h);
    popStyle();

    /*
    UST_Photo photo = photos.get(index);
     if (photo != null)
     {
     photo.drawWords(r);
     }
     */
  }


  // ----------------------------------------------
  Rect getRectColors(int index, float size)
  {
    UST_Photo photo = photos.get(index);
    Rect rect = new Rect();
    if (photo != null)
    {
      rect.set(photo.xImg-1, photo.yImg+photo.hImg+2, photo.wImg, size);
    }
    return rect;
  }

  // ----------------------------------------------
  void drawPhotoColors(int index, Rect r, float size)
  {
    UST_Photo photo = photos.get(index);
    if (photo != null)
    {
      photo.drawColors(r, size);
    }
  }
}
