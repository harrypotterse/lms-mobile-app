// To parse this JSON data, do
//
//     final responseLogin = responseLoginFromJson(jsonString);

import 'dart:convert';

ResponseCountry responseCountriesFromJson(String str) =>
    ResponseCountry.fromJson(json.decode(str));

String responseCountriesToJson(ResponseCountry data) => json.encode(data.toJson());

class ResponseCountry {
  List<String>? arabCountries;
  List<String>? provinces;
  List<String>? cities;

  ResponseCountry({this.arabCountries, this.provinces, this.cities});

  ResponseCountry.fromJson(Map<String, dynamic> json) {
    arabCountries = json['arab_countries'].cast<String>();
    provinces = json['provinces'].cast<String>();
    cities = json['cities'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['arab_countries'] = arabCountries;
    data['provinces'] = provinces;
    data['cities'] = cities;
    return data;
  }
}
