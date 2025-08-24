import 'package:get/get.dart';
import '../models/object_model.dart';
import '../services/api_service.dart';

typedef MessageHandler = void Function(String title, String message);

class ApiController extends GetxController {
  var objects = <ObjectModel>[].obs;
  var isLoading = false.obs;

  // Use interface or base class type
  ApiService apiService;
  final MessageHandler showMessage;

  // Constructor with optional injection for testing
  ApiController({
    ApiService? apiService,
    MessageHandler? showMessage,
  })  : apiService = apiService ?? ApiService(),
        showMessage = showMessage ?? ((title, message) => Get.snackbar(title, message));

  @override
  void onInit() {
    super.onInit();
    fetchAllObjects();
  }

  Future<void> fetchAllObjects() async {
    try {
      isLoading.value = true;
      objects.value = await apiService.fetchObjects();
    } catch (e) {
      showMessage('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addObject(ObjectModel obj) async {
    try {
      final newObj = await apiService.createObject(obj);
      objects.add(newObj);
      showMessage('Success', 'Object created');
    } catch (e) {
      showMessage('Error', e.toString());
    }
  }

  Future<void> updateObject(ObjectModel obj) async {
    try {
      final updated = await apiService.updateObject(obj);
      int index = objects.indexWhere((o) => o.id == updated.id);
      if (index != -1) objects[index] = updated;
      showMessage('Success', 'Object updated');
    } catch (e) {
      showMessage('Error', e.toString());
    }
  }

  Future<void> deleteObject(String id) async {
    try {
      await apiService.deleteObject(id);
      objects.removeWhere((o) => o.id == id);
      showMessage('Success', 'Object deleted');
    } catch (e) {
      showMessage('Error', e.toString());
    }
  }
}
