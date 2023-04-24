import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_provider/app/datasource/datasource.dart';
import 'package:http/http.dart' as http;

final dio = Dio();
class RegisterProvider extends ChangeNotifier {

  RegisterRemote remote = RegisterRemote();
  bool _success = false;
  var _response;

  bool get success => _success;
  get response => _response;

  void register(String username, String password) async {
    // _response = await remote.register(username, password);
    // var path = Uri.parse("localhost:8080/user/1");
    // var responses = await http.get(path, headers: {"Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"});
    var responses = await dio.get('192.168.0.54:8080/user/1');
    // var responses = await dio.get('http://api.themoviedb.org/3/movie/popular?api_key=6460de6560376b65422bf1e31a0d4e21&language=en-US');
    print(responses);
    _success = true;
    notifyListeners();
  }
}