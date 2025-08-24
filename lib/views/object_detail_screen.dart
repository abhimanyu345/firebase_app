import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/api_controller.dart';
import '../models/object_model.dart';
import 'object_form_screen.dart';

class ObjectDetailScreen extends StatelessWidget {
  final ObjectModel object;
  final ApiController apiController = Get.find();

  ObjectDetailScreen({required this.object});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(object.name),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            tooltip: "Edit Object",
            onPressed: () => Get.to(() => ObjectFormScreen(editObject: object)),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            tooltip: "Delete Object",
            onPressed: () {
              Get.defaultDialog(
                title: 'Confirm Delete',
                middleText: 'Are you sure you want to delete this object?',
                textConfirm: 'Yes',
                textCancel: 'No',
                confirmTextColor: Colors.white,
                buttonColor: Colors.red,
                onConfirm: () {
                  apiController.deleteObject(object.id);
                  Get.back(); // close dialog
                  Get.back(); // go back to list
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
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
              // Top card with icon + title
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.indigo.shade100,
                        child: Icon(Icons.widgets, size: 40, color: Colors.indigo),
                      ),
                      SizedBox(height: 16),
                      Text(
                        object.name,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo.shade800,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "ID: ${object.id}",
                        style: TextStyle(color: Colors.grey[700], fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Data card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Object Data",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),
                      Divider(),
                      SizedBox(height: 8),
                      Text(
                        object.data.toString(),
                        style: TextStyle(fontSize: 15, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
