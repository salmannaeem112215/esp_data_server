import '../headers.dart';

/*
  Class For Handling WEBSOCKET

  1. informAll    // send Recently Added Data to All connected App
  2. router
      a. DataResponse.actionLoad  -> will return all Data 
      b. DataResponse.actionLatest -> will return latest Data - same as above
      c. DataResponse.actionDuration -> will return list of data from a specfic period with in 24 hours

      Note! we are only using 1. informAll and actionLoad 
      1. inform all will be call when new data is Stored in List by Rest APi call by ESP device
      2. Load will be call by Mobile app when app is Started to fetch all data from server
      3. infrom all send only 1 recently Added Data to Apps . which app will append in it List 
        - so Instead of Sending All List when new Data is recived which will cost Internet 
            send only Data that is upded 

*/

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
