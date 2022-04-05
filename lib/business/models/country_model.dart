class CountryModel {
  CountryModel({
    required this.code,
    required this.name,
    this.continent,
    this.latitude,
    this.longitude,
    this.timezone,
    this.flag});

  final String code;
  final String name;
  final String? continent;
  final double? latitude;
  final double? longitude;
  final String? timezone;
  final String? flag;

  CountryModel.fromDb(Map<String, dynamic> json)
      : code = json['code'],
        name = json['name'],
        continent = json['continent'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        timezone = json['timezone'],
        flag = json['flag'];

  CountryModel.fromJson(Map<String, dynamic> json)
      : code = json['cca3'],
        name = json['name']['common'],
        continent = json['continents'][0],
        latitude = json['latlng'][0],
        longitude = json['latlng'][1],
        timezone = json['timezones'][0],
        flag = json['flags']['png'];

  Map<String, dynamic> toMapSqlite() {
    return {
      'code': code,
      'name': name,
      'continent': continent,
      'latitude': latitude,
      'longitude': longitude,
      'timezone': timezone,
      'flag': flag,
    };
  }
  
  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'name': name,
      'continent': continent,
      'latitude': latitude,
      'longitude': longitude,
      'timezone': timezone,
      'flag': flag,
    };
  }
}