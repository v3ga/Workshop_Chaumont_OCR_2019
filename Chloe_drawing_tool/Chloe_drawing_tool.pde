int state = 0; // 0 : repos, 1 : premier click, 1 : deuxième click
int mode = 0; // 0 : dégradé et 1 random
PVector firstClick = new PVector();
PVector secondClick = new PVector();
float d = 10.0;
String mot = "Hello";
float grey = 0;
float greyMax = 200;

// --------------------------------------
void setup()
{
  size(640, 900);
  background(0);
}

// --------------------------------------
void draw()
{
  if (state == 2)
  {
    println("draw");
    PVector u = new PVector();
    PVector p = new PVector();

    u.x = secondClick.x - firstClick.x;
    u.y = secondClick.y - firstClick.y;
    u.normalize();

    float distance = dist(firstClick.x, firstClick.y, secondClick.x, secondClick.y);
    float step = distance / d; 
    float stepy = firstClick.y; 

    float s = 0.0;
    while (s < distance)
    {
      p.x = firstClick.x + u.x*s;
      p.y = firstClick.y + u.y*s;
      if (mode == 0)
      {
        grey = map( s,0,distance,0,greyMax );
        fill(grey);
      }
      else
      {
        fill(random(greyMax));
      }
      textSize(50);
      text(mot, p.x, p.y);
      s+= d;
    }
    state = 0;
    println("state="+state);
  }
}

// --------------------------------------
void keyPressed()
{
  if (key=='1') mot = "Test";
  else if (key=='2') mot = "Test2";
  else if (key=='d') mode = 0;
  else if (key=='r') mode = 1;
}

// --------------------------------------
void mousePressed()
{
  if (state == 0)
  {
    state = 1;
    firstClick.set(mouseX, mouseY);
  } 
  else if (state == 1)
  {
    secondClick.set(mouseX, mouseY);
    state = 2;
  }
}
