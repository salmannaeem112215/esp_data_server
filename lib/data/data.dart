class Data {
  final double temperature;
  final double pressure;
  final double humidity;
  final DateTime dateTime;
  Data(
      {required this.temperature,
      required this.pressure,
      required this.humidity,
      DateTime? dt})
      : dateTime = dt ?? DateTime.now();

  static const String temperature_ = 'temperature';
  static const String pressure_ = 'pressure';
  static const String humidity_ = 'humidity';
  static const String dateTime_ = 'date_time';

  static DateTime getDateTimeFromJson(dynamic dt) {
    if (dt.runtimeType == String) {
      return DateTime.tryParse(dt) ?? DateTime(0);
    }
    return DateTime(0);
  }

  Data.fromJson(Map<String, dynamic> json)
      : temperature = json[temperature_] ?? 0,
        pressure = json[pressure_] ?? 0,
        humidity = json[humidity_] ?? 0,
        dateTime = getDateTimeFromJson(json[dateTime_]);

  Map<String, dynamic> toJson() {
    return {
      temperature_: temperature,
      pressure_: pressure,
      humidity_: humidity,
      dateTime_: dateTime.toIso8601String(),
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
}
