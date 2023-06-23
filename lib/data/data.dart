class Data {
  double temperature = 0;
  double pressure = 0;
  double humidity = 0;

  static const String temperature_ = 'temperature';
  static const String pressure_ = 'pressure';
  static const String humidity_ = 'humidity';

  Data({this.temperature = 0, this.pressure = 0, this.humidity = 0});

  Data.fromJson(Map<String, dynamic> json)
      : temperature = json[temperature_] ?? 0,
        pressure = json[pressure_] ?? 0,
        humidity = json[humidity_] ?? 0;

  Map<String, dynamic> toJson() {
    return {
      temperature_: temperature,
      pressure_: pressure,
      humidity_: humidity,
    };
  }

  static Data? fromStrings(
      {required String temp, required String pres, required String humi}) {
    if (double.tryParse(temp) == null ||
        double.tryParse(pres) == null ||
        double.tryParse(humi) == null) {
      return null;
    }

    try {
      return Data(
        temperature: double.tryParse(temp)!,
        pressure: double.tryParse(pres)!,
        humidity: double.tryParse(humi)!,
      );
    } catch (e) {
      return null;
    }
  }

  static Data data = Data();
}
