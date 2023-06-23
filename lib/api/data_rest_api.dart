import 'package:esp_server/headers.dart';

class DataRestApi {
  DataRestApi();

  Handler get router {
    final app = Router();

    app.get('/', (Request request) async {
      final String jsonData = json.encode(Data.data.toJson());
      return Response.ok(jsonData);
    });
    // Register User
    app.get('/<temp|.+>/<pres|.+>/<humi|.+>/',
        (Request request, String temp, String pres, String humi) async {
      final data = Data.fromStrings(temp: temp, pres: pres, humi: humi);
      if (data != null) {
        DataSocketApi.updateData(data);
        return Response.ok('Value Updated');
      } else {
        return Response.ok('Value Not Updated');
      }
    });

    return app;
  }
}
