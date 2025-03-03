// Button.pde - Button Class
class Button {
  float x, y, w, h;
  String label;
  
  color normalColor = color(34, 167, 59);
  color hoverColor = color(3, 122, 31);
  color clickedColor = color(255,0,0);
  color currentColor;
  
  Button(float x, float y, float w, float h, String label) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
    this.currentColor = normalColor;
  }
  
  void display() {
    if (overButton()) {
      currentColor = hoverColor;
    } else if(isClicked()){
      currentColor = clickedColor;
    } else {
      currentColor = normalColor;
    }
  
    fill(currentColor);  // Set the color before drawing
    rect(x, y, w, h, 10);  // Draw the button with the current color
    
    fill(0);  // Set the text color to black
    textSize(16);
    textAlign(CENTER, CENTER);
    text(label, x + w / 2, y + h / 2);  // Display the label
  }

  
  boolean overButton() {
    return mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h;
  }
  
  boolean isClicked() {
    return mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h && mousePressed;
  }
}
