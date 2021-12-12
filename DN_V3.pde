/* Decoding Nature Final Project
 Salama Almheiri
 Version 3
 */
// THINGS TO ADD: going back to file selection when a specific button is pressed

int gameState; //0, file selection page; 1,artwork generating; 2,exit back to file selection.
boolean doneAlready = false;
boolean imgSelected = false;

PImage img;
PImage[] tiles;

int tileSize = 20;
PFont font;

void setup() {
  gameState = 0;
  //fullScreen();
  size(600, 600);
  selectInput("Select a file to process:", "fileSelected");
}

void draw() {
  // first shows the file selection screen to input the image.
  if (!imgSelected) {
    // wait
  } else {

    println ("We are in gamestate=", gameState);
    // screen 1 (game instructions/ main page)
    if (gameState==0) {
      background(250, 50);

      font= loadFont("Font40.vlw");
      textFont (font);
      translate(width/2, height/2);
      textMode(CENTER);
      textSize(35);
      fill(230, 140, 150);
      text("IMAGE TO ART", -120, 0); //, 109, 190

      fill(250, 170, 190);
      textSize(18);
      text("Press 1 to start", -70, 30); //, 180, 220
      text("Press any key to transform", -110, 50); //, 180, 220

      if (key == '1') {
        gameState=1;
      }
    } 
    // "Artwork" page
    else if (gameState==1) {

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

    // Go back to file selection page (not working??)
    else if (gameState==2) {
      imgSelected=false;
      if (!imgSelected) {
        // wait
      } else {
        gameState=0;
      }
      //if (!doneAlready) {
      //  doneAlready = true;
      //}
    }
    
  } //end of else
} // end of loop

//Pressing key '2' allows us to change the "artwork"
void keyPressed() {
  if (key == '2') {
    println("Key 2 is pressed");
    loop();
  }
  // Pressing key '3' allows us to go back to file selection (not working??)
  if (key == '3') {
    println("Key 3 is pressed");
    gameState=2;
  }
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    String theNameThatHasBeenEntered  = selection.getAbsolutePath();
    img = loadImage( theNameThatHasBeenEntered );
    imgSelected = true;
  }

  tiles = new PImage[img.height/tileSize];

  for (int i=0; i< tiles.length; i++) {
    tiles[i] = img.get(int(random(img.width-tileSize)), int(random(img.height-tileSize)), tileSize, tileSize);
  }
  imageMode(CENTER);
}
