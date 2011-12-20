// Your hero
PImage b;
boolean canMove = true;
boolean looksRight = false;
boolean looksLeft = false;
boolean looksUp = true;
boolean looksDown = false;

// Hit
PImage[] hits = new PImage[15];
boolean doesHit = false;
int frame = 0;
boolean swordEnabled = false;
boolean swordInUse = false;

// environment
int bgX = 0;
int bgY = 0;
PImage[][] envi = new PImage[10][10];

// GUI
PImage panel;
int panelX = 62;
int textY = 569;

// All positions
int wX = 600;
int wY = 600;
float posX = 200;
float posY = 200;
float moveX;
float moveY;

// Attributes
int[] attributes = new int[5];

// Windows
boolean showAttributes = false;

public void setup()
{
    size(wX, wY);
    // Background pics
    envi[0][0] = loadImage("Surrounding/TestingRoom.png");
    // Panel
    panel = loadImage("Menu/Leiste.png");
    // Set Attributes
    attributes[0] = 5; // Speed of Movement
    // Set hit pictures (first time)
    for(int i = 0 ; i < hits.length ; i++)
    {
      if(i >= 0 && i < 3) hits[i] = loadImage("Hero/Schlag/Up/HitUp1.png");
      if(i >= 3 && i < 6) hits[i] = loadImage("Hero/Schlag/Up/HitUp2.png");
      if(i >= 6 && i < 9) hits[i] = loadImage("Hero/Schlag/Up/HitUp3.png");
      if(i >= 9 && i < 12) hits[i] = loadImage("Hero/Schlag/Up/HitUp2.png");
      if(i >= 12 && i < 15) hits[i] = loadImage("Hero/Schlag/Up/HitUp1.png");
    }
    frameRate(35);
    b = loadImage("Hero/MovementUp/HeroUp.png"); // Your Hero
    background(envi[bgX][bgY]);
    image(b, posX, posY);
    panel();
    enterRoom();
}

public void draw()
{
    if(doesHit) 
    {
        drawAll();
        if(looksUp) 
        {
            // Set hit pictures UP
            for(int i = 0 ; i < hits.length ; i++)
            {
              if(i >= 0 && i < 3) hits[i] = loadImage("Hero/Schlag/Up/HitUp1.png");
              if(i >= 3 && i < 6) hits[i] = loadImage("Hero/Schlag/Up/HitUp2.png");
              if(i >= 6 && i < 9) hits[i] = loadImage("Hero/Schlag/Up/HitUp3.png");
              if(i >= 9 && i < 12) hits[i] = loadImage("Hero/Schlag/Up/HitUp2.png");
              if(i >= 12 && i < 15) hits[i] = loadImage("Hero/Schlag/Up/HitUp1.png");
            }
        }
        else if(looksLeft) 
        {
            // Set hit pictures LEFT
            for(int i = 0 ; i < hits.length ; i++)
            {
              if(i >= 0 && i < 3) hits[i] = loadImage("Hero/Schlag/Left/HitLeft1.png");
              if(i >= 3 && i < 6) hits[i] = loadImage("Hero/Schlag/Left/HitLeft2.png");
              if(i >= 6 && i < 9) hits[i] = loadImage("Hero/Schlag/Left/HitLeft3.png");
              if(i >= 9 && i < 12) hits[i] = loadImage("Hero/Schlag/Left/HitLeft2.png");
              if(i >= 12 && i < 15) hits[i] = loadImage("Hero/Schlag/Left/HitLeft1.png");
            }
        }
        else if(looksRight) 
        {
            // Set hit pictures RIGHT
            for(int i = 0 ; i < hits.length ; i++)
            {
              if(i >= 0 && i < 3) hits[i] = loadImage("Hero/Schlag/Right/HitRight1.png");
              if(i >= 3 && i < 6) hits[i] = loadImage("Hero/Schlag/Right/HitRight2.png");
              if(i >= 6 && i < 9) hits[i] = loadImage("Hero/Schlag/Right/HitRight3.png");
              if(i >= 9 && i < 12) hits[i] = loadImage("Hero/Schlag/Right/HitRight2.png");
              if(i >= 12 && i < 15) hits[i] = loadImage("Hero/Schlag/Right/HitRight1.png");
            }
        }
        else if(looksDown) 
        {
            // Set hit pictures DOWN
            for(int i = 0 ; i < hits.length ; i++)
            {
              if(i >= 0 && i < 3) hits[i] = loadImage("Hero/Schlag/Down/HitDown1.png");
              if(i >= 3 && i < 6) hits[i] = loadImage("Hero/Schlag/Down/HitDown2.png");
              if(i >= 6 && i < 9) hits[i] = loadImage("Hero/Schlag/Down/HitDown3.png");
              if(i >= 9 && i < 12) hits[i] = loadImage("Hero/Schlag/Down/HitDown2.png");
              if(i >= 12 && i < 15) hits[i] = loadImage("Hero/Schlag/Down/HitDown1.png");
            }
        }
        image(hits[frame], posX, posY);
        if(frame < hits.length - 1) frame++;
        else
        {
           doesHit = false;
           frame = 0;
           drawAll(); 
        }
    }
}

