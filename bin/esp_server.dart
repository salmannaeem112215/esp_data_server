/*
  1. Load Data From File 
  2.  Create Server and add two endpoints
      a.  /ws       websocket
      b.  /data     Rest Api
  3.  Part of Server
  4.  withHotreload - help us for coding server, 
                      hot reload means when something changed in code 
                      on save it will restart the server automatically
  5.  Server avaliable at Port 8090 of computer
     Port is like a Process . Each Process has it unique PortID 
     for our Server we use 8090
     ..... if you open calculator in windows it is also a process 

*/

import 'dart:io';
import 'package:esp_server/headers.dart';

void main(List<String> arguments) async {
  DataContainer
      .init(); // Read json File and Load Data - if not present empty list

  final app = Router();

  // Create routes
  app.mount('/ws', DataSocketApi().router); // websocket
  app.mount('/data', DataRestApi().router); // rest api

  // Listen for incoming connections        // creating Server seetings
  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(handleCors())
      .addHandler(app);

  // server at PORT/Process 8090
  withHotreload(
    () => serve(handler, InternetAddress.anyIPv4, 8090),
  );

  print('Server running at 8090');
}
