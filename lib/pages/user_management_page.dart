import 'package:admin_dash/components/status_badge.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class UserManagementPage extends StatelessWidget {
  const UserManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Show the Create User dialog when clicked
    void showCustomCreateUserDialog(BuildContext context) {
      final _formKey = GlobalKey<FormState>();
      final nameController = TextEditingController();
      final emailController = TextEditingController();
      final locationController = TextEditingController();
      final ageController = TextEditingController();
      final workController = TextEditingController();
      final jurisdictionController = TextEditingController();
      String? selectedRole = 'Admin';
      bool isLoading = false;

      void createUser() async {
        if (_formKey.currentState!.validate()) {
          // Show loading indicator
          isLoading = true;

          // Generate unique user ID
          final userId = const Uuid().v1();

          // Simulate saving data (e.g., Firebase Firestore)
          await Future.delayed(Duration(seconds: 2)); // simulate loading time

          // Normally, here you would save to Firestore or your database.
          // Example:
          await FirebaseFirestore.instance.collection('users').add({
            'userId': userId,
            'name': nameController.text,
            'email': emailController.text,
            'role': selectedRole,
            'age': ageController.text,
            'jurisdiction': jurisdictionController.text,
            'location': locationController.text,
            'yearsowork': workController.text,
          });

          Navigator.pop(context);
        }
      }

      Widget buildTextField(TextEditingController controller, String label) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
            ),
            validator:
                (value) => value == null || value.isEmpty ? 'Required' : null,
          ),
        );
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Create New User'),
            content:
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            buildTextField(nameController, 'Name'),
                            buildTextField(emailController, 'Email'),
                            const SizedBox(height: 10),
                            DropdownButtonFormField<String>(
                              value: selectedRole,
                              items:
                                  <String>[
                                    'Admin',
                                    'Driver',
                                    'Customer',
                                  ].map<DropdownMenuItem<String>>((
                                    String value,
                                  ) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                              onChanged: (String? newValue) {
                                selectedRole = newValue;
                              },
                              decoration: const InputDecoration(
                                labelText: 'Role',
                                border: OutlineInputBorder(),
                              ),
                              validator:
                                  (value) =>
                                      value == null || value.isEmpty
                                          ? 'Required'
                                          : null,
                            ),
                            const SizedBox(height: 10),
                            buildTextField(locationController, 'Location'),
                            buildTextField(ageController, 'Age'),
                            buildTextField(workController, 'Years of Work'),
                            buildTextField(
                              jurisdictionController,
                              'Jurisdiction',
                            ),
                          ],
                        ),
                      ),
                    ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: createUser,
                child: const Text('Create'),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 238, 238),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Icon(
                  Icons.notification_add,
                  color: const Color.fromARGB(255, 0, 34, 61),
                ),

                SizedBox(width: 20),

                IconButton(
                  icon: Icon(Icons.logout),
                  color: const Color.fromARGB(255, 0, 34, 61),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushNamed(context, "login");
                  },
                ),
              ],
            ),
          ),
        ],
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            "User Management",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: const Color.fromARGB(255, 0, 34, 61),
            ),
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => showCustomCreateUserDialog(context),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      height: 120,
                      width: 400,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: ListTile(
                          leading: Icon(
                            Icons.add,
                            color: const Color.fromARGB(255, 0, 34, 61),
                            weight: 10,
                            size: 40,
                          ),
                          title: Text(
                            "Create User",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 0, 34, 61),
                              fontSize: 27,
                            ),
                          ),
                          subtitle: Text(
                            "Add a new admin, driver or customer",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 0, 34, 61),
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  height: 120,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.qr_code,
                      color: const Color.fromARGB(255, 0, 34, 61),
                      weight: 10,
                      size: 40,
                    ),
                    title: Text(
                      "Roles & Permissions",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 34, 61),
                        fontSize: 27,
                      ),
                    ),
                    subtitle: Text(
                      "Assign and manage user roles",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 34, 61),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  height: 120,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.history,
                      color: const Color.fromARGB(255, 0, 34, 61),
                      weight: 10,
                      size: 40,
                    ),
                    title: Text(
                      "Activity Logs",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 34, 61),
                        fontSize: 27,
                      ),
                    ),
                    subtitle: Text(
                      "View user actions and events",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 34, 61),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 50),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Admins",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 34, 61),
                    fontSize: 27,
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),

            Container(
              height: 400,
              width: 1220,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: RecentRequestsCard(),
            ),
          ],
        ),
      ),
    );
  }
}
