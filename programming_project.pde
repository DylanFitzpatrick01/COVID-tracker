import java.util.Map; //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
import java.util.List;
Table table;
PFont caseFont, axisLabelFont, labelFont, labelFontMini, areaLabelFont, screenHeaderFont, buttonFont, homeAndBackFont, graphTwoScreenHeaderFont, averageFont, longButtonFont; 
Screen homeScreen, graphScreen, dropdownScreen, queryOneDateEntryScreen, queryOneDropdownScreen, queryOneGraphScreen, 
  queryTwoDateEntryScreen, queryTwoGraphScreen, mapScreen, queryThreeDateEntryScreen, queryThreeGraphScreen;
int currentScreen;
int currentlyTyping;
int yposition =0;
ArrayList<Case> caseArrayList1, caseArrayList2, caseArrayList3, caseArrayList4, currentCaseArrayList;
Map areaCasesMap1, stateCasesMap1, countryCasesMap1, statePieChart1, areaColors, dateCasesMap1;
DropBox stateDropBox1, stateDropBox2, areaDynamicDropBox, stateDropBox3; // Drop box declared Jacob 08/04/2021
PieChart testPieChart, currPieChart;
BarChart currBartChart;
LineGraph currLineGraph; 
boolean isLineGraph, datesEntered;
boolean canType = true;
String currentMaxDate; //currentMaxDate declared Jacob 14/04/21
String currentMinDate; //currentMinDate declared Jacob 14/04/21
String stateClicked = "";
String stateChosen = "";
String firstDate="";
String secondDate = "";
String top20FirstDate = "";
String top20SecondDate="";
color yellow, lightBlue, darkBlue;
//float scrollValue = 0;

