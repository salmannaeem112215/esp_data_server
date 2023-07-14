/*
We have two classes
1. APi Response 
      - String  succes;
      - Payload payload;
2. Payload
      - String  message;
      - Json    data;

// API RESPONSE 
{
  'success': false/true,
  'payload': {      // Payload
    'message':"any String as commment"
    'data':{} // any Json Object
  }
}
*/

import '../headers.dart';

class ApiResponse {
  final bool success;
  final Payload payload;

  static const String success_ = 'success';
  static const String payload_ = 'payload';

  ApiResponse({
    required this.success,
    Payload? payload,
  }) : payload = payload ?? Payload();

  factory ApiResponse.fromJson(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return ApiResponse(
      success: json[success_] ?? false,
      payload: json[payload_] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      success_: success,
      payload_: payload,
    };
  }
}

class Payload {
  final String message;
  final dynamic data;

  static const String message_ = 'message';
  static const String data_ = 'data';

  Payload({
    this.message = '',
    dynamic? data,
  }) : data = data ?? {};

  factory Payload.fromJson(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return Payload(
      message: json[message_] ?? false,
      data: json[data_] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      message_: message,
      data_: data,
    };
  }
}