public boolean collision()
{
  float minus = 35; // Because the image is bigger than the player
  float xl = posX + minus;
  float xr = posX + b.width - minus;
  float yo = posY + minus;
  float yu = posY + b.height - minus;
  int i = 0;
  while(i < corners.length)
  {
    boolean xl_inside = (xl > corners[i][0] && xl < corners[i][1]);
    boolean xr_inside = (xr > corners[i][0] && xr < corners[i][1]);
    boolean yo_inside = (yo > corners[i][2] && yo < corners[i][3]);
    boolean yu_inside = (yu > corners[i][2] && yu < corners[i][3]);
    
    
    if (xl_inside && yo_inside) return true;
    if (xr_inside && yo_inside) return true;
    if (xl_inside && yu_inside) return true;
    if (xr_inside && yu_inside) return true;
    if (xl < corners[i][0] && yo < corners[i][1] && xr > corners[i][1] && yu > corners[i][3]) return true;
    if ((xl_inside || xr_inside) && yo < corners[i][2] && yu > corners[i][3]) return true;
    if ((yo_inside || yu_inside) && xl < corners[i][0] && xr > corners[i][1]) return true;
    i++;
  }
  
  return false;
}

int[][] corners = new int[12][8];
public void enterRoom()
{
      if(bgX == 0 && bgY == 0)
      {
          int x = 36;
          int y = 52;
          int H = 462;
          int W = 20;
          corners[0][0] = x;
          corners[0][1] = x + W;
          corners[0][2] = y;
          corners[0][3] = y + H;
          rect(x,y,W,H);
          x = 44;
          y = 52;
          H = 20;
          W = 462;
          corners[1][0] = x;
          corners[1][1] = x + W;
          corners[1][2] = y;
          corners[1][3] = y + H;
          rect(x,y,W,H);
          x = 531;
          y = 52;
          H = 462;
          W = 20;
          corners[2][0] = x;
          corners[2][1] = x + W;
          corners[2][2] = y;
          corners[2][3] = y + H;
          rect(x,y,W,H);
          x = 43;
          y = 496;
          H = 20;
          W = 232;
          corners[3][0] = x;
          corners[3][1] = x + W;
          corners[3][2] = y;
          corners[3][3] = y + H;
          rect(x,y,W,H);
          x = 348;
          y = 496;
          H = 20;
          W = 207;
          corners[4][0] = x;
          corners[4][1] = x + W;
          corners[4][2] = y;
          corners[4][3] = y + H;
          rect(x,y,W,H);
          x = 58;
          y = 352;
          H = 8;
          W = 58;
          corners[5][0] = x;
          corners[5][1] = x + W;
          corners[5][2] = y;
          corners[5][3] = y + H;
          rect(x,y,W,H);
          x = 172;
          y = 352;
          H = 8;
          W = 58;
          corners[6][0] = x;
          corners[6][1] = x + W;
          corners[6][2] = y;
          corners[6][3] = y + H;
          rect(x,y,W,H);
          x = 213;
          y = 352;
          H = 130;
          W = 8;
          corners[7][0] = x;
          corners[7][1] = x + W;
          corners[7][2] = y;
          corners[7][3] = y + H;
          rect(x,y,W,H);
          x = 386;
          y = 62;
          H = 90;
          W = 9;
          corners[8][0] = x;
          corners[8][1] = x + W;
          corners[8][2] = y;
          corners[8][3] = y + H;
          rect(x,y,W,H);
          x = 386;
          y = 220;
          H = 181;
          W = 9;
          corners[9][0] = x;
          corners[9][1] = x + W;
          corners[9][2] = y;
          corners[9][3] = y + H;
          rect(x,y,W,H);
          x = 386;
          y = 436;
          H = 72;
          W = 9;
          corners[10][0] = x;
          corners[10][1] = x + W;
          corners[10][2] = y;
          corners[10][3] = y + H;
          rect(x,y,W,H);
          x = 386;
          y = 276;
          H = 9;
          W = 251;
          corners[11][0] = x;
          corners[11][1] = x + W;
          corners[11][2] = y;
          corners[11][3] = y + H;
          rect(x,y,W,H);
      }
}

