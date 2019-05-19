class UST_Couleur
{
  UST_Photo photo;
  color c = 0;
  float score = 0.0;
  float pixelFraction = 0.0;

  UST_Couleur(UST_Photo photo, JSONObject json)
  {
    JSONObject jsonColor = json.getJSONObject("color");
    this.photo = photo;
    this.c = color( jsonColor.getInt("red"), jsonColor.getInt("green"), jsonColor.getInt("blue") );
    this.score = json.getFloat("score");
    this.pixelFraction = json.getFloat("pixelFraction");
  }

  String toHex()
  {
    return "#"+hex(c,6);
  }

  String toString()
  {
    String s = "";
    s = toHex() + " (score = " + this.score+", pixelFraction="+this.pixelFraction+")";    
    return s;
  }
}
