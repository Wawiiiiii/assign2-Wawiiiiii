PImage bg, cabbage, groundhogIdle, life, soldier, soil;
PImage restartHovered, restartNormal, startHovered, startNormal;
PImage title, gameover;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;
int gameState = GAME_START;

int cabbageX, cabbageY;
int soldierX, soldierY;
int groundhogX, groundhogY;
int distanceX, distanceY;
int lifeX = 10;

boolean downPressed, rightPressed, leftPressed;

void setup() {
	size(640, 480, P2D);
  //load images
  bg = loadImage("img/bg.jpg");
  life = loadImage("img/life.png");
  soil = loadImage("img/soil.png");
  soldier = loadImage("img/soldier.png");
  cabbage = loadImage("img/cabbage.png");
  groundhogIdle = loadImage("img/groundhogIdle.png");
  
  title = loadImage("img/title.jpg");
  gameover = loadImage("img/gameover.jpg");
  
  startNormal = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  restartNormal = loadImage("img/restartNormal.png");
  restartHovered= loadImage("img/restartHovered.png");
  
/*groundhogDown = loadImage("img/groundhogDown.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");*/
  
  cabbageX = floor(random(8))*80;
  cabbageY = floor(random(4))*80+160;
  soldierX = 0;
  soldierY = floor(random(3)+2)*80; 
  groundhogX = 320;
  groundhogY = 80;
  lifeX = 10;
  
  distanceX = groundhogX;
  distanceY = groundhogY;
}

void draw() {
	// Switch Game State
  switch(gameState){
		case GAME_START:
      background(title);
      image(startNormal, 248, 360, 144, 60); 
      if(mouseX>=248 && mouseX<=392 && mouseY>=360 && mouseY<=420){
        image(startHovered, 248, 360, 144, 60);
        if(mousePressed){
        gameState = GAME_RUN;
        }
      }
    break;
		case GAME_RUN:
      background(bg);
      image (soil, 0, 160);

      soldierX += 2;
      soldierX %=720;
  
      //grass
      noStroke();
      fill(124, 204, 25);
      rect(0, 145, 640, 15);

      //sun
      stroke(255, 255, 0);
      strokeWeight(5);
      fill(253, 184, 19);
      ellipse(590, 50, 120, 120);
  
      //lives
      image (life, lifeX-70, 10);    
      image (life, lifeX, 10);
      image (life, lifeX+70, 10);
  
      if (groundhogAppear) {
      image(groundhogIdle, groundhogX, groundhogY);
   　 }

      image (cabbage, cabbageX, cabbageY);
      if(groundhogX==cabbageX && groundhogY==cabbageY){
        cabbageX = -80;
        lifeX = lifeX+70;
      }
      
      image (soldier, soldierX-80, soldierY);
      if(groundhogX<soldierX-80+80 && groundhogX+80>soldierX-80 && groundhogY+80>soldierY && groundhogY<soldierY+80){
        groundhogY = 80;
        lifeX = lifeX-70;
        if(lifeX == -130){
        gameState = GAME_OVER;
        }
      } 
    //Pressed
    if (downPressed) {
      groundhogAppear = false;
      image(groundhogDown, groundhogX, groundhogY);
      groundhogY+=moveSpeed;
      if (groundhogY>=distanceY)distanceY=distanceY+80;
      if (groundhogY+80>height)groundhogY=height-80;
    }

    if (leftPressed) {
      groundhogAppear = false;
      image(groundhogLeft, groundhogX, groundhogY);
      groundhogX-=moveSpeed;
      if (groundhogX<=distanceX)distanceX=distanceX-80;
      if (groundhogX<0)groundhogX=0;
    }

    if (rightPressed) {
      groundhogAppear = false;
      image(groundhogRight, groundhogX, groundhogY);
      groundhogX+=moveSpeed;
      if (groundhogX>=distanceX)distanceX=distanceX+80;
      if (groundhogX+80>width)groundhogX=width-80;
    }
    
    if (groundhogX+80>width)groundhogX=width-80;
    if (groundhogX<0)groundhogX=0;
    
    break;
    case GAME_OVER:
      background(gameover);
      image(restartNormal, 248, 360, 144, 60); 
      if(mouseX>=248 && mouseX<=392 && mouseY>=360 && mouseY<=420){
        image(restartHovered, 248, 360, 144, 60);
        if(mousePressed){
          lifeX = 10;
          cabbageX = floor(random(8))*80;
          cabbageY = floor(random(4))*80+160;
          groundhogX = 320;
          groundhogY = 80;
          soldierX = 0;
          soldierY = floor(random(3)+2)*80; 
          gameState = GAME_RUN;
        }
      }
    break;
  }
}

void keyPressed(){
  switch(keyCode){
    case DOWN:
    groundhogY += 80;
    if (groundhogY>=400)groundhogY = 400;
    break;
    case RIGHT:
    groundhogX += 80;
    if (groundhogX>=560)groundhogX = 560;
    break;
    case LEFT:
    groundhogX -= 80;
    if (groundhogX<=0)groundhogX = 0;
    break;
  }
}

void keyReleased() {
  if (key == CODED) {
    switch (keyCode) {
    case DOWN:
      downPressed = false;
      groundhogAppear = true;
      break;
    case LEFT:
      leftPressed = false;
      groundhogAppear = true;
      groundhogX=distanceX;
      break;
    case RIGHT:
      rightPressed = false;
      groundhogX=distanceX;
      groundhogAppear = true;
      break;
    }
  }
}
