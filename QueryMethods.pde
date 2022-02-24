/* 
    Harold - 08/04/2021
    Update comments and remove bugs - Harold 12/04/2020 
    Add {state -> Abbrevation} map - Harold 13/04/2020  
*/ 

import java.util.Set;
import java.util.HashSet;
import java.util.Collections;

Map<String, String> abbrv = new HashMap<String, String>();

{
  // initialise map 
  abbrv.put("Alabama", "AL");
  abbrv.put("Alaska", "AK");
  abbrv.put("Arizona", "AZ");
  abbrv.put("Arkansas", "AR");
  abbrv.put("California", "CA");
  abbrv.put("Colorado", "CA");
  abbrv.put("Connecticut", "CT");
  abbrv.put("Delaware", "DT");
  abbrv.put("District of Columbia", "DC");
  abbrv.put("Florida", "FL");
  abbrv.put("Georgia", "GA");
  abbrv.put("Hawaii", "HI");
  abbrv.put("Idaho", "ID");
  abbrv.put("Illinois", "IL");
  abbrv.put("Indiana", "IN");
  abbrv.put("Iowa", "IA");
  abbrv.put("Kansas", "KS");
  abbrv.put("Kentucky", "KY");
  abbrv.put("Louisiana", "LA");
  abbrv.put("Maine", "ME");
  abbrv.put("Maryland", "MD");
  abbrv.put("Massachusetts", "MA");
  abbrv.put("Michigan", "MI");
  abbrv.put("Minnesota", "MN");
  abbrv.put("Mississippi", "MS");
  abbrv.put("Missouri", "MS");
  abbrv.put("Montana", "MT");
  abbrv.put("Nebraska", "NE");
  abbrv.put("Nevada", "NV");
  abbrv.put("New Hampshire", "NH");
  abbrv.put("New Jersey", "NJ");
  abbrv.put("New Mexico", "NM");
  abbrv.put("New York", "NY");
  abbrv.put("North Carolina", "NC");
  abbrv.put("North Dakota", "ND");
  abbrv.put("Ohio", "OH");
  abbrv.put("Oklahoma", "OK");
  abbrv.put("Oregon", "OR");
  abbrv.put("Pennsylvania", "PA");
  abbrv.put("Rhode Island", "RI");
  abbrv.put("South Carolina", "SC");
  abbrv.put("South Dakota", "SD");
  abbrv.put("Tennessee", "TN");
  abbrv.put("Texas", "TX");
  abbrv.put("Utah", "UT");
  abbrv.put("Vermont", "VT");
  abbrv.put("Virginia", "VA");
  abbrv.put("Washington", "WA");
  abbrv.put("Wisconsin", "WI");
  abbrv.put("Wyoming", "WY");
  abbrv.put("West Virginia", "WV");
  abbrv.put("U.S. Virgin Islands", "VI");
}

ArrayList<Integer> getNums(Map<String, Integer> areaChangeMap) 
{
  /*
      returns an ArrayList of unique map values sorted in descending order       
  */
  
  ArrayList<Integer> nums = new ArrayList<Integer>();
  Set<Integer> uniqueNums =  new HashSet<Integer>();
  
  for (Map.Entry<String, Integer> data : areaChangeMap.entrySet()) 
  {
    uniqueNums.add(data.getValue());
  }
  
  nums.addAll(uniqueNums); 
  Collections.sort(nums, Collections.reverseOrder());
  
  return nums;
} 


ArrayList<Area> getTop20Areas(ArrayList<Case> caseList, String startDate, String endDate) 
{
  /*
      returns an ArrayList of the top 20 areas with the most change in cases within the start date and end date 
  */
  
  Map<String, Integer> areaChangeMap = getAreaCasesChange(caseList, startDate, endDate);
  ArrayList<Integer> nums = getNums(areaChangeMap);                                        
  
  ArrayList<Area> top20Areas = new ArrayList<Area>();
  Set<String> seen =  new HashSet<String>();
  
  for (int num : nums) 
  {
    for (Case data : caseList) 
    { 
      String areaState = data.area+ "/" + data.state;
      if (areaChangeMap.containsKey(areaState))
      {
        int val = areaChangeMap.get(areaState);
        if (val == num && !seen.contains(areaState) && top20Areas.size() < 20) 
        {
          seen.add(areaState);
          Area result  = new Area(data.area, data.state, val);
          top20Areas.add(result);
          if (top20Areas.size() >= 20 ) break;
        } 
      }
    }      
    if (top20Areas.size() >= 20 ) break;
  } 
    
  return top20Areas;
}


boolean isWithinTimeFrame(int startDay, int startMonth, int startYear, int endDay, int endMonth, int endYear, int day, int month, int year) 
{
  /*
      takes three dates and returns if true the third date is with the range of the first two and false otherwise  
  */
  
  if (!(year <= endYear && year >= startYear)) return false;
  if (startYear == endYear) 
  {
    if (!(month <= endMonth && month >= startMonth)) return false;

    if (startMonth == endMonth && day >= startDay && day <= endDay) return true;
      
    if (month == startMonth && day >= startDay && endMonth != startMonth) return true; 
          
    if (month == endMonth && day <= endDay && endMonth != startMonth) return true; 
    
    if (month > startMonth && month < endMonth) return true;
  }  
  else 
  {
    if (year == startYear) 
    {
      if (month == startMonth && day >= startDay) return true;
      if (month > startMonth) return true;
    }
    else if (year == endYear) 
    {
      if (month == endMonth && day <= endDay) return true;
      if (month < endMonth) return true;
    }
    else return true;                                                           // we already ensured that the year is between the start and end years 
  }
  
  return false;
}


Map<String, Integer> getAreaCasesChange(ArrayList<Case> caseList, String startDate, String endDate) 
{
  /*
      returns a map of the change in number cases by area within the start and end date  
  */
  
  ArrayList dates = parseDate(startDate);
  int startDay = (int) dates.get(0);
  int startMonth = (int) dates.get(1);
  int startYear = (int) dates.get(2);
  
  dates = parseDate(endDate);
  int endDay = (int) dates.get(0);
  int endMonth = (int) dates.get(1); 
  int endYear = (int) dates.get(2);
  
  Map<String, Integer> areaChange= new HashMap<String, Integer>();
  for (Case data : caseList) 
  {
    dates = parseDate(data.date);
    int day = (int) dates.get(0);
    int month = (int) dates.get(1);
    int year = (int) dates.get(2);
    
    if (isWithinTimeFrame(startDay, startMonth, startYear, endDay, endMonth, endYear, day, month, year)) 
    {
      String val = data.area+ "/" + data.state;
      if (!areaChange.containsKey(val)) areaChange.put(val, 0);
      else areaChange.put(val, (int) areaChange.get(val) + data.cases);
    }
  }
  
  return areaChange;
}


class Area 
{
  
  String area, state;
  int flexibleParameter;
  
  Area(String area, String state, int param) 
  {
    this.area = area;
    this.state = state;
    this.flexibleParameter = param ;
  }
  
  int getValue()
  {
    return this.flexibleParameter;
  }
  
  String getString() 
  {
    return area + ", " + abbrv.get(state); 
  }
}