public void wait(int time)
{
    try {Thread.sleep(time);} catch(InterruptedException e) {}
}

/*public void hit()
{
   hit = loadImage("Hero/Schlag/HitUp1.png"); // First hit pick
   wait(5000);
   hit = loadImage("Hero/Schlag/HitUp2.png"); // Second hit pick
   wait(5000);
   hit = loadImage("Hero/Schlag/HitUp3.png"); // Third hit pick
   wait(5000);
   hit = loadImage("Hero/Schlag/HitUp2.png"); // Second hit pick
   wait(5000);
   hit = loadImage("Hero/Schlag/HitUp1.png"); // First hit pick
   doesHit = false;
}*/

public void updateView(String looksThere)
{
    looksRight = false;
    looksLeft = false;
    looksUp = false;
    looksDown = false; 
    
    if(looksThere.equals("UP")) looksUp = true;
    if(looksThere.equals("DOWN")) looksDown = true;
    if(looksThere.equals("LEFT")) looksLeft = true;
    if(looksThere.equals("RIGHT")) looksRight = true;
}

public void keyPressed() 
{
  if (key == CODED) 
  {
    // Movement
    if (keyCode == UP) {
      updateView("UP");
      moveY = -attributes[0];
      moveX = 0;
      makeSteps("Hero/MovementUp/HeroUpLeftFront.png","Hero/MovementUp/HeroUpRightBack.png","Hero/MovementUp/HeroUpLeftReturn.png","Hero/MovementUp/HeroUp.png","Hero/MovementUp/HeroUpRightFront.png","Hero/MovementUp/HeroUpLeftBack.png","Hero/MovementUp/HeroUpRightReturn.png","Hero/MovementUp/HeroUp.png");
    } else if (keyCode == DOWN) {
      updateView("DOWN");
      moveY = attributes[0];
      moveX = 0;
      makeSteps("Hero/MovementDown/HeroDownLeftFront.png","Hero/MovementDown/HeroDownRightBack.png","Hero/MovementDown/HeroDownLeftReturn.png","Hero/MovementDown/HeroDown.png","Hero/MovementDown/HeroDownRightFront.png","Hero/MovementDown/HeroDownLeftBack.png","Hero/MovementDown/HeroDownRightReturn.png","Hero/MovementDown/HeroDown.png");
    } 
    else if (keyCode == RIGHT) {
      updateView("RIGHT");
      moveX = attributes[0];
      moveY = 0;
      makeSteps("Hero/MovementRight/HeroRightLeftFront.png","Hero/MovementRight/HeroRightRightBack.png","Hero/MovementRight/HeroRightLeftReturn.png","Hero/MovementRight/HeroRight.png","Hero/MovementRight/HeroRightRightFront.png","Hero/MovementRight/HeroRightLeftBack.png","Hero/MovementRight/HeroRightRightReturn.png","Hero/MovementRight/HeroRight.png");
    } 
    else if (keyCode == LEFT) {
      updateView("LEFT");
      moveX = -attributes[0];
      moveY = 0;
      makeSteps("Hero/MovementLeft/HeroLeftLeftFront.png","Hero/MovementLeft/HeroLeftRightBack.png","Hero/MovementLeft/HeroLeftLeftReturn.png","Hero/MovementLeft/HeroLeft.png","Hero/MovementLeft/HeroLeftRightFront.png","Hero/MovementLeft/HeroLeftLeftBack.png","Hero/MovementLeft/HeroLeftRightReturn.png","Hero/MovementLeft/HeroLeft.png");
    } 
  } 
  else if (key == 'i' || key == 'I') {
    showAttributes = !showAttributes;
  }
  else if (key == 'x' || key == 'X') {
    doesHit = true;
    //hit();
  }
  else if (key == 'q' || key == 'Q') {
    attributes[0]++;
    //hit();
  }
  else if (key == 'w' || key == 'W') {
    swordInUse = true;
  }
  
  if(canMove)
  {
      posX = posX + moveX;
      posY = posY + moveY;
      
      
      if(collision())
      {
          posX = posX - moveX;
          posY = posY - moveY;
        
          if (key == CODED) 
          {
              if (keyCode == UP) 
              {
                  moveY = -5;
                  moveX = 0;
                  b = loadImage("Hero/Bong/HeroUpWand.png");  
              } 
              else if (keyCode == DOWN) 
              {
                  moveY = 5;
                  moveX = 0;
                  b = loadImage("Hero/Bong/HeroDownWand.png");  
              } 
              else if (keyCode == RIGHT) 
              {
                  moveX = 5;
                  moveY = 0;
                  b = loadImage("Hero/Bong/HeroRightWand.png");  
              } 
              else if (keyCode == LEFT) 
              {
                  moveX = -5;
                  moveY = 0;
                  b = loadImage("Hero/Bong/HeroLeftWand.png");  
              } 
          }
      }
  }
  drawAll();
  moveX = 0;
  moveY = 0;
}

