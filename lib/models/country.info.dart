class CountryInfo {
   String country;
   String countryCode;
   String slug;
   int newConfirmed;
   int totalConfirmed;
   int newDeaths;
   int totalDeaths;
   int newRecovered;
   int totalRecovered;
   DateTime date;
   String countryFlag;

  CountryInfo(this.country, 
  this.countryCode, 
  this.slug, 
  this.newConfirmed, 
  this.totalConfirmed, 
  this.newDeaths, 
  this.totalDeaths, 
  this.newRecovered, 
  this.totalRecovered,
  this.date,
  this.countryFlag);

   attachCountryFlag(String isoCode) {
    countryFlag = "icons/flags/png/"+ isoCode.toLowerCase() +".png";
  }

   CountryInfo.fromJson(Map json) {
  this.countryCode = json['CountryCode'];
  this.slug= json['Slug'];
  this.newConfirmed = json['NewConfirmed'];
  this.totalConfirmed = json['TotalConfirmed']; 
  this.newDeaths = json['NewDeaths'];
  this.totalDeaths = json['TotalDeaths']; 
  this.newRecovered = json['NewRecovered']; 
  this.totalRecovered = json['TotalRecovered'];
   this.date =  DateTime.parse(json['Date']);
   }
   
}