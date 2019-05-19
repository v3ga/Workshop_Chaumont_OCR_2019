class UST_Word
{
  ArrayList<UST_Photo>  photos;
  String                string;
  int                   count;

  UST_Word(String word)
  {
    this.photos = new ArrayList<UST_Photo>();
    this.string = word;
    this.count = 0;
  }

  void incrementCount()
  {
    this.count++;
  }
}
