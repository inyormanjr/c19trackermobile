class Country {
  String country;
  String slug;
  String iso2;

  Country(this.country, this.slug, this.iso2);

  Country.fromJson(Map json) {

    this.country = json['Country'];
    this.slug = json['Slug'];
    this.iso2 = json['ISO2'];

  }
  
}