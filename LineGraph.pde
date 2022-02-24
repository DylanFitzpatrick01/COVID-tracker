/*
  Line Graph class by Harold Karibiye 08/04/2020 
  Make dates dynamic - Harold 20/02/2020 
*/

class LineGraph 
{
  String state, area;
  String[] dates; //{"21/01/2020", "31/01/2020", "10/02/2020", "20/02/2020", "01/03/2020", "11/03/2020", "24/03/2020"};
  boolean isSufficientDiff;
  PVector[] pos = new PVector[7];
  int[] values = new int[7]; 
  int minVal, maxVal, margin, graphHeight;
  float xSpacing;
  
  
  LineGraph (String state, String area, ArrayList<Case> caseList, String startDate, String endDate) 
  {
    this.state = state;
    this.area = area; 
    ArrayList<Integer> startList= parseDate(startDate);
    ArrayList<Integer> endList= parseDate(endDate);
    isSufficientDiff = getNumberOfDaysBetweenDates(startList.get(0), startList.get(1), startList.get(2), endList.get(0), endList.get(1), endList.get(2)) >= 6;
    dates = new String[7];
    setDates(startDate, endDate);
    
    int i = 0;
    for (String date : dates) 
    {
      values[i] = getTotalCase(area, startDate, date, caseList);
      i++;
    }
    
    minVal = min(values);
    maxVal = max(values);
    
    margin = 200;
    graphHeight = (height - (2*margin));
    xSpacing = (width - (2*margin)) / (dates.length - 1);
    
    for (int x = 0; x < values.length; x++) 
    {
       float scaledValue = map(values[x], minVal, maxVal, 0, graphHeight);
       float ypos = height - margin - scaledValue; 
       float xpos = margin + (xSpacing * x);
       pos[x] = new PVector(xpos, ypos);
    }
    
    // println(getNumberOfDaysBetweenDates(1, 1, 2020, 1, 1, 2025));
  }
  
  
  int getTotalCase(String area, String minDate, String date, ArrayList<Case> caseList) 
  {
    int count = 0;
    for (Case data: caseList) 
    {
      ArrayList<Integer> dates = parseDate(date);
      ArrayList<Integer> minDates = parseDate(minDate);
      ArrayList<Integer> areaDates = parseDate(data.date);
      
      int startDay = minDates.get(0);
      int startMonth = minDates.get(1);
      int startYear = minDates.get(2);
  
      int endDay = dates.get(0);
      int endMonth = dates.get(1);
      int endYear = dates.get(2);
      
      int day = areaDates.get(0);
      int month = areaDates.get(1);
      int year = areaDates.get(2);
     
      if (data.area.equals(area) && data.state.equals(this.state) && isWithinTimeFrame(startDay, startMonth, startYear, endDay, endMonth, endYear, day, month, year)) 
      {
        count += data.cases;
      }
    }  
     
    return count;
  }
  
  
  void setDates(String startDate, String endDate) 
  {
    dates[dates.length -1] = endDate;
    dates[0] = startDate;
    
    ArrayList<Integer> startValues = parseDate(startDate);
    ArrayList<Integer> endValues = parseDate(endDate);
    
    int currDay = startValues.get(0);
    int currMonth = startValues.get(1);
    int currYear = startValues.get(2);
    
    int endDay = endValues.get(0);
    int endMonth = endValues.get(1);
    int endYear = endValues.get(2);
    
    int i = 1;
    int diff = getNumberOfDaysBetweenDates(currDay, currMonth, currYear, endDay, endMonth, endYear);
    int alpha = diff / 6; 
    
    while (i <= 5) 
    {
      ArrayList<Integer> nextDate = getNextDate(currDay, currMonth, currYear, alpha);
      dates[i] = constructDate(nextDate.get(0), nextDate.get(1), nextDate.get(2));
      currDay = nextDate.get(0); 
      currMonth = nextDate.get(1); 
      currYear = nextDate.get(2);
      i++;
    }
    
  }
  
  
  int getNumberOfDaysBetweenDates(int startDay, int startMonth, int startYear, int endDay, int endMonth, int endYear) 
  {
    if (startYear == endYear) 
    {
      if (startMonth == endMonth) return endDay - startDay;
      else 
      {
        int count = getMaxDay(startMonth, startYear) - startDay + endDay;
        for (int i = startMonth+1; i < endMonth; i++)
        {
          count += getMaxDay(i, startYear);
        } 
        return count;
      }
    }
    else 
    {
      int count = getNumberOfDaysBetweenDates(startDay, startMonth, startYear, 31, 12, startYear);
      for (int i = startYear+1; i < endYear; i++) 
      {
        count += (isLeapYear(i) ? 366 : 365);
      }
      count += daysInYearTillDate(endDay, endMonth, endYear);
      return count;
    }
  }
  
  
  int daysInYearTillDate(int day, int month, int year) 
  {
    int days = day;
    if (month != 1) 
    {
      for(int i = 1; i < month; i++) days += getMaxDay(i, year);
    }
    return days;
  }
 
  
  ArrayList<Integer> getNextDate(int day, int month, int year, int alpha) 
  {
    ArrayList<Integer> nextDate = new ArrayList<Integer>();
    int cap = getMaxDay(month, year);
    int maxDays = isLeapYear(year) ? 366 : 365;
    int totalDays = daysInYearTillDate(day, month, year) + alpha;
    
    if (day + alpha <= cap) 
    {
      nextDate.add(day + alpha);
      nextDate.add(month);
      nextDate.add(year);
    }  
    else if (totalDays <= maxDays) 
    {
      int monthValue = month; 
      int dayValue = alpha;
      dayValue -= (cap - day);
      monthValue++;
      int numDaysInMonth = getMaxDay(monthValue, year);
      
      while (dayValue > numDaysInMonth) 
      {
        dayValue -= numDaysInMonth;
        monthValue++;
        numDaysInMonth = getMaxDay(monthValue, year);
      }
      
      nextDate.add(dayValue);
      nextDate.add(monthValue);
      nextDate.add(year);
    }
    else 
    {
      int dayValue = alpha;
      int yearValue = year;
      dayValue -= (maxDays - daysInYearTillDate(day, month, year));
      yearValue++;
      int numDaysInYear = maxDays;
      while (dayValue > numDaysInYear) 
      {
        dayValue -= numDaysInYear;
        yearValue++;
        numDaysInYear = isLeapYear(yearValue) ? 366 : 365;
      } 
      
      int monthValue = 1;
      int numDaysInMonth = getMaxDay(monthValue, year);
      while (dayValue > numDaysInMonth) 
      {
        dayValue -= numDaysInMonth;
        monthValue++;
        numDaysInMonth = getMaxDay(monthValue, year);
      }
      
      nextDate.add(dayValue);
      nextDate.add(monthValue);
      nextDate.add(yearValue);
    }
    
    return nextDate;
  }
  
  
  int getMaxDay(int month, int year) 
  {
    if (month == 9 || month == 4 || month == 6 || month == 11) return 30;
    
    if (month == 2) 
    {
      if (isLeapYear(year)) return 29;
      else return 28;
    }
    
    return 31;
  }
  
  
  boolean isLeapYear(int year) 
  {
    return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);    
  }
  
  
  String constructDate(int day, int month, int year) 
  {
    return (day < 10? "0"+day : day)  + "/" + (month < 10? "0"+month : month) + "/" + year;
  }
 
  
  void draw() 
  {
    if (isSufficientDiff) 
    {
        for (int i = 0; i < values.length; i++) 
        { 
          if (i >= 1)
          {
            stroke(color(200, 0, 150));
            line(pos[i].x, pos[i].y, pos[i-1].x, pos[i-1].y);
          }
          text(dates[i], pos[i].x - 55, height - margin+50); 
        }
        noStroke();
        text(maxVal, 5, margin);
        text(minVal, 5, height - margin);
        
        fill(0);
        for (int i = 0; i < values.length; i++) 
        {
          ellipse(pos[i].x, pos[i].y, 12, 12); 
        } 
    }
    else 
    {
      fill(color(255, 0, 0));
      textFont(longButtonFont);
      text("Select a wider range (>= 6)", width/3, height/2);
    }

  }
}
