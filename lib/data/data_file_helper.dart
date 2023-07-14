/*
Class For Handling Reading And Writing Data to File 

1. filePath   // Address of File
2. saveData(List<Data>)  // will take List of Data convert each Data into Json and Store it in file 
3. List<Data> loadData() // will open file read it data is in Json format call Data.fromJson() 
                         // constructor to created Data Object and store in List at end of function
                         // that list will be returned
*/

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
