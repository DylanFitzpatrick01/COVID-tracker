// Harold - 01/04/2021

class PieChart 
{

  ArrayList<String> areaData;
  String state;
  int totalCases;
  float arcDegree, arcRadians, currStart;
  color currColor;
  color[] palette;
  Map colorMap; 
  Map areaRadians = new HashMap <String, Float>(); 
  Map<String, Integer> localAreaMap = new HashMap<String, Integer>();

  PieChart(String st, ArrayList<Case> completeList, Map stateCasesMap) 
  {
    this.state = st;
    this.totalCases = (int) stateCasesMap.get(st);
    areaData = new ArrayList<String>();
    setAreaMap(completeList);
    setRadians();
    this.palette = new color[areaData.size()];
    colorMap = new HashMap<String, List<Integer>>();
    fillPalette();
  }


  void setAreaMap(ArrayList<Case> list) 
  {
    for (Case val : list) 
    {
      if (val.state.equals(this.state)) 
      {
        if (!localAreaMap.containsKey(val.area)) localAreaMap.put(val.area, val.cases); 
        
        else localAreaMap.put(val.area, (int) localAreaMap.get(val.area) + val.cases);
      }
    }
  }


  void setRadians() 
  {
    // populates areaData with data for the given state only 
    for (Map.Entry<String, Integer> data : localAreaMap.entrySet()) 
    {
      areaData.add(data.getKey());  
      arcDegree = ( (float) data.getValue()/totalCases) * 360;
      arcRadians = radians(arcDegree);
      areaRadians.put(data.getKey(), arcRadians);
    }
  } 


  void fillPalette() 
  {
    int r = 0, g = 10, b = 0;
    for (int i = 0; i < palette.length; i++) 
    {
      r = (int) random(0, 256);
      g = (int) random(0, 256);
      b = (int) random(0, 256);
      palette[i] = color(r, g, b);
      ArrayList<Integer> rgbList =  new ArrayList<Integer>();
      rgbList.add(r); 
      rgbList.add(g); 
      rgbList.add(b);
      colorMap.put((String) this.areaData.get(i), rgbList);
    }
  }

  Map<String, List<Integer>> getAreaColors() 
  {
    return this.colorMap;
  }

  void draw() 
  {
    currStart = 0;
    int i = 0;
    for (Map.Entry<String, Integer> data : localAreaMap.entrySet()) 
    {
      currColor = palette[i];
      fill(currColor);
      arc(width/2, height/2, 400, 400, currStart, currStart + (float) areaRadians.get(data.getKey()));
      currStart += (float) areaRadians.get(data.getKey());
      i++;
    }
  }
} 
