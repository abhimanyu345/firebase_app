import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/api_controller.dart';
import '../models/object_model.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';

class ObjectFormScreen extends StatefulWidget {
  final ObjectModel? editObject;

  const ObjectFormScreen({Key? key, this.editObject}) : super(key: key);

  @override
  State<ObjectFormScreen> createState() => _ObjectFormScreenState();
}

class _ObjectFormScreenState extends State<ObjectFormScreen> {
  final ApiController apiController = Get.find();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dataController = TextEditingController();
  final uuid = Uuid();

  String? jsonError; // for validation messages

  @override
  void initState() {
    super.initState();
    if (widget.editObject != null) {
      nameController.text = widget.editObject!.name;
      dataController.text = const JsonEncoder.withIndent("  ")
          .convert(widget.editObject!.data);
    }

    // Add listener for JSON validation
    dataController.addListener(validateJson);
  }

  @override
  void dispose() {
    dataController.removeListener(validateJson);
    dataController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void validateJson() {
    final text = dataController.text.trim();
    if (text.isEmpty) {
      setState(() => jsonError = null);
      return;
    }
    try {
      json.decode(text);
      setState(() => jsonError = null); // ✅ valid JSON
    } catch (e) {
      setState(() => jsonError = "Invalid JSON: ${e.toString()}"); // ❌ error
    }
  }

  void formatJson() {
    try {
      final decoded = json.decode(dataController.text);
      final formatted =
      const JsonEncoder.withIndent("  ").convert(decoded);
      setState(() {
        dataController.text = formatted;
        jsonError = null;
      });
    } catch (e) {
      // keep showing error
    }
  }

  void saveObject() {
    if (jsonError != null) {
      Get.snackbar(
        "Error",
        "Fix JSON before saving",
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      final dataMap = json.decode(dataController.text);

      final obj = ObjectModel(
        id: widget.editObject?.id ?? uuid.v4(),
        name: nameController.text.trim(),
        data: dataMap,
      );

      if (widget.editObject == null) {
        apiController.addObject(obj);
      } else {
        apiController.updateObject(obj);
      }

      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Invalid JSON format',
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.editObject != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Object' : 'Create Object'),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: const Icon(Icons.format_align_left),
            tooltip: "Format JSON",
            onPressed: formatJson,
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo.shade50, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Name field
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Object Name',
                  prefixIcon: const Icon(Icons.title, color: Colors.indigo),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // JSON field
              TextField(
                controller: dataController,
                decoration: InputDecoration(
                  labelText: 'Data (JSON)',
                  alignLabelWithHint: true,
                  prefixIcon: const Icon(Icons.data_object, color: Colors.indigo),
                  errorText: jsonError,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLines: 10,
              ),
              const SizedBox(height: 30),

              // Save button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: Icon(
                    isEditing ? Icons.update : Icons.add,
                    color: Colors.white,
                  ),
                  label: Text(
                    isEditing ? "Update Object" : "Create Object",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  onPressed: saveObject,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
