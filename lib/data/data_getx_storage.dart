// import 'data.dart';
// import 'package:get_storage/get_storage.dart' as gs;

// class DataGetxStorage {
//   static final box = gs.GetStorage();
//   // ...

//   static Future<void> initStorage() async {
//     await gs.GetStorage.init();
//   }

//   static void saveData(List<Data> datas) {
//     box.write('datas', datas.map((data) => data.toJson()).toList());
//   }

//   static List<Data> loadData() {
//     final List<dynamic>? dataJsonList = box.read('datas');
//     if (dataJsonList != null) {
//       print('Stored Data Found and Replaced');
//       return dataJsonList.map((dataJson) => Data.fromJson(dataJson)).toList();
//     }
//     print('No Stored Data Found');
//     return [];
//   }
// }

import 'dart:io';

import 'package:esp_server/headers.dart';

class DataFileHelper {
  static final String filePath = './data_storage.json';

  static void saveData(List<Data> datas) {
    final jsonData = datas.map((data) => data.toJson()).toList();
    final jsonString = json.encode(jsonData);
    File(filePath).writeAsStringSync(jsonString);
  }

  static List<Data> loadData() {
    final File file = File(filePath);
    if (file.existsSync()) {
      final jsonString = file.readAsStringSync();
      final jsonData = json.decode(jsonString) as List<dynamic>;
      print('reading Data from file');
      return jsonData.map((dataJson) => Data.fromJson(dataJson)).toList();
    }
    print('No File Found');
    return [];
  }
}
