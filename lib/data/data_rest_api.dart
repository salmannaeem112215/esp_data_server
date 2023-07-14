import 'package:esp_server/headers.dart';

/*
  Class For Handling Rest APi

  1. Get All Data
  2. Store Data

*/

class DataRestApi {
  DataRestApi();

  Handler get router {
    final app = Router();

    app.get('/', (Request request) async {
      return Response.ok(json.encode(DataResponse.allData()));
    });

    app.get('/<temp|.+>/<pres|.+>/<humi|.+>/',
        (Request request, String temp, String pres, String humi) async {
      try {
        return Response.ok(
          json.encode(DataResponse.addData(temp, pres, humi)),
        );
      } catch (e) {
        return Response.badRequest();
      }
    });
    // Register User

    return app;
  }
}
