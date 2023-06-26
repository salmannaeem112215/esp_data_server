import 'package:esp_server/api/api_response.dart';
import 'package:esp_server/data/data_container.dart';
import 'package:esp_server/data/data_response.dart';

import '../headers.dart';

class DataSocketApi {
  DataSocketApi();

  static final List<WebSocketChannel> _sockets = [];

  static void informAll() {
    if (DataContainer.datas.isNotEmpty) {
      final data = DataContainer.datas[0];
      final encodedData = json.encode(data);
      for (var ws in _sockets) {
        ws.sink.add(encodedData);
      }
    }
  }

  Handler get router {
    return webSocketHandler((WebSocketChannel socket) {
      socket.stream.listen((message) async {
        final data = json.decode(message);
        print(data);
        if (data['action'] == 'LOAD') {
          socket.sink.add(json.encode(DataResponse.allData()));
        } else if (data['action'] == 'ALL') {
          socket.sink.add(json.encode(DataResponse.allData()));
        } else if (data['action'] == 'LATEST') {
          socket.sink.add(json.encode(DataResponse.getLatestData()));
        } else if (data['action'] == 'DURATION') {
          data['start'];
          data['end'];
          socket.sink.add(
            json.encode(
              DataResponse.getDuration(data['start'], data['end']),
            ),
          );
        }
      });

      _sockets.add(socket);
    });
  }
}
