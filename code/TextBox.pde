class TextBox {
  int x, y, w, h;
  String userInput = "";
  boolean typing = false;
  color fillColor = color(200); // Light gray for the text box
  color textColor = color(0); // Black for the text

  TextBox(int x, int y, int w, int h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void display() {
    fill(fillColor);
    rect(x, y, w, h, 10); // Draw the text box with rounded corners
    
    fill(textColor);
    textAlign(LEFT, CENTER);
    text(userInput, x + 10, y + h / 2); // Display user input inside the box
  }

  boolean overTextBox() {
    return mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h;
  }

  void handleKeyPress() {
    if (typing) {
      if (key == BACKSPACE && userInput.length() > 0) {
        userInput = userInput.substring(0, userInput.length() - 1);
      } else if (key != CODED && key != ENTER) {
        userInput += key;
      }
    }
  }

  void startTyping() {
    typing = true;
  }

  void stopTyping() {
    typing = false;
  }
  
  void mousePressed() {
    if (overTextBox()) {
      startTyping();
    } else {
      stopTyping();
    }
  }

}
