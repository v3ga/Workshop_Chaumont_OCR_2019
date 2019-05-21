String sentence = "";
  String[] lieu = {
    "ici", "terminus", "face gare", "1ère à droite", "avenue foch"
  };
  String[] action = {
    "livraison", "DISTRIBUTION", "chantier", "concours", "boucherie", "hotel", "restaurant", "réseau", "danger", "incident", "mort", "avenue"
  };
  String[] determinent = {
    "de", "au", "et", "du"
  };
  String[] chiffre = {
    "82", "87", "62", "55", "52", "50", "312", "00000", "52121"
  };
  String[] sujet =  {
    "robinet", "gaz", "maréchal", "transformation", "eau", "bière d'alsace", "client", "casque", "PONT", "public", "tour"
  };


void setup()
{
  sentence = randomSentence();
  size(1000, 300);
}   

void draw()
{
  background(255);
  fill(0);
  textSize(40);
  text(sentence, 10, 100);
}

void mousePressed()
{
  sentence = randomSentence();
}

String randomSentence()
{
  String s =  randomString(lieu) + " " + randomString(action) + " " + randomString(determinent)+ " " + randomString(chiffre) + " " + randomString(sujet);
  println(s);
  return s;
}

String randomString(String[] s)
{
  int index = int(random(s.length-1));
  return s[index];
}
