//class added by Jason 28/03/21

class Widget {
  int x, y, width, height;
  String label; 
  int event;
  color widgetColor, labelColor;
  PFont widgetFont;

  Widget(int x, int y, int width, int height, String label, 
    color widgetColor, PFont widgetFont, int event) {
    this.x=x; 
    this.y=y; 
    this.width = width; 
    this.height= height;
    this.label=label; 
    this.event=event;
    this.widgetColor=widgetColor; 
    this.widgetFont=widgetFont;
    labelColor= color(0);
  }

  // Jacob 31/03/21
  String getLabel() {
    return label;
  }

  // Jacob 31/03/21
  color getColor() {
    return widgetColor;
  }
  // Jacob 31/03/21
  void setColor(color colour) {
    widgetColor = colour;
  }

  void draw() {
    stroke(labelColor);
    fill(widgetColor);
    rect(x, y, width, height);
    fill(labelColor);
    textFont(widgetFont);
    text(label, x + width/20, y + height * 39/50);
  }
  int getEvent(int mX, int mY) {
    if (mX>x && mX < x+width && mY >y && mY <y+height) {
      return event;
    }
    return EVENT_NULL;
  }
}
