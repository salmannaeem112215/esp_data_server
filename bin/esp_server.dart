import 'dart:io';

import 'package:esp_server/headers.dart';

void main(List<String> arguments) async {
  // Connect and load collection
  final app = Router();

  // Create routes
  app.mount('/ws', DataSocketApi().router);
  app.mount('/data', DataRestApi().router);

  // Listen for incoming connections
  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(handleCors())
      .addHandler(app);

  withHotreload(() => serve(handler, InternetAddress.anyIPv4, 8090));

  print('Server running at 8090');
}
