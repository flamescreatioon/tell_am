import 'dart:convert';
import 'package:flutter/services.dart';
import 'country.dart';

class CountryService {
  static List<Country>? _countries;

  static Future<List<Country>> loadCountries() async {
    if (_countries != null) {
      return _countries!;
    }

    try {
      final String jsonString =
          await rootBundle.loadString('assets/data/country_codes.json');
      final List<dynamic> jsonData = json.decode(jsonString);

      _countries = jsonData.map((json) => Country.fromJson(json)).toList();

      // Sort countries alphabetically by name
      _countries!.sort((a, b) => a.name.compareTo(b.name));

      return _countries!;
    } catch (e) {
      print('Error loading countries: $e');
      return [];
    }
  }

  static Country? findCountryByCode(String code) {
    if (_countries == null) return null;

    try {
      return _countries!.firstWhere(
        (country) => country.code.toLowerCase() == code.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  static Country? findCountryByDialCode(String dialCode) {
    if (_countries == null) return null;

    try {
      return _countries!.firstWhere(
        (country) => country.dialCode == dialCode,
      );
    } catch (e) {
      return null;
    }
  }
}
