class Rect
{
  float xMin = 0, xMax = 0;
  float yMin = 0, yMax = 0;
  float w = 0;
  float h = 0;

  // ----------------------------------------------
  Rect()
  {}

  // ----------------------------------------------
  Rect(float xMin, float yMin, float w, float h)
  {
    this.set(xMin, yMin, w, h);
  }
  
  // ----------------------------------------------
  void set(float xMin, float yMin, float w, float h)
  {
    this.xMin = xMin;
    this.yMin = yMin;
    this.w = w;
    this.h = h;
    
    this.xMax = this.xMin + this.w;
    this.yMax = this.yMin + this.h;
  }
  
  // ----------------------------------------------
  void draw(color c)
  {
    pushStyle();
    noFill();
    stroke(c);
    rect(xMin,yMin,w,h);
    popStyle();
  }
  
}


// https://www.processing.org/examples/directorylist.html
// ----------------------------------------------
String[] listFileNames(String dir) 
{
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    // If it's not a directory
    return null;
  }
}

// ----------------------------------------------
File[] listFiles(String dir) 
{
  File file = new File(dir);
  if (file.isDirectory()) {
    File[] files = file.listFiles();
    return files;
  } else {
    // If it's not a directory
    return null;
  }
}

// ----------------------------------------------
String getBaseName(String fileName) 
{
  int index = fileName.lastIndexOf('.');
  if (index == -1) {
    return fileName;
  } else {
    return fileName.substring(0, index);
  }
}
