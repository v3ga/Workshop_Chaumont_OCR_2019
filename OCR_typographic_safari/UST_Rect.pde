// ========================================================================
class UST_Rect extends Rect
{
  UST_Photo parent;
  float margin = 10;

  // ----------------------------------------------
  UST_Rect(UST_Photo parent, JSONObject poly)
  {
    this.parent = parent;
    this.setFromBoundingPoly(poly);
  }

  // ----------------------------------------------
  void setFromBoundingPoly(JSONObject poly)
  {
    JSONArray jsonVertices = poly.getJSONArray("vertices");    
    for (int i=0; i<jsonVertices.size(); i++)
    {
      JSONObject vertex = jsonVertices.getJSONObject(i);
      int x = vertex.getInt("x");
      int y = vertex.getInt("y");
      if (i == 0)
      {
        xMin = x; 
        yMin = y;
        xMax = x; 
        yMax = y;
      } else
      {
        if (x < xMin) xMin = x;
        else if (x > xMax) xMax = x;
        if (y < yMin) yMin = y;
        else if (y > yMax) yMax = y;
      }

      w = xMax - xMin;
      h = yMax - yMin;
    }
  }

  // ----------------------------------------------
  void draw()
  {
    pushStyle();
    noFill();
    strokeWeight(2);
    stroke(0, 0, 255);
    rect(xMin, yMin, w, h);
    popStyle();
  }

  // ----------------------------------------------
  void drawIn(Rect r)
  {
  }
  
  // ----------------------------------------------
  void saveAsImage()
  {
  }
}

// ========================================================================
class UST_Rect_Text extends UST_Rect
{
  String text = "";
  boolean bDrawText = false;

  // ----------------------------------------------
  UST_Rect_Text(UST_Photo parent, String text, JSONObject poly)
  {
    super(parent, poly);
    this.text = text;
  }

  // ----------------------------------------------
  void draw()
  {
    super.draw();
    if (bDrawText)
    {
      pushStyle();
      fill(0, 0, 255);
      text(this.text, xMin, yMin-4);    
      popStyle();
    }
  }

  // ----------------------------------------------
  void drawIn(Rect r)
  {
    this.drawIn(r.xMin, r.yMin, r.w, r.h);
  }

  // ----------------------------------------------
  void drawIn(float xRect, float yRect, float wRect, float hRect)
  {
    if (this.parent.img != null)
    {
      float xr = this.parent.xImg + this.xMin / float(this.parent.img.width)*this.parent.wImg;
      float yr = this.parent.yImg + this.yMin / float(this.parent.img.height)*this.parent.hImg;
      float wr = this.w / float(this.parent.img.width) * this.parent.wImg;
      float hr = this.h / float(this.parent.img.height) * this.parent.hImg;

      pushStyle();
      noFill();
      strokeWeight(2);
      stroke(UST_COLOR_GREEN);
      rect(xr, yr, wr, hr);
      popStyle();
    }
  }

  // ----------------------------------------------
  void saveAsImage()
  {
    if (parent.img != null)
    {
      float xmMin = max(xMin-margin, 0);      
      float ymMin = max(yMin-margin, 0);      
      float xmMax = min(xMax+margin, parent.img.width);      
      float ymMax = min(yMax+margin, parent.img.height);      
      float wm = xmMax - xmMin;
      float hm = ymMax - ymMin;

      PGraphics pg = createGraphics((int)wm, (int)hm);
      pg.beginDraw();
      pg.image(parent.img, -xmMin, -ymMin);
      pg.endDraw();
      pg.save(pathTextAnnotation+"vignettes/"+parent.name+"_"+this.text+".jpg");
    }
  }
}
