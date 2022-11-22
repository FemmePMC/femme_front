import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  final String base_url = "http://daniagui.pythonanywhere.com";

  Future<Map<String, dynamic>> getUser() async {
    try {
      final response = await http.get(Uri.parse(base_url + "/user/1"));
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

  Future<Map<String, dynamic>> getUserNotification(String id_user) async {
    try {
      final response = await http.get(Uri.parse(base_url + "/user/" + id_user));
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
      final response =
          await http.get(Uri.parse(base_url + "/user/1/emergency_contacts"));
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

  Future<List> getNotifications() async {
    try {
      final response = await http.get(Uri.parse(base_url + "/user/1/alerts/"));
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
