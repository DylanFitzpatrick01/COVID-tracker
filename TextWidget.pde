//class added by Jason 01/04/2021
class TextWidget extends Widget {
  int maxlen;

  TextWidget(int x, int y, int width, int height, 
    String label, color widgetColor, PFont font, int event, int
    maxlen) {
    super(x, y, width, height, label, widgetColor, font, event);
    this.maxlen=maxlen;
  }
  
  //Jason 01/04/2021
  //Jason 12/04/2021 edited to only allow input of digits or '/' character
  void append(char s) {
    if (s==BACKSPACE) {
      if (!label.equals("")) {
        label=label.substring(0, label.length()-1);
      }
    } else if ((label.length() < maxlen) && (s == '0' || s == '1' || s == '2' || s == '3' || s == '4' || 
    s == '5' || s == '6' || s == '7' || s == '8' || s == '9' || s == '/')) {
      label=label+str(s);
    }
  }
  //Jason 05/04/2021
  String getLabel() {
    return label;
  }
  //Jason 05/04/2021
  void draw() {
    stroke(labelColor);
    fill(widgetColor);
    rect(x, y, width, height);
    fill(labelColor);
    textFont(widgetFont);
    text(label, x + width/20, y + height * 39/50);
  }
}