void settings() {
  size(SCREENX, SCREENY);
}
void setup() {
  // load the csv files
  caseArrayList1 = readFile("daily-10k.csv");  //<>// //<>// //<>//
  //caseArrayList2 = readFile("daily-97k.csv");
  //caseArrayList3 = readFile("daily-1M.csv");
  //Added current list to make changing list easier in the future - Jacob 25/03/2021  
  currentCaseArrayList = caseArrayList1;
  currentMaxDate = currentCaseArrayList.get(currentCaseArrayList.size()-1).getDate(); //get last date entry in current data set - Jacob 14/04/21 //<>// //<>// //<>//
  currentMinDate = currentCaseArrayList.get(0).getDate(); //get first date entry in current data set - Jacob 14/04/21
  
  // Example use of getTop20Areas method for new barchart class - Harold 08/04/2021
  //ArrayList<Area> test =  getTop20Areas(currentCaseArrayList, "01/02/2020", "04/03/2020");
  //for (Area v: test) println(v.getString(), v.getValue()); 
  
  background(255);
  currentScreen = HOME_SCREEN_VALUE;
  currentlyTyping = 0;
  caseFont = loadFont("GillSansMT-32.vlw");
  screenHeaderFont  = loadFont("GillSansMT-Bold-60.vlw");
  graphTwoScreenHeaderFont = loadFont("GillSansMT-Bold-32.vlw");
  axisLabelFont = loadFont("Calibri-Light-20.vlw");
  labelFont = loadFont("Dubai-Bold-35.vlw");
  labelFontMini = loadFont("Dubai-Medium-15.vlw");
  areaLabelFont = loadFont("Arial-BoldMT-10.vlw");
  buttonFont = loadFont("GillSansMT-86.vlw");
  longButtonFont = loadFont("GillSansMT-60.vlw");
  homeAndBackFont = loadFont("GillSansMT-60.vlw");
  averageFont = loadFont("Arial-BoldMT-10.vlw");
  yellow = color(#FFFF00);
  darkBlue = color(#23395d);
  lightBlue = color(#039be5);

  //Jason - did a little bit more on this each week
  homeScreen = new Screen(255);
  homeScreen.createWidget(SCREENX/2 - 500, 175, 1075, 100, "Case Distribution In A State",color(yellow), 
    buttonFont, EVENT_HOME_TO_DROPDOWN);
  homeScreen.createWidget(SCREENX/2 - 500, 375, 1075, 100, "Cases In An Area Over Time", color(yellow), 
    buttonFont, EVENT_HOME_TO_QUERY_ONE);
  homeScreen.createWidget(SCREENX/2 - 500, 575, 1075, 100, "Change in Areas of a State", color(yellow), 
    buttonFont, EVENT_HOME_TO_QUERY_TWO);
  homeScreen.createWidget(SCREENX/2 - 720, 775, 1500, 100, "Areas With The Largest Change Over Time (Whole USA)", color(yellow),
  longButtonFont, EVENT_HOME_TO_QUERY_THREE);
  /*
  homeScreen.createWidget(SCREENX/2 - 75, 675, 175, 100, "Map", color(yellow), 
    buttonFont, EVENT_HOME_TO_MAP);
  */

  dropdownScreen = new Screen(255);
  dropdownScreen.createWidget(100, 100, 165, 75, "Home", color(yellow), 
    homeAndBackFont, EVENT_DROPDOWN_TO_HOME);

  //all of the screen objects and corresponding widget and textWidget objects below here, as well as any code corresponding to the screens or widgets in draw() and mousePressed() methods, done by 
  //Jason 05/04/2021 - 15/04/2021, to allow navigation between all the screens we need through clicking widgets, also added typing functionality for any text widgets at the same time, 
  //using draw method, keyReleased method, and TextWidget class
  queryOneDateEntryScreen = new Screen(255);
  queryOneDateEntryScreen.createWidget(100, 75, 165, 75, "Home", color(yellow), 
    homeAndBackFont, EVENT_Q1_DATE_ENTRY_TO_HOME);
  queryOneDateEntryScreen.createWidget(SCREENX/2 - 100, 900, 200, 100, "Next", color(darkBlue), 
    buttonFont, EVENT_Q1_DATE_ENTRY_TO_DROPDOWNS);
  queryOneDateEntryScreen.createTextWidget(420, SCREENY/2 - 100, 460, 100, "", color(255), 
    buttonFont, EVENT_Q1_TYPING_ONE, 10);
  queryOneDateEntryScreen.createTextWidget(1040, SCREENY/2 - 100, 460, 100, "", color(255), 
    buttonFont, EVENT_Q1_TYPING_TWO, 10);

  queryOneDropdownScreen = new Screen(255);
  queryOneDropdownScreen.createWidget(100, 75, 165, 75, "Home", color(yellow), 
    homeAndBackFont, EVENT_Q1_DROPDOWN_TO_HOME);
  queryOneDropdownScreen.createWidget(315, 75, 165, 75, "Back", color(lightBlue), 
    homeAndBackFont, EVENT_Q1_DROPDOWN_BACK);
  queryOneDropdownScreen.createWidget(SCREENX/2 - 100, 900, 200, 100, "Next", color(lightBlue), 
    buttonFont, EVENT_Q1_DROPDOWN_TO_GRAPH);

  queryOneGraphScreen = new Screen(255);
  queryOneGraphScreen.createWidget(100, 75, 165, 75, "Home", color(yellow), 
    homeAndBackFont, EVENT_Q1_DROPDOWN_TO_HOME);
  queryOneGraphScreen.createWidget(315, 75, 165, 75, "Back", color(lightBlue), 
    homeAndBackFont, EVENT_Q1_GRAPH_BACK);

  queryTwoDateEntryScreen = new Screen(255);
  queryTwoDateEntryScreen.createWidget(100, 75, 165, 75, "Home", color(yellow), 
    homeAndBackFont, EVENT_Q2_DATE_ENTRY_TO_HOME);
  queryTwoDateEntryScreen.createWidget(SCREENX/2 - 100, 900, 200, 100, "Next", color(darkBlue), 
    buttonFont, EVENT_Q2_DATE_ENTRY_TO_GRAPH);
  queryTwoDateEntryScreen.createTextWidget(970, SCREENY/2, 460, 100, "", color(255), 
    buttonFont, EVENT_Q2_TYPING_ONE, 10);
  queryTwoDateEntryScreen.createTextWidget(1450, SCREENY/2, 460, 100, "", color(255), 
    buttonFont, EVENT_Q2_TYPING_TWO, 10);


  queryTwoGraphScreen = new Screen(255);
  queryTwoGraphScreen.createWidget(100, 75, 165, 75, "Home", color(yellow), 
    homeAndBackFont, EVENT_Q2_GRAPH_TO_HOME);
  queryTwoGraphScreen.createWidget(315, 75, 165, 75, "Back", color(lightBlue), 
    homeAndBackFont, EVENT_Q2_GRAPH_BACK);
    
  /* this screen went unused -Jason 06/04/2021
  mapScreen = new Screen(255);
  mapScreen.createWidget(100, 100, 165, 75, "Home", color(yellow), 
    homeAndBackFont, MAP_TO_HOME);
  */
    
  queryThreeDateEntryScreen = new Screen(255);
  queryThreeDateEntryScreen.createWidget(100, 75, 165, 75, "Home", color(yellow), 
    homeAndBackFont, EVENT_Q3_DATE_ENTRY_TO_HOME);
  queryThreeDateEntryScreen.createWidget(SCREENX/2 - 100, 900, 200, 100, "Next", color(darkBlue), 
    buttonFont, EVENT_Q2_DATE_ENTRY_TO_GRAPH);
  queryThreeDateEntryScreen.createTextWidget(420, SCREENY/2 - 100, 460, 100, "", color(255), 
    buttonFont, EVENT_Q3_TYPING_ONE, 10);
  queryThreeDateEntryScreen.createTextWidget(1040, SCREENY/2 - 100, 460, 100, "", color(255), 
    buttonFont, EVENT_Q3_TYPING_TWO, 10);
    
  queryThreeGraphScreen = new Screen(255);
  queryThreeGraphScreen.createWidget(100, 75, 165, 75, "Home", color(yellow), 
    homeAndBackFont, EVENT_Q3_GRAPH_TO_HOME);
  queryThreeGraphScreen.createWidget(315, 75, 165, 75, "Back", color(lightBlue), 
    homeAndBackFont, EVENT_Q3_GRAPH_BACK);
  
  // create a map that stores the number of cases for each state  - Harold 31/03/2021
  //areaCasesMap1= createCaseCountMap(caseArrayList1, 0); // needs to be scarapped as states can have areas with the same name 
  stateCasesMap1 = createCaseCountMap(currentCaseArrayList, 1);
  //countryCasesMap1 = createCaseCountMap(caseArrayList1, 2); // redundant for now as USA is the only country
  dateCasesMap1 = createCaseCountMap(currentCaseArrayList, 3);

  // create stateDropBox1 and StateDropBox2 -Jacob 07/04/21
  stateDropBox1 = new DropBox(currentCaseArrayList, 5, labelFont, "State", 100, 300, 50, 330); //Resized text, boxes and fixed positions 
  stateDropBox2 = new DropBox(currentCaseArrayList, 6, caseFont, "State", 100, 280, 40, 330);  //for new UI-Jacob 14/04/21
  areaDynamicDropBox = new DropBox(currentCaseArrayList, 7, caseFont, "State", 500, 280, 40, 330, "", "Area");
  stateDropBox3 = new DropBox(currentCaseArrayList, 6, labelFont, "State", 170, 380, 50, 330); //Dropboxes initialised - Jacob 08/04/2021

  statePieChart1 = new HashMap<String, PieChart>();
  areaColors = new HashMap<String, List<Integer>>();
  // test pieChart 
  // testPieChart = new PieChart("Kentucky", caseArrayList1, stateCasesMap1);
  // currPieChart = testPieChart;
  // println(stateCasesMap1);
  // println("\n", changeInCases("California", "27/01/2020", "05/03/2020"));
}

void draw() {
  switch(currentScreen) {
  case HOME_SCREEN_VALUE:
    homeScreen.draw();
    fill(0);
    textFont(screenHeaderFont);
    text("The COVID-19 Data Explorer", SCREENX/2 - 380, 50);
    break;
  case DROPDOWN_SCREEN_VALUE:
    dropdownScreen.draw();
    fill(0);
    textFont(screenHeaderFont);
    text("Case Distribution In A State", SCREENX/2 - 400, 50);
    text("Select a state", 90, 280); //Added state title Jacob 14/04/21
    if (stateClicked.length() > 0) 
    {
      currPieChart.draw();
      int currHeight = 80;
      int margin = 600;  
      for (Map.Entry<String, List<Integer>> data : currPieChart.getAreaColors().entrySet()) 
      {
        String currArea = data.getKey();
        int r = data.getValue().get(0);
        int g = data.getValue().get(1);
        int b = data.getValue().get(2);

        color currAreaColor = color(r, g, b);
         
        fill(currAreaColor);
        square(width - (margin+30), currHeight, 10);
        fill(0);
        textFont(labelFontMini);
        text(currArea, width - margin, currHeight + 11);
        currHeight += 35;
        if (currHeight + 11 > height - 35)
        {
          currHeight = 80;
          margin = margin -= 150; 
        } 
       }
    }
    stateDropBox1.draw(); // draw dropbox stateDropBox1 - Jacob 08/04/2021
    break;
  case QUERY_ONE_DATE_ENTRY_SCREEN_VALUE:
    queryOneDateEntryScreen.draw();
    fill(0);
    textFont(screenHeaderFont);
    text("Enter start and end dates in the form DD/MM/YYYY", SCREENX/2 - 650, 50);
    text("Start Date", 500, SCREENY/2 - 160);
    text("End Date", 1135, SCREENY/2 - 160);
    textFont(labelFont);                                 // Added minimum and maximum date text - Jacob 14/04/21
    text("min. date: "+currentMinDate,475, SCREENY/2+50);
    text("max. date: "+currentMaxDate,1100,SCREENY/2+50);
    if (currentlyTyping == 1 && keyPressed && canType) {
      TextWidget TW = (TextWidget)queryOneDateEntryScreen.widgetList.get(2);
      TW.append(key);
      canType = false;
    } else if (currentlyTyping == 2 && keyPressed && canType) {
      TextWidget TW = (TextWidget)queryOneDateEntryScreen.widgetList.get(3);
      TW.append(key);
      canType = false;
    }
    if(validateDateInput(queryOneDateEntryScreen)) {
      datesEntered = true;
      Widget nextWidget = (Widget)queryOneDateEntryScreen.widgetList.get(1);
      nextWidget.widgetColor = color(lightBlue);
    }
    else {
      datesEntered = false;
      Widget nextWidget = (Widget)queryOneDateEntryScreen.widgetList.get(1);
      nextWidget.widgetColor = color(darkBlue);
    }
    break;
  case QUERY_ONE_DROPDOWN_SCREEN_VALUE:
    queryOneDropdownScreen.draw();
    fill(0);
    textFont(screenHeaderFont);
    text("Select a State and an area  from the dropdown", SCREENX/2 - 550, 50);
    text("State:", 100, 230);
    stateDropBox2.draw(); //draw dropboxes state2 and dynamic - Jacob 08/04/2021
    if (!stateDropBox2.getCurrentString().equals("")) {
      areaDynamicDropBox.draw();
      textFont(screenHeaderFont);
      text("Area", 500, 230);
    }
    break;
  case QUERY_ONE_GRAPH_SCREEN_VALUE:
    queryOneGraphScreen.draw();
    fill(0);
    textFont(screenHeaderFont);
    text("Cases in this area over time", SCREENX/2 - 350, 50);
    textFont(caseFont);
    if (isLineGraph) currLineGraph.draw();
    break;
  case QUERY_TWO_DATE_ENTRY_SCREEN_VALUE:
    queryTwoDateEntryScreen.draw();
    fill(0);
    textFont(screenHeaderFont);
    text("Select a state", 150, 350);
    text("Enter start and end dates", SCREENX/2 + 125, 350);
    text("in the form DD/MM/YYYY", SCREENX/2 + 125, 400);
    text("Start Date", 1050, SCREENY/2 - 40);
    text("End Date", 1550, SCREENY/2 - 40); 
    textFont(labelFont);                                 // Added minimum and maximum date text - Jacob 14/04/21
    text("min. date: "+currentMinDate,1035, SCREENY/2+140);
    text("max. date: "+currentMaxDate,1500,SCREENY/2+140);
    textFont(buttonFont);                                              
    text(stateDropBox3.getCurrentString()+"  -",160, SCREENY/2 + 75); //Added enlarged state text - Jacob 14/04/21
    if (currentlyTyping == 1 && keyPressed && canType) {
      TextWidget TW = (TextWidget)queryTwoDateEntryScreen.widgetList.get(2);
      TW.append(key);
      canType = false;
      firstDate=TW.label;
    } else if (currentlyTyping == 2 && keyPressed && canType) {
      TextWidget TW = (TextWidget)queryTwoDateEntryScreen.widgetList.get(3);
      TW.append(key);
      canType = false;
      secondDate=TW.label;
    }
    if(validateDateInput(queryTwoDateEntryScreen)) {
      datesEntered = true;
      Widget nextWidget = (Widget)queryTwoDateEntryScreen.widgetList.get(1);
      nextWidget.widgetColor = color(lightBlue);
    }
    else {
      datesEntered = false;
      Widget nextWidget = (Widget)queryTwoDateEntryScreen.widgetList.get(1);
      nextWidget.widgetColor = color(darkBlue);
    }
    stateDropBox3.draw(); // draw dropbox state3 - Jacob 08/04/2021
    stateChosen = stateDropBox3.currentString;
    break;
  case QUERY_TWO_GRAPH_SCREEN_VALUE:
    queryTwoGraphScreen.draw();
    fill(0);
    BarChart currBarChart = new BarChart(firstDate, secondDate, stateChosen); //draw graph to screen - Dylan Fitzpatrick
    textFont(graphTwoScreenHeaderFont);
    text("Change in cases over time from " + firstDate + " to " + secondDate + " in " + stateChosen, SCREENX/2 - 500, 50);
    currBarChart.draw();
    break;
  /* unused screen
  case MAP_SCREEN_VALUE:
    mapScreen.draw();
    fill(0);
    textFont(screenHeaderFont);
    text("Map", SCREENX/2 - 60, 50);
    break;
  */
  case QUERY_THREE_DATE_ENTRY_SCREEN_VALUE:
    queryThreeDateEntryScreen.draw();
    fill(0);
    textFont(screenHeaderFont);
    text("Enter start and end dates in the form DD/MM/YYYY", SCREENX/2 - 650, 50);
    text("Start Date", 500, SCREENY/2 - 160);
    text("End Date", 1135, SCREENY/2 - 160);
    textFont(labelFont);                                  // Added minimum and maximum date text - Jacob 14/04/21
    text("min. date: "+currentMinDate,475, SCREENY/2+50); 
    text("max. date: "+currentMaxDate,1090,SCREENY/2+50); 
    if (currentlyTyping == 1 && keyPressed && canType) {
      TextWidget TW = (TextWidget)queryThreeDateEntryScreen.widgetList.get(2);
      TW.append(key);
      top20FirstDate =TW.label;
      canType = false;
    } else if (currentlyTyping == 2 && keyPressed && canType) {
      TextWidget TW = (TextWidget)queryThreeDateEntryScreen.widgetList.get(3);
      TW.append(key);
      canType = false;
      top20SecondDate=TW.label;
    }
    if(validateDateInput(queryThreeDateEntryScreen)) {
      datesEntered = true;
      Widget nextWidget = (Widget)queryThreeDateEntryScreen.widgetList.get(1);
      nextWidget.widgetColor = color(lightBlue);
    }
    else {
      datesEntered = false;
      Widget nextWidget = (Widget)queryThreeDateEntryScreen.widgetList.get(1);
      nextWidget.widgetColor = color(darkBlue);
    }
    break;
  case QUERY_THREE_GRAPH_SCREEN_VALUE:
    queryThreeGraphScreen.draw();
    Top20BarChart top20BarChart = new Top20BarChart(top20FirstDate, top20SecondDate);
    fill(0);
    textFont(screenHeaderFont);
    text("Areas With The Largest Case Change Over Time", SCREENX/2 - 700, 50);
    top20BarChart.draw();
    break;
  }
}

ArrayList<Case> readFile(String fileName) {
  /* This method loads the data in the csv file into an arrayList 
   * row count is also printed to the console - Harold 24/03/2021
   */
  ArrayList<Case> caseArrayList = new ArrayList<Case>(); //Initialise data structure and load data -Jacob 24/03/2021

  table = loadTable(fileName, "header");

  for (TableRow row : table.rows()) {

    String date = row.getString("date");
    String area = row.getString("area");
    String countyOrState = row.getString("county/state");
    String geoid = row.getString("geoid");
    String cases = row.getString("cases");
    String country = row.getString("country");

    // Setting up variables for Case class and storing instances of said class
    // into data structure -Jacob 24/03/2021
    int geoidInt = parseInt(geoid);
    if (geoidInt == 0)
      geoidInt = -1;
    int casesInt = parseInt(cases);            
    caseArrayList.add(new Case(date, area, countyOrState, 
      geoidInt, casesInt, country)); 

    // println(date, area, countyOrState, geoid, cases, country);
  }

  //println(table.getRowCount() + " total rows in table");

  return caseArrayList;
}

//added by Jason 29/03/21
//add switch instead of the if statements to each screen case if they have many widgets
void mousePressed() {
  if (currentScreen == HOME_SCREEN_VALUE) {
    switch(homeScreen.getEvent()) {
    case EVENT_HOME_TO_GRAPH:
      currentScreen = GRAPH_SCREEN_VALUE;
      break;
    case EVENT_HOME_TO_DROPDOWN:
      currentScreen = DROPDOWN_SCREEN_VALUE;
      break;
    case EVENT_HOME_TO_QUERY_ONE:
      currentScreen =  QUERY_ONE_DATE_ENTRY_SCREEN_VALUE;
      datesEntered = false;
      break;
    case EVENT_HOME_TO_QUERY_TWO:
      currentScreen = QUERY_TWO_DATE_ENTRY_SCREEN_VALUE;
      datesEntered = false;
      break;
    case EVENT_HOME_TO_QUERY_THREE:
      currentScreen = QUERY_THREE_DATE_ENTRY_SCREEN_VALUE;
      datesEntered = false;
      break;
    }
  } else if (currentScreen == DROPDOWN_SCREEN_VALUE) {
    if (dropdownScreen.getEvent() == EVENT_DROPDOWN_TO_HOME) {
      stateDropBox1.clearCurrentString(); //clear stateDropBox1 if screen returns home  Jacob 31/03/21
      currentScreen = HOME_SCREEN_VALUE;
    }
    stateDropBox1.checkChoice(mouseX, mouseY); // checks for stateDropBox1 Jacob 31/03/21
    stateDropBox1.getEvent(mouseX, mouseY);
    stateClicked = stateDropBox1.getCurrentString(); 
    if (stateClicked.length() > 0) {      // Harold 01/04/21
      if (!statePieChart1.containsKey(stateClicked)) {
        currPieChart = new PieChart(stateClicked, currentCaseArrayList, stateCasesMap1);
        statePieChart1.put(stateClicked, currPieChart);
      } else  currPieChart = (PieChart) statePieChart1.get(stateClicked);
    }
    //Jason 05/04/2021
  } else if (currentScreen == QUERY_ONE_DATE_ENTRY_SCREEN_VALUE) {
    TextWidget TW1 = (TextWidget)queryOneDateEntryScreen.widgetList.get(2);
    TextWidget TW2 = (TextWidget)queryOneDateEntryScreen.widgetList.get(3);
    switch(queryOneDateEntryScreen.getEvent()) {
    case EVENT_NULL:
      currentlyTyping = 0;
      TW1.labelColor = color(0);
      TW2.labelColor = color(0);
      break;
    case EVENT_Q1_DATE_ENTRY_TO_HOME:
      currentScreen = HOME_SCREEN_VALUE;
      stateDropBox2.clearCurrentString();
      areaDynamicDropBox.clearCurrentString();
      TW1.label = "";
      TW2.label = "";
      currentlyTyping = 0;
      TW1.labelColor = color(0);
      TW2.labelColor = color(0);
      break;
    case EVENT_Q1_TYPING_ONE:
      currentlyTyping = 1;
      TW1.labelColor = color(lightBlue);
      TW2.labelColor = color(0);
      break;
    case EVENT_Q1_TYPING_TWO:
      currentlyTyping = 2;
      TW2.labelColor = color(lightBlue);
      TW1.labelColor = color(0);
      break;
    case EVENT_Q1_DATE_ENTRY_TO_DROPDOWNS:
      currentlyTyping = 0;
      TW1.labelColor = color(0);
      TW2.labelColor = color(0);
      if(datesEntered) {
      currentScreen = QUERY_ONE_DROPDOWN_SCREEN_VALUE;
      }
    }
  } else if (currentScreen == QUERY_ONE_DROPDOWN_SCREEN_VALUE) {
    TextWidget TW1 = (TextWidget)queryOneDateEntryScreen.widgetList.get(2);
    TextWidget TW2 = (TextWidget)queryOneDateEntryScreen.widgetList.get(3);
    switch(queryOneDropdownScreen.getEvent()) {
    case EVENT_Q1_DROPDOWN_TO_HOME:
      currentScreen = HOME_SCREEN_VALUE;
      stateDropBox2.clearCurrentString(); //Clear dropBoxes state2/Dynamic on return to home - Jacob 08/04/2021
      areaDynamicDropBox.clearCurrentString();
      TW1.label = "";
      TW2.label = "";
      break;
    case EVENT_Q1_DROPDOWN_BACK:
      currentScreen = QUERY_ONE_DATE_ENTRY_SCREEN_VALUE;
      stateDropBox2.clearCurrentString(); //Clear dropBoxes state2/Dynamic on return to home - Jacob 08/04/2021
      areaDynamicDropBox.clearCurrentString();
      break;
    case EVENT_Q1_DROPDOWN_TO_GRAPH:
      currentScreen = QUERY_ONE_GRAPH_SCREEN_VALUE;
      break;
    }
    String lastDynamicString = stateDropBox2.getCurrentString(); 
    stateDropBox2.checkChoice(mouseX, mouseY); // checks for StateDropBox2 - Jacob 07/04/21
    stateDropBox2.getEvent(mouseX, mouseY);
    String areasQueriedString = stateDropBox2.getCurrentString(); //get queriedString for areaDynamicDropBox - Jacob 07/04/21

    if (!lastDynamicString.equals(areasQueriedString))
      areaDynamicDropBox.clearCurrentString(); //clear areaDynamicDropBox if state has changed - Jacob 07/04/21
    if (!areasQueriedString.equals("")) {  
      areaDynamicDropBox.setAndSortQueriedString(areasQueriedString);  //update widgetList of areaDynamicDropox
    }                                                                  //depending on state selection Jacob 07/04/21
    if (areaDynamicDropBox!=null) { 
      areaDynamicDropBox.checkChoice(mouseX, mouseY); //checks for areaDynamicDropBox - Jacob 07/04/21
      areaDynamicDropBox.getEvent(mouseX, mouseY);
    }
    if (areaDynamicDropBox.getCurrentString().length() > 0 && stateDropBox2.getCurrentString().length() > 0)  // Harold 08/04/21
    {
      currLineGraph = new LineGraph(stateDropBox2.getCurrentString(), areaDynamicDropBox.getCurrentString(), currentCaseArrayList, TW1.label, TW2.label);
      isLineGraph = true;
    }
  } else if (currentScreen == QUERY_ONE_GRAPH_SCREEN_VALUE) {
    TextWidget TW1 = (TextWidget)queryOneDateEntryScreen.widgetList.get(2);
    TextWidget TW2 = (TextWidget)queryOneDateEntryScreen.widgetList.get(3);
    switch(queryOneGraphScreen.getEvent()) {
    case EVENT_Q1_GRAPH_TO_HOME:
      currentScreen = HOME_SCREEN_VALUE;
      stateDropBox2.clearCurrentString();
      areaDynamicDropBox.clearCurrentString();
      TW1.label = "";
      TW2.label = "";
      break;
    case EVENT_Q1_GRAPH_BACK:
      currentScreen = QUERY_ONE_DROPDOWN_SCREEN_VALUE;
      break;
    }
  } else if (currentScreen == QUERY_TWO_DATE_ENTRY_SCREEN_VALUE) {
    TextWidget TW1 = (TextWidget)queryTwoDateEntryScreen.widgetList.get(2);
    TextWidget TW2 = (TextWidget)queryTwoDateEntryScreen.widgetList.get(3);
    stateDropBox3.checkChoice(mouseX, mouseY); // checks for dropdown state3 box Jacob 31/03/21
    stateDropBox3.getEvent(mouseX, mouseY);
    switch(queryTwoDateEntryScreen.getEvent()) {
    case EVENT_NULL:
      currentlyTyping = 0;
      TW1.labelColor = color(0);
      TW2.labelColor = color(0);
      break;
    case EVENT_Q2_DATE_ENTRY_TO_HOME:
      currentScreen = HOME_SCREEN_VALUE;
      TW1.label = "";
      TW2.label = "";
      currentlyTyping = 0;
      TW1.labelColor = color(0);
      TW2.labelColor = color(0);
      stateDropBox3.clearCurrentString(); //clear string if return to home - Jacob 14/04/21
      break;
    case EVENT_Q2_DATE_ENTRY_TO_GRAPH:
      currentlyTyping = 0;
      TW1.labelColor = color(0);
      TW2.labelColor = color(0);
      if(datesEntered) {
      currentScreen = QUERY_TWO_GRAPH_SCREEN_VALUE;
      }
      break;
    case EVENT_Q2_TYPING_ONE:
      currentlyTyping = 1;
      TW1.labelColor = color(lightBlue);
      TW2.labelColor = color(0);
      break;
    case EVENT_Q2_TYPING_TWO:
      currentlyTyping = 2;
      TW2.labelColor = color(lightBlue);
      TW1.labelColor = color(0);
      break;
    }
  } else if (currentScreen == QUERY_TWO_GRAPH_SCREEN_VALUE) {
    TextWidget TW1 = (TextWidget)queryTwoDateEntryScreen.widgetList.get(2);
    TextWidget TW2 = (TextWidget)queryTwoDateEntryScreen.widgetList.get(3);
    switch(queryTwoGraphScreen.getEvent()) {
    case EVENT_Q2_GRAPH_TO_HOME:
      currentScreen = HOME_SCREEN_VALUE;
      TW1.label = "";
      TW2.label = "";
      break;
    case EVENT_Q2_GRAPH_BACK:
      currentScreen = QUERY_TWO_DATE_ENTRY_SCREEN_VALUE;
      break;
    }
  }
  /*
  else if (currentScreen == MAP_SCREEN_VALUE) {
    switch(mapScreen.getEvent()) {
    case MAP_TO_HOME:
      currentScreen = HOME_SCREEN_VALUE;
      break;
    }
  }
  */
  else if(currentScreen == QUERY_THREE_DATE_ENTRY_SCREEN_VALUE) {
    TextWidget TW1 = (TextWidget)queryThreeDateEntryScreen.widgetList.get(2);
    TextWidget TW2 = (TextWidget)queryThreeDateEntryScreen.widgetList.get(3);
    switch(queryThreeDateEntryScreen.getEvent()) {
    case EVENT_NULL:
      currentlyTyping = 0;
      TW1.labelColor = color(0);
      TW2.labelColor = color(0);
      break;
    case EVENT_Q3_DATE_ENTRY_TO_HOME:
      currentScreen = HOME_SCREEN_VALUE;
      TW1.label = "";
      TW2.label = "";
      currentlyTyping = 0;
      TW1.labelColor = color(0);
      TW2.labelColor = color(0);
      break;
    case EVENT_Q3_TYPING_ONE:
      currentlyTyping = 1;
      TW1.labelColor = color(lightBlue);
      TW2.labelColor = color(0);
      break;
    case EVENT_Q3_TYPING_TWO:
      currentlyTyping = 2;
      TW2.labelColor = color(lightBlue);
      TW1.labelColor = color(0);
      break;
    case EVENT_Q3_DATE_ENTRY_TO_GRAPH:
      currentlyTyping = 0;
      TW1.labelColor = color(0);
      TW2.labelColor = color(0);
      if(datesEntered) {
      currentScreen = QUERY_THREE_GRAPH_SCREEN_VALUE;
      }
    }
  } else if(currentScreen == QUERY_THREE_GRAPH_SCREEN_VALUE) {
    TextWidget TW1 = (TextWidget)queryThreeDateEntryScreen.widgetList.get(2);
    TextWidget TW2 = (TextWidget)queryThreeDateEntryScreen.widgetList.get(3);
    switch(queryThreeGraphScreen.getEvent()) {
      case EVENT_Q3_GRAPH_TO_HOME:
        currentScreen = HOME_SCREEN_VALUE;
        TW1.label = "";
        TW2.label = "";
        break;
      case EVENT_Q3_GRAPH_BACK:
        currentScreen = QUERY_THREE_DATE_ENTRY_SCREEN_VALUE;
        break;
    }
  }
}

//Jason 05/04/2021
void keyReleased() {
  canType = true;
}

//added - Jacob 31/03/21
void mouseMoved() {
  if (currentScreen == DROPDOWN_SCREEN_VALUE) {
    stateDropBox1.checkHover(); //stateDropBox1shade hovered box - Jacob 08/04/2021
  }
  if (currentScreen == QUERY_ONE_DROPDOWN_SCREEN_VALUE) {
    stateDropBox2.checkHover(); //stateDropBox2 shade hovered box - Jacob 08/04/2021
    if (areaDynamicDropBox!=null)
      areaDynamicDropBox.checkHover(); //areaDynamicDropBox shade hovered box - Jacob 08/04/2021
  }
  if (currentScreen == QUERY_TWO_DATE_ENTRY_SCREEN_VALUE) {
    stateDropBox3.checkHover(); //stateDropBox3 shade hovered box - Jacob 08/04/2021
  }
}

Map createCaseCountMap(ArrayList<Case> data, int selector) 
/* 
 creates and returns a map that stores the number of cases by 
 area, state or country - Harold 31/03/2021
 */
{
  String parameter;

  Map countMap = new HashMap<String, Integer>();
  for (Case row : data) 
  {
    if (selector == 0) parameter = row.area;
    else if (selector ==  1) parameter = row.state;
    else if (selector == 2) parameter = row.country;
    else parameter = row.date;

    if (!countMap.containsKey(parameter)) 
    {
      countMap.put(parameter, row.cases);
    } else countMap.put(parameter, (int) countMap.get(parameter) + row.cases);
  }

  return countMap;
}

//method added by Harold 07/04/2021
//Jason 15/04/2021 edited ethod to return arrayList of 0s if the string entered does not contain at least 3 ints. This prevented crashes when 10 characters were entered that did not contain 3
//separate ints
ArrayList<Integer> parseDate(String date) 
{   
  // Extract day, month and year in integer form 
  ArrayList dayMonthYear  = new ArrayList<Integer>();
  String[] dates = split(date, "/");
  if(dates.length == 3) {
  int day = Integer.valueOf(dates[0]);
  int month = Integer.valueOf(dates[1]);
  int year = Integer.valueOf(dates[2]);
  dayMonthYear.add(day);
  dayMonthYear.add(month);
  dayMonthYear.add(year);
  }
  else {
    dayMonthYear.add(0);
    dayMonthYear.add(0);
    dayMonthYear.add(0);
  }
  return dayMonthYear;
}

Map changeInCases(String state, String startDate, String endDate) 
{
  // Create a map of change in cases for all areas in a given state Harold - 07/04/2020
  Map areaChange = new HashMap<String, Integer>();
  ArrayList dates = parseDate(startDate);
  int startDay = (int) dates.get(0);
  int startMonth = (int) dates.get(1);

  dates = parseDate(endDate);
  int endDay = (int) dates.get(0);
  int endMonth = (int) dates.get(1); 

  for (Case data : currentCaseArrayList) 
  {
    if (data.state.equals(state)) 
    { 
      dates = parseDate(data.date);
      int day = (int) dates.get(0);
      int month = (int) dates.get(1);
      if (startMonth == endMonth && startMonth == month)
      {
        if (day >= startDay && day <= endDay) 
        {
          if (!areaChange.containsKey(data.area)) areaChange.put(data.area, 0);
          else areaChange.put(data.area, (int) areaChange.get(data.area) + data.cases);
        }
      } else 
      {
        if (month == startMonth) 
        {
          if (day >= startDay)
          {
            if (!areaChange.containsKey(data.area)) areaChange.put(data.area, 0);
            else areaChange.put(data.area, (int) areaChange.get(data.area) + data.cases);
          }
        } else if (month == endMonth) 
        {
          if (day <= endDay) 
          {
            if (!areaChange.containsKey(data.area)) areaChange.put(data.area, 0);
            else areaChange.put(data.area, (int) areaChange.get(data.area) + data.cases);
          }
        } else if (month > startMonth && month < endMonth) 
        {
          if (!areaChange.containsKey(data.area)) areaChange.put(data.area, 0);
          else areaChange.put(data.area, (int) areaChange.get(data.area) + data.cases);
        }
      }
    }
  }

  return areaChange;
}




void drawBarChart()
/*
Draws bar chart - Dylan Fitzpatrick 31/03/2021
 */
{
  float textRotateX = 30;
  float textRotateY = 150;
  line(480, 190, 480, 590);
  line(480, 590, 980, 590);
  fill(0);
  textFont(axisLabelFont);
  text("0", 465, 605);
  text("500", 445, 490);
  text("1000", 435, 390);
  text("1500", 435, 290);
  text("2000", 435, 190);
  textFont(labelFont);
  text("Cases By State", 650, 150);
  pushMatrix();
  translate(textRotateX, textRotateY);
  rotate(-HALF_PI);
  text("No. of Cases", -350, 380);
  popMatrix();
  text("States (Abbrev.)", 620, 655);
  int maxValue=0;
  ArrayList<String> stateAbbrev = new ArrayList<String>();
  ArrayList<Integer> casesByState = new ArrayList<Integer>();
  int TexasCases = (int) stateCasesMap1.get("Texas");
  casesByState.add(TexasCases);
  stateAbbrev.add("TX");
  int CaliCases = (int) stateCasesMap1.get("California");
  casesByState.add(CaliCases);
  stateAbbrev.add("CA");
  int NYCases = (int) stateCasesMap1.get("New York");
  casesByState.add(NYCases);
  stateAbbrev.add("NY");
  int FloridaCases = (int) stateCasesMap1.get("Florida");
  casesByState.add(FloridaCases);
  stateAbbrev.add("FL");
  int IllinoisCases = (int) stateCasesMap1.get("Illinois");
  casesByState.add(IllinoisCases);
  stateAbbrev.add("IL");
  //noLoop();
  for (int i=0; i<casesByState.size(); i++)
  {
    if (casesByState.get(i)>maxValue)
      maxValue=casesByState.get(i);
  }
  for (int x = 0; x < casesByState.size(); x = x + 1) {
    noStroke();
    fill(96, 179, 192);
    rect (x*100+500, height-casesByState.get(x)/3-500, 
      50, casesByState.get(x)/3);
    fill(0);
    textFont(caseFont);
    text(stateAbbrev.get(x), x*100+500, 620);
  }
}

//method added by Jason 12/04/2021
//Jason 15/04/2021 edited method to return false if date of a year returned is 0 corresponding with edits to parseDate
boolean validateDateInput(Screen usersScreen) {
  boolean date1Valid = false;
  boolean date2Valid = false;
  TextWidget TW1 = (TextWidget)usersScreen.widgetList.get(2);
  TextWidget TW2 = (TextWidget)usersScreen.widgetList.get(3);
  if(TW1.label != "" && TW2.label != "" && TW1.label.length() >= TW1.maxlen && TW2.label.length() >= TW2.maxlen) {
    ArrayList<Integer> startDate = parseDate(TW1.label);
    ArrayList<Integer> endDate = parseDate(TW2.label);
    if(startDate.get(2) > endDate.get(2) || startDate.get(2) == 0 || endDate.get(2) == 0) {
      return false;
    }
    else if(startDate.get(2) != endDate.get(2) && startDate.get(1) > endDate.get(1)) {
      return false;
    }
    else if(startDate.get(1) == endDate.get(1) && startDate.get(0) > endDate.get(0)) {
      return false;
    }
    else if(startDate.get(0) > 31 || endDate.get(0) > 31) {
      return false;
    }
    else if(((startDate.get(1) == 4 || startDate.get(1) == 6 || startDate.get(1) == 9 || startDate.get(1) == 11) && startDate.get(0) > 30) || 
    ((endDate.get(1) == 4 || endDate.get(1) == 6 || endDate.get(1) == 9 || endDate.get(1) == 11) && endDate.get(0) > 30)) {
      return false;
    }
    else if(((startDate.get(1) == 2) && startDate.get(0) > 29) || ((endDate.get(1) == 2) && endDate.get(0) > 29)) {
      return false;
    }
    
    ArrayList<Integer> minDate = parseDate(currentMinDate);
    ArrayList<Integer> maxDate = parseDate(currentMaxDate);
    if(isWithinTimeFrame(minDate.get(0), minDate.get(1), minDate.get(2), maxDate.get(0), maxDate.get(1), maxDate.get(2), startDate.get(0), startDate.get(1), startDate.get(2))) {
      date1Valid = true;
    }
    if(isWithinTimeFrame(minDate.get(0), minDate.get(1), minDate.get(2), maxDate.get(0), maxDate.get(1), maxDate.get(2), endDate.get(0), endDate.get(1), endDate.get(2))) {
      date2Valid = true;
    }
    if(date1Valid && date2Valid) {
      return true;
    }
    else return false;
  }
  else return false;
}


//Print out the instances on the screen in a nice font using
//text(). - Dylan 25/03/2021
/*
void printCase() {
 int count = 0;
 for (Case newCase : currentCaseArrayList) {
 fill(0);
 textAlign(LEFT);
 text(newCase.caseString(), 50, 50+(count*32)); 
 count=count+1;
 }
 noLoop();
 }
 */

/* scroll method for future use - Dylan 25/03/2021
 void mouseWheel(MouseEvent event) {
 scrollValue -= event.getCount()*10;
 println(scrollValue);
 }
 */