public void keyReleased() 
{
    if (keyCode == UP) 
    {
        b = loadImage("Hero/MovementUp/HeroUp.png");
    }
    else if (keyCode == DOWN) 
    {
        b = loadImage("Hero/MovementDown/HeroDown.png");
    }
    if (keyCode == LEFT) 
    {
        b = loadImage("Hero/MovementLeft/HeroLeft.png");
    }
    if (keyCode == RIGHT) 
    {
        b = loadImage("Hero/MovementRight/HeroRight.png");
    }
    
    drawAll();
}

public void explode(int expX, int expY, float strenght)
{
      float diffX = expX - posX-48;
      float diffY = expY - posY-51;
      //println(diffX +"  D  "+ diffY);
    
      float moveX = 100/diffX * strenght;
      float moveY = 100/diffY * strenght;
      //println(moveX +"  M  "+ moveY);
      
      if(moveX > 50 || moveX < -50) moveX = 50;
      if(moveY > 50 || moveY < -50) moveY = 50;
      //println(moveX +"  M  "+ moveY);
      
      if(diffX + diffY > 100) 
      {
           moveX = 0;
           moveY = 0;
      }
      
      posX -= moveX;
      posY -= moveY;
      drawAll();
      //if(strenght > 0.0001) explode(expX, expY, strenght * 9/10);
}

public void mouseClicked()
{
     explode(mouseX, mouseY, 1); 
}

public void windowAtrributes()
{
     int waX = 100;
     int waY = 100;
     
     fill(#a48300);
     rect(waX, waY, 100, 200); 
     fill(#ffeda3);
     text("Your Attributes", waX + 3, waY + 15);
     text("Speed: " + attributes[0], waX + 3, waY + 40);
}

// Very, very, very long movement maker
int differ = 0;
public void makeSteps(String PathToPic, String PathToPic2, String PathToPic3, String PathToPic4, String PathToPic5, String PathToPic6, String PathToPic7, String PathToPic8)
{
      // 1 Move
      if (differ == 0)
      {
          b = loadImage(PathToPic);
          differ = 1;
      }
      // 2 Move
      else if (differ == 1)
      {
          b = loadImage(PathToPic2);
          differ = 2;
      }
      // 3 Move
      else if (differ == 2)
      {
          b = loadImage(PathToPic3);
          differ = 3;
      }
      // 4 Move
      else if (differ == 3)
      {
          b = loadImage(PathToPic4);
          differ = 4;
      }
      // 5 Move
      else if (differ == 4)
      {
          b = loadImage(PathToPic5);
          differ = 5;
      }
      // 6 Move
      else if (differ == 5)
      {
          b = loadImage(PathToPic6);
          differ = 6;
      }
      // 7 Move
      else if (differ == 6)
      {
          b = loadImage(PathToPic7);
          differ = 7;
      }
      // 8 Move
      else if (differ == 7)
      {
          b = loadImage(PathToPic8);
          differ = 0;
      }
}

public void drawAll()
{
    background(envi[bgX][bgY]);
    image(b, posX, posY); 
    panel();
    if(showAttributes) windowAtrributes();
}

public void panel()
{
    // Statusbar
    image(panel,62, height - 90); 
    fill(100);
    text("Show Attributes: Press I", panelX + 50 , textY, 1);
 
    // HP
    fill(#ff2828);
    ellipse(60, wY - 60, 100, 100);
   
    // MP
    fill(#0e3bff);
    ellipse(wX - 60, wY - 60, 100, 100); 
}

