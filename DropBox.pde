//Class added by Jacob 30/03/21 //<>//
// Dynamic query needs to be added once we have decided on user queries
//to do so check current queries and ammend item list.
// It might be necessary to overload createQueriedList to do so. 
// -- This has been implemented as of 07/04/2021 Jacob
//Jacob 30/03/21 - Fixed bug were dropboxes were being drawn off screen
//Jacob 31/03/21 - Added getter/setters for currentString, ClearCurrentString() and CheckChoice()
//                 fixed bugs:dropdowns persisting after user clicked off dropbox, text not clearing in the 
//                            dropbox when the user returns to homescreen, items repeating in dropdown
//Jacob 07/04/21 - Added: Dynamic Constructor, createDynamicList(ArrayList , String , String , String)
//                        setAndSortQueriedString(String)
//Jacob 14/04/21 - Modified: reduced Distance from SCREENX in createDropDown(ArrayList)

class DropBox {

  ArrayList<Case> itemList;
  ArrayList<Widget> widgetList;
  int ItemAmount, eventValue, x, y, height, width;
  PFont dBFont;
  color hoverColor;
  String currentString, queryType, dynamicQuery, queriedString;
  boolean clicked;

  DropBox(ArrayList itemList, int eventValue, PFont dBFont, String queryType, 
    int x, int y, int height, int width) {
    this.itemList=itemList;
    this.eventValue=eventValue;
    this.dBFont=dBFont;
    this.queryType = queryType;
    this.x=x;
    this.y=y;
    this.height=height;
    this.width=width;
    hoverColor=color(220);
    currentString ="";  // prev ("") changed default just for testing - Harold 
    widgetList = createDropDown(createQueriedList(itemList, queryType));
    clicked = false;
  }

  // Dynamic Constructor Jacob 07/04/21
  DropBox(ArrayList itemList, int eventValue, PFont dBFont, String queryType, 
    int x, int y, int height, int width, String queriedString, String dynamicQuery) {
    this.itemList=itemList;
    this.eventValue=eventValue;
    this.dBFont=dBFont;
    this.queryType = queryType;
    this.x=x;
    this.y=y;
    this.height=height;
    this.width=width;
    this.dynamicQuery = dynamicQuery;
    this.queriedString = queriedString;
    hoverColor=color(220);
    currentString ="";
    widgetList = createDropDown(createDynamicList(itemList, queryType, queriedString, dynamicQuery));
    clicked = false;
  }

  // updates the queriedString for the Dynamic constructor and creates a new dropdown Jacob 07/04/21
  void setAndSortQueriedString(String queriedString) {
    this.queriedString = queriedString;
    widgetList = createDropDown(createDynamicList(itemList, queryType, queriedString, dynamicQuery));
  }
  // Sets the current String Jacob 31/03/21
  void setCurrentString(String currentString) {
    this.currentString = currentString;
  }

  // returns the current String Jacob 31/03/21
  String getCurrentString() {
    return currentString;
  }

  //Clears currentString - Jacob 31/03/21
  void clearCurrentString() {
    currentString = "";  // prev("") changed default for testing - Harold
  }

  //To be used in mousePressed(). Checks to see if the mouse has been pressed over a 
  // drop-down item, and changes displayed choice based on chosen item Jacob 31/03/21
  void checkChoice(int mX, int mY) {
    if (clicked) { //<>//
      for (int i=0; i<widgetList.size(); i++) {
        Widget aWidget = widgetList.get(i);
        int event = aWidget.getEvent(mX, mY);
        if (event != EVENT_NULL) {
          setCurrentString(aWidget.getLabel());
        }
      }
    }
  }

  // draws drop-down box and drop-down if it has been clicked Jacob 30/03/21
  void draw() {
    stroke(0);
    fill(255);
    rect(x, y, width, height);
    fill(0);
    textFont(dBFont);
    text(currentString, x+5, y+height-10);
    if (clicked)
      drawWidgets();
  }

