class Global {
   int newConfirmed;
   int totalConfirmed;
   int newDeaths;
   int totalDeaths;
   int newRecovered;
   int totalRecovered;

  Global(
    this.newConfirmed, 
    this.totalConfirmed,
    this.newDeaths, 
    this.totalDeaths, 
    this.newRecovered, 
    this.totalRecovered);

    Global.fromJson(Map json) {
      this.newConfirmed = json['NewConfirmed'];
      this.totalConfirmed = json['TotalConfirmed'];
       this.newDeaths = json['NewDeaths'];
      this.totalDeaths = json['TotalDeaths'];
       this.newRecovered = json['NewRecovered'];
      this.totalRecovered = json['TotalRecovered'];
    }
}