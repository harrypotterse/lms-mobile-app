/// email : "email"
/// phone : 1
/// full_name : "full_name"
/// password : "12345678"
/// password_confirmation : "12345678"

class BodySignUp {
  BodySignUp({
    String? email,
    String? phone,
    String? fullName,
    String? password,
    String? passwordConfirmation,
    String? type,
    String? longitude,
    String? latitude,
    String? nationCity,
    String? provinceName,
    String? cityName,
  }) {
    _email = email;
    _phone = phone;
    _fullName = fullName;
    _password = password;
    _passwordConfirmation = passwordConfirmation;
    _type = type;
    _longitude = longitude;
    _latitude = latitude;
    _nationCity = nationCity;
    _provinceName = provinceName;
    _cityName = cityName;
  }

  BodySignUp.fromJson(dynamic json) {
    _email = json['email'];
    _phone = json['phone'];
    _fullName = json['name'];
    _password = json['password'];
    _passwordConfirmation = json['password_confirmation'];
    _type = json['Type'];
    _longitude = json['longitude'];
    _latitude = json['latitude'];
    _nationCity = json['nation_city'];
    _provinceName = json['province_name'];
    _cityName = json['city_name'];
  }

  String? _email;
  String? _phone;
  String? _fullName;
  String? _password;
  String? _passwordConfirmation;
  String? _type;
  String? _longitude;
  String? _latitude;
  String? _nationCity;
  String? _provinceName;
  String? _cityName;

  BodySignUp copyWith({
    String? email,
    String? phone,
    String? fullName,
    String? password,
    String? passwordConfirmation,
    String? type,
    String? longitude,
    String? latitude,
    String? nationCity,
    String? provinceName,
    String? cityName,
  }) =>
      BodySignUp(
        email: email ?? _email,
        phone: phone ?? _phone,
        fullName: fullName ?? _fullName,
        password: password ?? _password,
        passwordConfirmation: passwordConfirmation ?? _passwordConfirmation,
        type: type ?? _type,
        longitude: longitude ?? _longitude,
        latitude: latitude ?? _latitude,
        nationCity: nationCity ?? _nationCity,
        provinceName: provinceName ?? _provinceName,
        cityName: cityName ?? _cityName,
      );

  String? get email => _email;

  String? get phone => _phone;

  String? get fullName => _fullName;

  String? get password => _password;

  String? get passwordConfirmation => _passwordConfirmation;

  String? get type => _type;

  String? get longitude => _longitude;

  String? get latitude => _latitude;

  String? get nationCity => _nationCity;

  String? get provinceName => _provinceName;

  String? get cityName => _cityName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['phone'] = _phone;
    map['name'] = _fullName;
    map['password'] = _password;
    map['password_confirmation'] = _passwordConfirmation;
    map['Type'] = _type;
    map['longitude'] = _longitude;
    map['latitude'] = _latitude;
    map['nation_city'] = _nationCity;
    map['city_name'] = _provinceName;
    map['province_name'] = _cityName;
    return map;
  }
}
