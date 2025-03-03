// ColoringScreen.pde - Drawing Interface
class ColoringScreen {
  Button backButton;
  Button saveButton;
  Button resizeButton;
  Button generateColorButton;
  Button eraserButton; 
  
  TextBox redBox;
  TextBox greenBox;
  TextBox blueBox;
  TextBox sizeBox;
  
  PImage outlineImage;
  color selectedColor = color(0);
  color eraserColor = color(255, 255, 255, 0); // White background
  boolean isErasing = false; // Track if eraser mode is active
  
  PGraphics paintingLayer;  // New layer for painting
  PGraphics canvas;
  PGraphics finalImage;
  
  int imageWidth;
  int imageHeight;
  private PImage coloringScreen;
  int userInputSize;
  int userInputRed;
  int userInputGreen;
  int userInputBlue;
  int newSize;
  int newColor;
  int size = 10;
 
  final private int Red = color(255, 0, 0);
  final private int Green= color(0, 255, 0);
  final private int Blue= color(0, 0, 255);
  final private int Yellow= color(255, 255, 0);
  final private int Cyan= color(0, 255, 255);
  final private int Magenta= color(255, 0, 255);
  final private int Black= color(0, 0, 0);
  final private int Gray= color(169, 169, 169);
  final private int Orange= color(255, 165, 0);
  final private int Purple= color(128, 0, 128);
  final private int Pink= color(255, 192, 203);
  final private int Brown= color(139, 69, 19);
  final private int Lime= color(50, 205, 50);
  final private int Teal= color(0, 128, 128);
  final private int Tan= color(210, 180, 140);


  ColoringScreen(PImage outline) {
    
    imageWidth = 600;
    imageHeight = 600;
    
    backButton = new Button(20, height - 50, 100, 30, "Back");
    saveButton = new Button(width - 120, height - 50, 100, 30, "Save");
    resizeButton = new Button(50 + imageWidth + 50 + 30, 300, 100, 40, "Resize");
    eraserButton = new Button(resizeButton.x, 400, 100, 40, "Eraser");
    
    sizeBox = new TextBox((int)resizeButton.x, 250, 100, 40);
    redBox = new TextBox(sizeBox.x + sizeBox.w + 40, 250, 60, 40);
    
    generateColorButton = new Button((int)redBox.x, 300, 100, 40, "Generate");
    
    greenBox = new TextBox(redBox.x + redBox.w + 20, 250, 60, 40);
    blueBox = new TextBox(greenBox.x + greenBox.w + 20, 250, 60, 40);
    
    coloringScreen = loadImage("ColoringScreen.png");
    outlineImage = outline;

    // Create a PGraphics layer for drawing
    canvas = createGraphics(imageWidth, imageHeight, JAVA2D); // Template layer
    paintingLayer = createGraphics(imageWidth, imageHeight, JAVA2D); // Painting layer
    finalImage = createGraphics(imageWidth, imageHeight);
   
    // Draw outline image onto the canvas at the start
    canvas.beginDraw();
    canvas.image(outlineImage, 0, 0, imageWidth, imageHeight);
    canvas.endDraw();
  }

  void display() {
    background(coloringScreen);
    image(canvas, 50, 50);
    image(paintingLayer, 50, 50);
    stroke(0);
    noFill();
    rect(50, 50, imageWidth, imageHeight); // Draw boundary
    backButton.display();
    saveButton.display();
    eraserButton.display(); // Show eraser button
    
    fill(0);
    textSize(20);
    textAlign(LEFT, BOTTOM);  // Align text left and bottom of the coordinates
    text("Brush Size", sizeBox.x, sizeBox.y - 10);
    fill(Red);
    text("Red", redBox.x, redBox.y - 10);
    fill(Green);
    text("Green", greenBox.x, greenBox.y - 10);
    fill(Blue);
    text("Blue", blueBox.x, blueBox.y - 10);
    
    resizeButton.display();
    generateColorButton.display();
    drawColorPalette();
    
    sizeBox.display();
    redBox.display();
    greenBox.display();
    blueBox.display();
    
    if(isErasing){
      stroke(0, 255, 0);  // Color for the outline (e.g., green)
      noFill();  // No filling for the outline
      ellipse(mouseX, mouseY, size, size);
    }
}



  void drawColorPalette() {
    int paletteX = 50 + imageWidth + 50 + 30;
    int paletteY = 80;
    int paletteSize = 30;
    color[] colors = {Red, Green, Blue, Yellow, Cyan, Magenta, Black, Gray, Orange, Purple, Pink, Brown, Lime, Teal, Tan};
   
    for (int i = 0; i < colors.length; i++) {
      fill(colors[i]);
      rect(paletteX + (i * (paletteSize + 10)), paletteY, paletteSize, paletteSize);
    }
  }

