import 'package:flutter_test/flutter_test.dart';
import 'package:cargo_intern_app/models/object_model.dart';
import 'package:cargo_intern_app/services/api_service.dart';

class FakeApiService extends ApiService {
  @override
  Future<List<ObjectModel>> fetchObjects({int page = 1}) async {
    // Instead of calling real API, return fake data
    return [
      ObjectModel(id: '1',
        name: 'Fake Object A',
        data: {"key1": "value1", "key2": "value2"},),
      ObjectModel(id: '2',
        name: 'Fake Object B',
        data: {"foo": "bar"},),
    ];
  }
}

void main() {
  test('ApiService.fetchObjects returns fake objects', () async {
    final api = FakeApiService();

    final result = await api.fetchObjects();

    expect(result, isA<List<ObjectModel>>());
    expect(result.length, 2);
    expect(result.first.name, 'Fake Object A');
  });
}