  //To be used in mousePressed(). Checks to see if the mouse is over the drop-down Box Jacob 30/03/21
  int getEvent(int mX, int mY) {
    if (mX>x && mX < x+width && mY >y && mY <y+height) {
      clicked = true;
      return eventValue;
    }
    clicked = false;
    return EVENT_NULL;
  }
  //To be used in mouseMoved(). checks to see if user moused over a drop-down widget Jacob 30/03/21
  void checkHover() {
    int event = 0;
    for (int i = 0; i<widgetList.size(); i++) {
      Widget aWidget = (Widget) widgetList.get(i);
      event = aWidget.getEvent(mouseX, mouseY);
      if (event!= 0)
        aWidget.setColor(220);
      else if (aWidget.getColor() == 220)
        aWidget.setColor(255);
    }
  }

  //draws the dropdown Widgets Jacob 30/03/21
  void drawWidgets() {
    if (widgetList != null) {
      for (int i = 0; i<widgetList.size(); i++) {
        Widget aWidget = (Widget) widgetList.get(i);
        aWidget.draw();
      }
    }
  }

  //creates a descending list of widgets with the queriedList strings  Jacob 30/03/21
  ArrayList<Widget> createDropDown(ArrayList queriedList) {

    ArrayList widgetList = new ArrayList<Widget>();
    int widgetY = y;
    int widgetX = x;
    for (int i =0; i<queriedList.size(); i++) {
      widgetY+=height;
      if (widgetY>= SCREENY - height) { //made distance from boarder smaller Jacob 14/04/2021
        widgetY = y+height;
        widgetX += width;
      }
      widgetList.add(new Widget(widgetX, widgetY, width, height, (String)queriedList.get(i), color(255), dBFont, i+1));
    }
    return widgetList;
  }

  //creates a dynamicList based on what the user has inputted in another widget and what type 
  // of data has been chosen to parse through (dynamicQuery) in the constructor  Jacob 07/04/21
  // e.g. DropBox(caseArrayList1, 7, caseFont, "State", 500, 280, 40, 330, "", "Area")
  // setAndSortQueriedString(String queriedString) will ammend this to use the queried state(e.g. New York)
  ArrayList createDynamicList(ArrayList itemList, String queryType, String queriedString, String dynamicQuery) {
    ArrayList<String> queriedList = new ArrayList();
    for (int i=0; i<itemList.size(); i++) {
      Case queriedCase = (Case)itemList.get(i);
      String queriedDataType = "";
      switch(queryType) {
      case "Date":
        queriedDataType =queriedCase.getDate();
        break;
      case"Area":
        queriedDataType = queriedCase.getArea();
        break;
      case "State":
        queriedDataType = queriedCase.getState();        
        break;
      case "Geoid":
        queriedDataType = Integer.toString(queriedCase.getGeoid());
        break;
      case "Cases":
        queriedDataType = Integer.toString(queriedCase.getCases());
        break;
      case "Country":
        queriedDataType =queriedCase.getCountry();
      }
      if (queriedDataType.equals(queriedString)) {
        String dataToAdd = "";
        switch(dynamicQuery) {
        case "Date":
          dataToAdd =queriedCase.getDate();
          break;
        case"Area":
          dataToAdd = queriedCase.getArea();
          break;
        case "State":
          dataToAdd = queriedCase.getState();        
          break;
        case "Geoid":
          dataToAdd = Integer.toString(queriedCase.getGeoid());
          break;
        case "Cases":
          dataToAdd = Integer.toString(queriedCase.getCases());
          break;
        case "Country":
          dataToAdd = queriedCase.getCountry();
        }
        if (!queriedList.contains(dataToAdd))
          queriedList.add(dataToAdd);
      }
    }
    return queriedList;
  }
  //creates an ArrayList of strings composed of the desired data type Jacob 30/03/21
  ArrayList createQueriedList(ArrayList itemList, String queryType) {

    ArrayList<String> queriedList = new ArrayList();
    for (int i=0; i<itemList.size(); i++) {
      Case queriedCase = (Case)itemList.get(i);
      String dataToAdd = "";
      switch(queryType) {
      case "Date":
        dataToAdd =queriedCase.getDate();
        break;
      case"Area":
        dataToAdd = queriedCase.getArea();
        break;
      case "State":
        dataToAdd = queriedCase.getState();
        break;
      case "Geoid":
        dataToAdd = Integer.toString(queriedCase.getGeoid());
        break;
      case "Cases":
        dataToAdd = Integer.toString(queriedCase.getCases());
        break;
      case "Country":
        dataToAdd =queriedCase.getCountry();
      }
      if (!queriedList.contains(dataToAdd))
        queriedList.add(dataToAdd);
    }
    return queriedList;
  }
}
