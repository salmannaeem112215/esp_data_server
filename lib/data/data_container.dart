import 'data.dart';

class DataContainer {
  static List<Data> datas = [];

  static Data add(double temp, double pres, double humi) {
    final data = Data(temperature: temp, pressure: pres, humidity: humi);
    datas.insert(0, data);
    removeExpiredData();
    return data;
  }

  static List<Data> getDuration(DateTime latest, DateTime oldest) {
    List<Data> result = [];
    for (int i = 0; i < datas.length; i++) {
      if (datas[i].dateTime.isAfter(oldest) &&
          datas[i].dateTime.isBefore(latest)) {
        result.add(datas[i]);
      } else {
        break;
      }
    }
    return result;
  }

  static void removeExpiredData() {
    // Get the current time
    DateTime currentTime = DateTime.now();

    // Calculate the expiry time (1 day ago)
    DateTime expiryTime = currentTime.subtract(Duration(days: 1));

    for (int i = datas.length - 1; i >= 0; i--) {
      if (datas[i].dateTime.isBefore(expiryTime)) {
        datas.removeAt(i);
      } else {
        break;
      }
    }
  }
}
