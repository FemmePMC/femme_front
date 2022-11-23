import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Alert {
  final String base_url = "http://daniagui.pythonanywhere.com";

  createAlert() async {
    final uri = Uri.parse(base_url + "/alert/create/");
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      'message': "Estoy en peligro ayuda",
      'user_id': 1
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    http.Response response = await http.post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;
    print(statusCode);
    print(responseBody);
  }

  Future<String> getAlert(String id) async {
    try {
      final response = await http.get(Uri.parse(base_url + "/alert/" + id));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load get user');
      }
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
}
