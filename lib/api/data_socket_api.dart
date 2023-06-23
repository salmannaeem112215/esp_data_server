import '../headers.dart';

class DataSocketApi {
  DataSocketApi();

  static final List<WebSocketChannel> _sockets = [];

  static void sendLatestData(WebSocketChannel ws) {
    final data = Data.data.toJson();
    final encodedData = json.encode(data);
    ws.sink.add(encodedData);
  }

  static void updateData(Data data) {
    Data.data = data;
    for (var ws in _sockets) {
      sendLatestData(ws);
    }
  }

  Handler get router {
    return webSocketHandler((WebSocketChannel socket) {
      socket.stream.listen((message) async {
        final data = json.decode(message);
        print(data);
        if (data['action'] == 'LOAD') {
          sendLatestData(socket);
        }
      });

      _sockets.add(socket);
    });
  }
}
