import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  final String base_url = "http://daniagui.pythonanywhere.com/user/";
  String id;
  String latitude;
  String longitude;

  User(this.id, this.latitude, this.longitude) {
    this.id = id;
    this.latitude = latitude;
    this.longitude = longitude;
  }

  Future<Map<String, dynamic>> getUser() async {
    try {
      final response = await http.get(Uri.parse(base_url + this.id + "/"));
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

  Future<List> getUsers() async {
    try {
      final response = await http
          .get(Uri.parse(base_url + this.id + "/emergency_contacts/"));
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

  void setLatitude(String latitude) async {
    this.latitude = latitude;
    final uri = Uri.parse(base_url + this.id + "/latitude/patch/");
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {'latitude': this.latitude};
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    http.Response response = await http.patch(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );
    print(response.statusCode);
  }

  void setLongitude(String longitude) async {
    this.longitude = longitude;
    final uri = Uri.parse(base_url + this.id + "/longitude/patch/");
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {'longitude': this.longitude};
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    http.Response response = await http.patch(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );
    print(response.statusCode);
  }
}
