import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/object_model.dart';

class ApiService {
  final String baseUrl = 'https://api.restful-api.dev/objects';

  // GET: fetch all objects
  Future<List<ObjectModel>> fetchObjects() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List jsonList = json.decode(response.body);
      return jsonList.map((e) => ObjectModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load objects');
    }
  }

  // GET: fetch object by ID
  Future<ObjectModel> fetchObjectDetail(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return ObjectModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load object detail');
    }
  }

  // POST: create object
  Future<ObjectModel> createObject(ObjectModel obj) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(obj.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ObjectModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create object: ${response.body}');
    }
  }

  // PUT: update object
  Future<ObjectModel> updateObject(ObjectModel obj) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${obj.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(obj.toJson()),
    );
    if (response.statusCode == 200) {
      return ObjectModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update object: ${response.body}');
    }
  }

  // DELETE: delete object
  Future<void> deleteObject(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete object: ${response.body}');
    }
  }
}
