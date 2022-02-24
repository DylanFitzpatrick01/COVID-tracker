//bar chart class - Dylan Fitzpatrick
// fixed bar charts going off top of screen - Dylan Fitzpatrick - 20/04/2021
class BarChart {

  String date1;
  String date2;
  String state;
  String area;
  int totalCaseChange;

  Map<String, Integer> dateCasesMap = new HashMap<String, Integer>();
  ArrayList<Integer> sortedAreaCases = new ArrayList<Integer>();
  ArrayList<String> areaNames = new ArrayList<String>();

  BarChart(String date1, String date2, String state) {
    this.date1=date1;
    this.date2=date2;
    dateCasesMap = changeInCases(state, date1, date2);
    // totalCaseChange = changeInCases(date1, date2);
  }

  //int changeInCases(String date1, String date2){
  //  int firstCases = (int) dateCasesMap1.get(date1);
  //  int secondCases = (int) dateCasesMap1.get(date2);
  //  return secondCases-firstCases;
  //}

  void draw() {
    int i = 0;
    int red = 3;
    int green = 155;
    int blue = 229;
    for (Map.Entry<String, Integer> data : dateCasesMap.entrySet()) 
    {   
      area = data.getKey();
      areaNames.add(area);
      totalCaseChange = (int) data.getValue();
      sortedAreaCases.add(totalCaseChange);
      textFont (areaLabelFont);
      fill(0);
      text(area, 100 + (i*90), 910);
      fill(red, green, blue);
      rect(120+(i*90), height-totalCaseChange*.22-195, 10, totalCaseChange*.22+5);
      i++;
      red += 11.1;
      blue -= 11.45; 
      green += 5;
      if (i>=20) break;
    }
    float average = calculateAverage(sortedAreaCases);
    /*
    java.util.Collections.sort(sortedAreaCases, java.util.Collections.reverseOrder());
     for (Integer AreaList: sortedAreaCases)
     {
     textFont (areaLabelFont);
     fill(0);
     text(areaNames.get(i), 80 + (i*80), 910);
     fill(40, 60, 75);
     rect(100+(i*80), height-sortedAreaCases.get(i)*9.5-191, 10, sortedAreaCases.get(i)*9.5);
     i++;
     }
     attempted code for skewed bar chart - Dylan Fitzpatrick */
    float textRotateX = 30;
    float textRotateY = 150;
    line(90, 215, 90, 890);
    line(90, 890, 75+(i*90), 890);
    stroke(255, 0, 0);
    line(90, height-average*.22-195, 75+(i*90), height-average*.22-195);
    textFont(averageFont);
    fill(255, 0, 0);
    text("average: " + average, (i*90), height-average*.22-205);
    fill(0);
    textFont(axisLabelFont);
    for (int axisLabel=0; axisLabel<=3000; axisLabel+=150)
    {
      if (axisLabel<10)
        text(axisLabel, 75, height-axisLabel*.22-195);
      else if (axisLabel>=10 && axisLabel<100)text(axisLabel, 65, height-axisLabel*.22-195);
      else if (axisLabel>=100 && axisLabel<1000)text(axisLabel, 55, height-axisLabel*.22-195);
      else if (axisLabel>=1000)text(axisLabel, 45, height-axisLabel*.22-195);
    }
    textFont(labelFont);
    pushMatrix();
    translate(textRotateX, textRotateY);
    rotate(-HALF_PI);
    text("Change in Cases", -500, 10);
    popMatrix();
    text("Areas", 950, 980);
  }
  
  float calculateAverage(ArrayList<Integer> areas) {
    int sum = 0;
    if (!areas.isEmpty()) {
      for (int i=0; i<areas.size(); i++) {
        sum += areas.get(i);
      }
      float average = sum/areas.size();
      return average;
    }
    return sum;
  }
}

/* code for initial test graph presented in week 2- Dylan Fitzpatrick
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
 */
