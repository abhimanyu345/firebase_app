import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/api_controller.dart';
import '../models/object_model.dart';
import 'object_detail_screen.dart';
import 'object_form_screen.dart';

class ObjectListScreen extends StatefulWidget {
  @override
  _ObjectListScreenState createState() => _ObjectListScreenState();
}

class _ObjectListScreenState extends State<ObjectListScreen> {
  final ApiController apiController = Get.find();

  @override
  void initState() {
    super.initState();
    apiController.fetchAllObjects(); // fetch objects on screen load
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Objects'),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            tooltip: "Refresh",
            onPressed: () => apiController.fetchAllObjects(),
          ),
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            tooltip: "Add Object",
            onPressed: () => Get.to(() => ObjectFormScreen()),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo.shade50, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Obx(() {
          if (apiController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          if (apiController.objects.isEmpty) {
            return Center(
              child: Text(
                'No objects found 😕',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: apiController.objects.length,
            itemBuilder: (context, index) {
              final ObjectModel obj = apiController.objects[index];
              return GestureDetector(
                onTap: () {
                  Get.to(() => ObjectDetailScreen(object: obj));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigo.shade100,
                      child: Icon(Icons.widgets, color: Colors.indigo),
                    ),
                    title: Text(
                      obj.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo.shade800,
                      ),
                    ),
                    subtitle: Text(
                      "ID: ${obj.id}",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
