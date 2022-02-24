//to make use of this class just pass it all the data out of 
//the table for the constructor, if there is no geoid pass -1 as the geoid so
//we can identify that later on

//constructor written by Jason 23/03/21
class Case {
  String date;
  String area;
  String state;
  int geoid;
  int cases;
  String country;
  PFont caseFont;

  Case(String date, String area, String state, int geoid, int cases, String country) {
    this.date = date;
    this.area = area;
    this.state = state;
    this.geoid = geoid;
    this.cases = cases;
    this.country = country;
  }

  //all getters written by Jason 23/03/21
  String getDate() {
    return date;
  }

  String getArea() {
    return area;
  }

  String getState() {
    return state;
  }

  int getGeoid() {
    return geoid;
  }

  int getCases() {
    return cases;
  }

  String getCountry() {
    return country;
  }

  //use this method to get a String containing all the date for this case,
  //prints N/A in place of geoid if it does not exist

  //Jason 23/03/21
  String caseString() {
    if (geoid != -1) {
      return("" + date + ", " + area + ", " + state + ", " + geoid + ", " +
        cases + ", " + country);
    } else {
      return ("" + date + ", " + area + ", " + state + ", N/A" +  ", " +
        cases + ", " + country);
    }
  }
}
