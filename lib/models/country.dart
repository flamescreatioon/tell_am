class Country {
  final String name;
  final String dialCode;
  final String code;

  Country({required this.name, required this.dialCode, required this.code});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'],
      dialCode: json['dial_code'],
      code: json['code'],
    );
  }

  String get flagEmoji {
    // Converts country code to regional indicator symbols
    return String.fromCharCodes(
      code.toUpperCase().codeUnits.map((c) => 0x1F1E6 + c - 65),
    );
  }
}
