import 'package:flutter_test/flutter_test.dart';
import 'package:cargo_intern_app/controllers/api_controller.dart';
import 'package:cargo_intern_app/models/object_model.dart';
import 'package:cargo_intern_app/test/fake_api_service.dart'; // path to the fake service

void main() {
  // Ensure Flutter bindings for GetX are initialized
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ApiController tests', () {
    late ApiController controller;
    late List<String> messages;

    setUp(() {
      messages = [];

      // Inject fake service and custom message handler
      controller = ApiController(
        apiService: FakeApiService(),
        showMessage: (title, message) {
          messages.add('$title: $message');
        },
      );
    });

    test('fetchAllObjects populates objects', () async {
      await controller.fetchAllObjects();

      expect(controller.objects.length, 2);
      expect(controller.objects[0].name, 'Fake Object A');
      expect(controller.objects[1].name, 'Fake Object B');
    });

    test('addObject adds a new object', () async {
      final obj = ObjectModel(id: '', name: 'New Test', data: {"x": "y"});
      await controller.addObject(obj);

      expect(controller.objects.length, 1);
      expect(controller.objects[0].id, '123'); // comes from fake service
      expect(messages.contains('Success: Object created'), true);
    });

    test('updateObject updates an existing object', () async {
      final obj = ObjectModel(id: '1', name: 'Updated', data: {"a": "b"});
      controller.objects.add(obj);

      final updatedObj = ObjectModel(id: '1', name: 'Updated Name', data: {"a": "b"});
      await controller.updateObject(updatedObj);

      expect(controller.objects[0].name, 'Updated Name');
      expect(messages.contains('Success: Object updated'), true);
    });

    test('deleteObject removes an object', () async {
      final obj = ObjectModel(id: '1', name: 'Delete Me', data: {});
      controller.objects.add(obj);

      await controller.deleteObject('1');
      expect(controller.objects.isEmpty, true);
      expect(messages.contains('Success: Object deleted'), true);
    });
  });
}
