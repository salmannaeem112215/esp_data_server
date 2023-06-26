import 'package:esp_server/api/api_response.dart';
import 'package:esp_server/data/data_container.dart';
import 'package:esp_server/headers.dart';

import '../data/data_response.dart';

class DataRestApi {
  DataRestApi();

  Handler get router {
    final app = Router();

    app.get('/', (Request request) async {
      return Response.ok(json.encode(DataResponse.allData()));
    });

    app.get('/<hoursS|.+>/<hoursE|.+>/',
        (Request request, String hoursS, String hoursE) async {
      try {
        return Response.ok(
          json.encode(
            DataResponse.getDuration(hoursS, hoursE),
          ),
        );
      } catch (e) {
        print('Error $e');
        return Response.badRequest();
      }
    });

    app.post('/<temp|.+>/<pres|.+>/<humi|.+>/',
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
