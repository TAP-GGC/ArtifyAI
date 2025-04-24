class MainScreen {
  Button startButton;
  Button quitButton;
  
  private PImage mainScreen;
  
  MainScreen() {
    startButton = new Button(532, 333, 315, 135, "Start");
    quitButton = new Button(532, 507, 315, 149, "Quit");
    mainScreen = loadImage("MainScreen.png");
  }
  
  void display() {
    background(mainScreen);
    fill(0);
    
    startButton.display();
    quitButton.display();
  }
  
  void handleClick() {
    if (startButton.isClicked()) {
      currentScreen = "prompt";
    } else if (quitButton.isClicked()) {
      exit();
    }
  }
}
