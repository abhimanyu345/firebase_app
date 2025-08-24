import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Decide number of columns based on screen width
    int crossAxisCount = 2;
    if (screenWidth > 1200) {
      crossAxisCount = 4;
    } else if (screenWidth > 800) {
      crossAxisCount = 3;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        elevation: 0,
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            onPressed: () {
              AuthController.instance.logout();
            },
            icon: const Icon(Icons.logout, color: Colors.white),
            tooltip: 'Logout',
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
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.indigo.shade200,
                child: const Icon(Icons.person, size: 70, color: Colors.white),
              ),
              const SizedBox(height: 16),
              Text(
                "Welcome Back!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "You are logged in successfully 🎉",
                style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
              ),
              const SizedBox(height: 40),

              // Dashboard Cards
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1.2, // make cards more rectangular
                  ),
                  itemCount: _dashboardItems.length,
                  itemBuilder: (context, index) {
                    final item = _dashboardItems[index];
                    return GestureDetector(
                      onTap: item.onTap,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        elevation: 6,
                        shadowColor: Colors.grey.shade300,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(item.icon, size: 50, color: Colors.indigo),
                              const SizedBox(height: 16),
                              Text(
                                item.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo.shade800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardItem {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  DashboardItem({required this.title, required this.icon, required this.onTap});
}

// List of dashboard items
final List<DashboardItem> _dashboardItems = [
  DashboardItem(
    icon: Icons.list_alt,
    title: "View Objects",
    onTap: () => Get.toNamed('/objects/list'),
  ),
  DashboardItem(
    icon: Icons.add_circle,
    title: "Add Object",
    onTap: () => Get.toNamed('/objects/form'),
  ),
  DashboardItem(
    icon: Icons.info_outline,
    title: "About App",
    onTap: () => Get.snackbar("Info", "Cargo Intern App v1.0"),
  ),
  DashboardItem(
    icon: Icons.code,
    title: "GitHub",
    onTap: () async {
      const url = 'https://github.com/abhimanyu345/firebase_app';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar("Error", "Could not open GitHub URL");
      }
    },
  ),
];
