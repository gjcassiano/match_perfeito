import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:match_perfeito/user/user.model.dart';

import '../api/config.dart';

Future<List<User>> getUsers() async {
  var url = Uri.parse(USER_API);
    final response = await http.get(url);
    
    if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON.
        Iterable usersJson = json.decode(response.body)['entities'];
        return usersJson.map((userJson) => User.fromJson(userJson)).toList();
    } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load users');
    }
}

Future<User> getUser(String id) async {
    var url = Uri.parse(USER_API + id);
    final response = await http.get(url);
    
    if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON.
        return User.fromJson(json.decode(response.body));
    } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load user');
    }
}

