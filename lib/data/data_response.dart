import 'package:esp_server/headers.dart';

class DataResponse {
  static const actionAdd = 'ADD';
  static const actionLoad = 'LOAD';
  static const actionAll = 'ALL';
  static const actionLatest = 'LATEST';
  static const actionDuration = 'DURATION';

  // latest Data
  static ApiResponse getLatestData() {
    if (DataContainer.datas.isEmpty) {
      return ApiResponse(
          success: false, payload: Payload(message: actionLatest));
    }
    final data = DataContainer.datas[0];
    return ApiResponse(
      success: true,
      payload: Payload(
        data: data.toJson(),
      ),
    );
  }

  // All Data
  static ApiResponse allData() {
    final datas = DataContainer.datas;
    return ApiResponse(
      success: true,
      payload: Payload(
        message: actionAll,
        data: datas.map((e) => e.toJson()).toList(),
      ),
    );
  }

  // Data Between Duration
  static ApiResponse getDuration(dynamic latestS, dynamic oldestS) {
    int latest = 24;
    int oldest = 0;

    if (latestS.runtimeType == int) {
      latest = latestS;
    } else if (latestS.runtimeType == String) {
      latest = int.tryParse(latestS) ?? 24;
    }
    if (oldestS.runtimeType == int) {
      oldest = oldestS;
    } else if (oldestS.runtimeType == String) {
      oldest = int.tryParse(oldestS) ?? 24;
    }

    final currentTime = DateTime.now();

    final datas = DataContainer.getDuration(
        currentTime.subtract(Duration(hours: latest)),
        currentTime.subtract(Duration(hours: oldest)));
    return ApiResponse(
      success: true,
      payload: Payload(
        message: actionDuration,
        data: datas.map((e) => e.toJson()).toList(),
      ),
    );
  }

  // Data Added
  static ApiResponse addData(dynamic tempD, dynamic presD, dynamic humiD) {
    double temp = -9999;
    double pres = -9999;
    double humi = -9999;
    print('HIII');
    if (tempD.runtimeType == double || tempD.runtimeType == int) {
      temp = tempD;
    } else if (tempD.runtimeType == String) {
      temp = double.tryParse(tempD) ?? -9999;
    }
    if (presD.runtimeType == double || presD.runtimeType == int) {
      pres = presD;
    } else if (presD.runtimeType == String) {
      pres = double.tryParse(presD) ?? -9999;
    }
    if (humiD.runtimeType == double || humiD.runtimeType == int) {
      humi = humiD;
    } else if (humiD.runtimeType == String) {
      humi = double.tryParse(humiD) ?? -9999;
    }

    print('HIII2');

    if (temp == -9999 || pres == -9999 || humi == -9999) {
      return ApiResponse(
        success: false,
        payload: Payload(message: actionAdd),
      );
    }

    final data = DataContainer.add(temp, pres, humi);
    DataSocketApi.informAll();
    print('HIII3');
    return ApiResponse(
      success: true,
      payload: Payload(
        message: actionAdd,
        data: data.toJson(),
      ),
    );
  }
}
