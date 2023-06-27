import '../headers.dart';

class DataSocketApi {
  DataSocketApi();

  static final List<WebSocketChannel> _sockets = [];

  static void informAll() {
    if (DataContainer.datas.isNotEmpty) {
      final data = DataContainer.datas[0];
      final apiRes = ApiResponse(
          success: true,
          payload: Payload(message: DataResponse.actionAdd, data: data));
      final encodedApiRes = json.encode(apiRes);
      for (var ws in _sockets) {
        ws.sink.add(encodedApiRes);
      }
    }
  }

  Handler get router {
    return webSocketHandler((WebSocketChannel socket) {
      socket.stream.listen((message) async {
        final data = json.decode(message);
        if (data['action'] == DataResponse.actionLoad) {
          socket.sink.add(
            json.encode(DataResponse.allData()),
          );
        } else if (data['action'] == DataResponse.actionAll) {
          socket.sink.add(
            json.encode(DataResponse.allData()),
          );
        } else if (data['action'] == DataResponse.actionLatest) {
          socket.sink.add(
            json.encode(DataResponse.getLatestData()),
          );
        } else if (data['action'] == DataResponse.actionDuration) {
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
