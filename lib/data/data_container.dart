/*
Class For Performing Functions on Data 

1.  List<Data>    // To Store Data for 24 Hours;
2.  init()        // call DataFileHelper which will load Data from File and Store in List;
3.  add(doube,double,double)  // will take values and store Data Object in List at 0 index;
                              // call function to removeExpiredData (which DateTime is Longer than 24 hours)
4.  getDuration() // To get Data of Specific Hours
5.  removeExpireData  // will check Data from last to start - if Data is longer than 24 hour remove  else break beacuse data is stored in Sequence
                      //   1 2 ---------24 25 26 
                      //   it will go from 26-1
                      //   26 is greater than 24 hours remove it  
                      //   25 is greater than 24 hours remove it
                      //   24 is grater than 25 hours--- no so loop break no need to check as after that all will be less than 24 Hours

*/

import 'package:esp_server/headers.dart';

class DataContainer {
  // get storage

  static List<Data> datas = [];

  static Future<void> init() async {
    datas = DataFileHelper.loadData();
  }

  static Data add(double temp, double pres, double humi) {
    final data = Data(temperature: temp, pressure: pres, humidity: humi);
    datas.insert(0, data);
    removeExpiredData();
    DataFileHelper.saveData(datas);
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
