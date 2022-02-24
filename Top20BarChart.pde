//class for drawing bar chart of top 20 areas with highest cases - Dylan Fitzpatrick
// fixed bar charts going off top of screen - Dylan Fitzpatrick - 20/04/2021
class Top20BarChart {

  String date1;
  String date2;
  String area;
  int totalCaseChange;

  Top20BarChart(String date1, String date2)
  {
    this.date1 = date1;
    this.date2 = date2;
  }

  void draw() {
    ArrayList<Area> top20 = getTop20Areas(currentCaseArrayList, date1, date2);
    int i = 0;
    int red = 3;
    int green = 155;
    int blue = 229;
    float average = calculateAverage(top20);
    for (Area a : top20) 
    {   
      area = a.getString();
      totalCaseChange = a.getValue();
      fill(0);
      textFont (areaLabelFont);
      text(area, 100 + (i*90), 910);
      fill(red, green, blue);
      rect(120+(i*90), height-totalCaseChange*.22-195, 10, totalCaseChange*.22+5);
      i++;
      red += 11.1;
      blue -= 11.45; 
      green += 5;
    }
    float textRotateX = 30;
    float textRotateY = 150;
    line(90, 230, 90, 890);
    line(90, 890, 75+(i*90), 890);
    stroke(255, 0, 0);
    line(90, height-average*.22-195, 75+(i*90), height-average*.22-195);
    textFont(averageFont);
    fill(255, 0, 0);
    text("average: " + average, (i*90), height-average*.22-200);
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
    text("Change in Cases", -490, 0);
    popMatrix();
    text("Areas", 950, 940);
  }

  // method to find the average - Dylan Fitzpatrick 
  float calculateAverage(ArrayList<Area> area) {
    int sum = 0;
    if (!area.isEmpty()) {
      for (Area b : area) {
        sum += b.getValue();
      }
      float average = sum/area.size();
      return average;
    }
    return sum;
  }
}
