import 'package:http/http.dart' show Client;
import 'package:flutter/services.dart' show rootBundle;
import 'response.dart';
import 'dart:convert';


class MovieDbClient {
  
  Client client = Client();

  Future<Response> fetch() async {
    String jsonString = await rootBundle.loadString('resources/popularity_page_1.json');
    Map r = json.decode(jsonString);
    Response response = Response.fromJson(r);
    return response;
  }
}