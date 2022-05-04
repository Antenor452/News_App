import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/helpers/response.dart';

const String apiKey ='11b62771f18e40dc9cd26a7f1d7f02f8';


Future<Response> fetchResponse(String uri) async{
  print('start');
  print(uri+apiKey);
  final response = await http.get(Uri.parse(uri+apiKey));

  if(response.statusCode ==200){
    return Response.fromJson(jsonDecode(response.body));
  }
  else{
    throw Exception('Failed to load Respone');
  }
}