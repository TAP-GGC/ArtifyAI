class PromptScreen {
  Button generateButton;
  Button backButton;
  String userInput = "";
  boolean typing = false;
  TextBox inputBox;
  PImage generatedImage;
  PImage localImage;  // Load a local image
  //AIManager aiManager = new AIManager(); // Create AIManager instance
 
  private PImage promptScreen;
 
  PromptScreen() {
    generateButton = new Button(width / 2 - 60, height - 100, 120, 40, "Generate");
    backButton = new Button(20, height - 50, 100, 30, "Back");
    localImage = loadImage("race.jpg");  // Load local image
    promptScreen = loadImage("promptScreen.png");
    inputBox = new TextBox(width / 2 - 150, 130, 300, 40);
  }
 
  void display() {
    background(promptScreen);
    fill(255);
    textSize(20);
    textAlign(CENTER);
    text("Enter your drawing prompt:", width / 2, 100);
   
    // Input Box
    inputBox.display();
   
    generateButton.display();
    backButton.display();
   
    if (generatedImage != null) {
      image(generatedImage, width / 2 - 150, 200, 300, 300);
    }
  }
 
  void handleClick() {
    if (generateButton.isClicked()) {
      //generatedImage = aiManager.generateOutline("draw me a " + inputBox.userInput + " in coloring book/sheet format");
      generatedImage = localImage;
      //println(inputBox.userInput);
      if (generatedImage != null) {
        coloringScreen = new ColoringScreen(generatedImage); // Pass to coloring screen
        currentScreen = "coloring";
      } else {
        println("Failed to load AI-generated image.");
      }
    } else if (backButton.isClicked()) {
      currentScreen = "main";
    }
  }
 
  void keyPressed() {
    inputBox.handleKeyPress();
  }

  void mousePressed() {
    // Handle mouse clicks for the input box and buttons
    if (inputBox.overTextBox()) {
      inputBox.startTyping(); // Start typing if clicked inside the text box
    } else {
      inputBox.stopTyping(); // Stop typing if clicked outside the text box
    }
    handleClick();
  }
}
