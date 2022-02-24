//class added by Jason 28/03/21

class Screen {
  ArrayList widgetList;
  color screenColor;

  Screen(color screenColor) {
    this.screenColor = screenColor;
    widgetList = new ArrayList();
  }

  //createWidget method for screens added by Jason 28/03/21
  void createWidget(int x, int y, int width, int height, String label, 
    color widgetColor, PFont widgetFont, int event) {
    Widget aWidget = new Widget(x, y, width, height, label, 
      widgetColor, widgetFont, event);
    widgetList.add(aWidget);
    //creates a widget and adds it to the screen's arraylist of widgets
  }
//added by Jason 05/04/2021
  void createTextWidget(int x, int y, int width, int height, String label, 
    color widgetColor, PFont widgetFont, int event, int maxlen) {
    TextWidget aTextWidget = new TextWidget(x, y, width, height, label, 
      widgetColor, widgetFont, event, maxlen);
    widgetList.add(aTextWidget);
  }

  //drawWidgets method for screens added by Jason 28/03/21
  void drawWidgets() {
    if (widgetList != null) {
      for (int i = 0; i<widgetList.size(); i++) {
        Widget aWidget = (Widget) widgetList.get(i);
        aWidget.draw();
      }
    }
    //simply draws all widgets that have been added to the screen
  }

  //added by Jason 29/03/21
  int getEvent() {
    for (int i = 0; i<widgetList.size(); i++) {
      Widget aWidget = (Widget) widgetList.get(i);
      if (aWidget.getEvent(mouseX, mouseY) != EVENT_NULL) {
        return aWidget.getEvent(mouseX, mouseY);
      }
    }
    return EVENT_NULL;
  }

  //draw method added by Jason 28/03/21
  void draw() {
    background(screenColor); 
    drawWidgets();
  }
}

//drawCaseList added by Jason 28/03/21
  /* never finished
  void drawCaseList(ArrayList<Case> caseList, int x, int y, 
    Widget forwardWidget, Widget backWidget, int startCase, PFont caseListFont) {
    int numberOfSubLists = caseList.size()/15;
    textFont(caseListFont);
    for (int i = startCase; i<startCase+14; i++) {
      Case aCase = caseList.get(i);
      text(aCase.caseString(), x, y);
      y += 15;
    }
  }
  */
