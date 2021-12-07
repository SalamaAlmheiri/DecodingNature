/* Decoding Nature Final Project
 Salama Almheiri
 Version 1
 */
 // THINGS TO ADD: image input/ choosing, going back to main page (exit)?

int gameState; //0, title page; 1,artwork generating; 
boolean doneAlready = false;

PImage img;
PImage[] tiles;

int tileSize = 20;
PFont font;

void setup() {
  gameState = 0; 
  size(600, 600);

  img = loadImage("dwarfImage.png");
  tiles = new PImage[img.height/tileSize];

  for (int i=0; i< tiles.length; i++) {
    tiles[i] = img.get(int(random(img.width-tileSize)), int(random(img.height-tileSize)), tileSize, tileSize);
  }
  imageMode(CENTER);
}

void draw() {
  println ("We are in gamestate=", gameState);
  // first shows screen 1 (game instructions/ main page)
  if (gameState==0) {
    background(250, 50);

    font= loadFont("Font40.vlw");
    textFont (font);
    translate(width/2, height/2);
    textMode(CENTER);
    textSize(30);
    fill(230, 140, 150);
    text("IMAGE TO ART", -120, 0); //, 109, 190

    fill(250, 170, 190);
    textSize(14);
    text("Press 1 to start", -70, 30); //, 180, 220
    text("Press any key to transform", -110, 50); //, 180, 220

    if (key == '1') {
      gameState=1;
    }
  } else if (gameState==1) {

    pushMatrix();
    translate(width/2, height/2);
    image(tiles[(int)random(tiles.length)], 0, 0);
    int numCircles = 50; //number of circles

    for (int j = 0; j < numCircles; j++) {
      int amount = 30*(j+1); //number of tiles in a circle
      float div = TWO_PI/amount; //?
      int whichImage = (int)random(tiles.length);

      // 
      for (int i = 0; i< amount; i++) {
        float x = cos(div*i)*tileSize*j;
        float y = sin(div*i)*tileSize*j;
        pushMatrix();
        translate(x, y);
        rotate(div*i);
        image(tiles[whichImage], 0, 0);
        popMatrix();
      }
    }

    popMatrix();
    noLoop();
  }
  //Go back to main page?
  //else {
  //  if (key == '2') {
  //      gameState=1;
  //    }
  //    if (!doneAlready) {
  //      //win.play(); ??
  //      doneAlready = true;
  //    }
  //  }
} // end of loop

void keyPressed() {
  loop();
}
