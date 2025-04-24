// AIArtWorkshop.pde - Main program
MainScreen mainScreen;
PromptScreen promptScreen;
ColoringScreen coloringScreen;
AIManager aiManager;
PImage image;

String currentScreen = "main";

void setup() {
  size(1440, 810);
  image = loadImage("race.jpg");
  mainScreen = new MainScreen();
  promptScreen = new PromptScreen();
  coloringScreen = new ColoringScreen(image);
 
  coloringScreen.initCanvas();
  //aiManager = new AIManager();
}

void draw() {
  background(220);
  if (currentScreen.equals("main")) {
    mainScreen.display();
  } else if (currentScreen.equals("prompt")) {
    promptScreen.display();
  } else if (currentScreen.equals("coloring")) {
    coloringScreen.display();
  }
}

void mousePressed() {
  if (currentScreen.equals("main")) {
    mainScreen.handleClick();
  } else if (currentScreen.equals("prompt")) {
    promptScreen.mousePressed();
  } else if (currentScreen.equals("coloring")) {
    coloringScreen.mousePressed();  // Handle all mouse interactions for coloring screen
  }
}


void keyPressed() {
  if (currentScreen.equals("prompt")) {
    promptScreen.keyPressed();
  } else if (currentScreen.equals("coloring")){
    coloringScreen.keyPressed();
  }
}

void mouseDragged() {
    println("Mouse Dragged in Main");
    if (currentScreen.equals("coloring")) {
        coloringScreen.mouseDragged();
    }
}
