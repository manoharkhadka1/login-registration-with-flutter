import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallApi {
    // final String baseUrl = 'http://192.168.2.108/api/';
    final String baseUrl = 'https://erp.manoharkhadka.com.np/api/';
    Future<http.Response> postData(data, apiUrl) async {
      var token = await _getToken();
      var fullUrl = baseUrl + apiUrl; 
      return await http.post(
          fullUrl, 
          body: jsonEncode(data), 
          headers: _setHeaders(token)
      );
    }

     Future<http.Response> postDataWithoutToken(data, apiUrl) async {
      var fullUrl = baseUrl + apiUrl; 
      return await http.post(
          fullUrl, 
          body: jsonEncode(data),
          headers: {
            'Content-type' : 'application/json',
            'Accept' : 'application/json',
          }
      );
    }
    
    Future<http.Response> getData(apiUrl) async {
      var token = await _getToken();

      var fullUrl = baseUrl + apiUrl; 
      return await http.get(
        fullUrl, 
        headers: _setHeaders(token)
      );
    }
    
    _setHeaders(token) => {
        'Content-type' : 'application/json',
        'Accept' : 'application/json',
        'Authorization': 'Bearer ' + token
    };

    _getToken() async {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        var token = localStorage.getString('token');
        return token;
    }

    _getUser() async {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        var user = localStorage.getString('user');
        return json.decode(user);
    }
}