  void handleClick() {
    if (backButton.isClicked()) {
      currentScreen = "prompt";
    } else if (saveButton.isClicked()) {
      saveArtwork();
    } else if (sizeBox.userInput.length() > 0 && resizeButton.isClicked()) {
      newSize = int(sizeBox.userInput);
      size = constrain(newSize, 1, 100); // Ensure size is in a valid range
    } else if (redBox.userInput.length() > 0 && greenBox.userInput.length() > 0 && 
               blueBox.userInput.length() > 0 && generateColorButton.isClicked()) {
      userInputRed = int(redBox.userInput);
      userInputGreen = int(greenBox.userInput);
      userInputBlue = int(blueBox.userInput);
      
      // Constrain the values between 0 and 255 for valid RGB values
      userInputRed = constrain(userInputRed, 0, 255);
      userInputGreen = constrain(userInputGreen, 0, 255);
      userInputBlue = constrain(userInputBlue, 0, 255);
      
      selectedColor = color(userInputRed, userInputGreen, userInputBlue);
      isErasing = false;  // Disable eraser if a color is selected
    } else {
      selectColor();  // Handle selecting a color from the palette
    }
  }

  void toggleEraser() {
    isErasing = !isErasing;  // Toggle eraser state
    if (isErasing) {
      selectedColor = eraserColor;  // Set color to transparent (eraser mode)
    } else {
      selectedColor = color(userInputRed, userInputGreen, userInputBlue);  // Reset to selected color
    }
  }

  
  void selectColor() {
    int paletteX = 50 + imageWidth + 50 + 30;
    int paletteY = 80;
    int size = 30;
    color[] colors = {Red, Green, Blue, Yellow, Cyan, Magenta, Black, Gray, Orange, Purple, Pink, Brown, Lime, Teal, Tan};
   
    for (int i = 0; i < colors.length; i++) {
      if (mouseX > paletteX + (i * (size + 10)) && mouseX < paletteX + (i * (size + 10)) + size && mouseY > paletteY && mouseY < paletteY + size) {
        selectedColor = colors[i];
        isErasing = false;
      }
    }
  }
 
  void initCanvas() {
    canvas = createGraphics(imageWidth, imageHeight);
    canvas.beginDraw();
    canvas.clear();  // Clears everything (makes it transparent)
    canvas.image(outlineImage, 0, 0, imageWidth, imageHeight);
    canvas.endDraw();
}


  void mouseDragged() {
    // Only allow drawing or erasing within the canvas bounds
    if (mouseX >= 50 && mouseX <= 50 + imageWidth && mouseY >= 50 && mouseY <= 50 + imageHeight) {
      int localX = mouseX - 50;  // Adjust mouseX to local canvas coordinates
      int localY = mouseY - 50;  // Adjust mouseY to local canvas coordinates
  
      paintingLayer.beginDraw();  // Draw on the painting layer
      if (isErasing) {
        eraseFunction(localX, localY);  // Pass adjusted coordinates to erasing function
      } else {
        paintingLayer.fill(selectedColor);  // Drawing with selected color
        paintingLayer.noStroke();
        paintingLayer.ellipse(localX, localY, size, size);  // Draw the brush stroke
      }
      paintingLayer.endDraw();
    }
  }


  
  void keyPressed() {
    println("Key Pressed: " + key);
    redBox.handleKeyPress();
    greenBox.handleKeyPress();
    blueBox.handleKeyPress();
    sizeBox.handleKeyPress();
  }

  void mousePressed() {
    // Handle interactions with text boxes (typing mode)
    if (sizeBox.overTextBox()) {
      sizeBox.startTyping();
    } else {
      sizeBox.stopTyping();
    }
    
    if (redBox.overTextBox()) {
      redBox.startTyping();
    } else {
      redBox.stopTyping();
    }
    
    if (greenBox.overTextBox()) {
      greenBox.startTyping();
    } else {
      greenBox.stopTyping();
    }
    
    if (blueBox.overTextBox()) {
      blueBox.startTyping();
    } else {
      blueBox.stopTyping();
    }
    
    // Handle eraser button click
    if (eraserButton.isClicked()) {
      toggleEraser();  // Toggle the eraser
    }
    
    // Handle other button clicks (back, save, resize, color generation, etc.)
    handleClick();  // Ensure this handles other interactions like resizing, saving, etc.
  }

  void eraseFunction(int localX, int localY) {
    paintingLayer.loadPixels();  // Load the pixel data from the painting layer
    color transparent = color(255, 255, 255, 0); // Fully transparent color
    for (int x = localX - size / 2; x < localX + size / 2; x++) {
      for (int y = localY - size / 2; y < localY + size / 2; y++) {
        // Only erase pixels within the brush size
        if (x >= 0 && x < paintingLayer.width && y >= 0 && y < paintingLayer.height) {
          float distance = dist(x, y, localX, localY);  // Calculate the distance
          if (distance <= size / 2) {
            int loc = x + y * paintingLayer.width;  // Get the pixel location
            paintingLayer.pixels[loc] = transparent;  // Set the pixel to transparent (eraser)
          }
        }
      }
    }
    paintingLayer.updatePixels();  // Apply changes to the painting layer
  }
  
  void saveArtwork() {
    // Combine the canvas (background) and painting layer (drawn content)
    finalImage.beginDraw();
    finalImage.clear();  // Clear the image before drawing
    finalImage.image(canvas, 0, 0);  // Draw the base canvas (template)
    finalImage.image(paintingLayer, 0, 0);  // Draw the painting (drawn content) on top
    finalImage.endDraw();
  
    // Save the final image
    finalImage.save("colored_art.png");  // Save the combined image
    println("Artwork saved as colored_art.png");
  }


}
