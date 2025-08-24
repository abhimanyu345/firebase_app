import 'package:cargo_intern_app/models/object_model.dart';
import 'package:cargo_intern_app/services/api_service.dart';

class FakeApiService implements ApiService {
  @override
  String get baseUrl => 'https://fake.api'; // provide a dummy URL

  @override
  Future<List<ObjectModel>> fetchObjects({int page = 1}) async {
    return [
      ObjectModel(id: '1', name: 'Fake Object A', data: {"key1": "value1"}),
      ObjectModel(id: '2', name: 'Fake Object B', data: {"key2": "value2"}),
    ];
  }

  @override
  Future<ObjectModel> createObject(ObjectModel obj) async {
    return ObjectModel(id: '123', name: obj.name, data: obj.data);
  }

  @override
  Future<ObjectModel> updateObject(ObjectModel obj) async {
    return ObjectModel(id: obj.id, name: obj.name, data: obj.data);
  }

  @override
  Future<void> deleteObject(String id) async {
    // Do nothing
  }

  @override
  Future<ObjectModel> fetchObjectDetail(String id) async {
    // Return a fake object
    return ObjectModel(id: id, name: 'Fake Detail', data: {"detail": "value"});
  }
}
