import 'package:admin_dash/components/status_badge.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  State<UserManagementPage> createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
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
      final statusController = TextEditingController();
      String? selectedRole = 'Admin';
      bool isLoading = false;

      void createUser() async {
        if (_formKey.currentState!.validate()) {
          // Show loading indicator
          setState(() => isLoading = true);

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
            'status': statusController.text,
          });

          // Log the user creation in the activity_logs collection
          await FirebaseFirestore.instance.collection('activity_logs').add({
            'userId': userId,
            'action': 'User Created',
            'name': nameController.text,
            'role': selectedRole,
            'timestamp': Timestamp.now(),
            'performedBy':
                FirebaseAuth.instance.currentUser?.uid ?? 'Unknown Admin',
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
                            buildTextField(statusController, 'Status'),
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
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => const RolesPermissionsDialog(),
                    );
                  },
                  child: Container(
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
                ),

                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => const ActivityLogsDialog(),
                    );
                  },
                  child: Container(
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

class RolesPermissionsDialog extends StatefulWidget {
  const RolesPermissionsDialog({super.key});

  @override
  _RolesPermissionsDialogState createState() => _RolesPermissionsDialogState();
}

class _RolesPermissionsDialogState extends State<RolesPermissionsDialog> {
  final Map<String, String> updatedRoles = {};

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 600,
        height: 600,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final users = snapshot.data!.docs;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Manage Roles & Permissions",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user =
                            users[index].data() as Map<String, dynamic>;
                        final docId = users[index].id;
                        String currentRole = user['role'] ?? '';

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(user['name'] ?? 'No Name'),
                            subtitle: Text('Role: $currentRole'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                DropdownButton<String>(
                                  value: updatedRoles[docId] ?? currentRole,
                                  items:
                                      ['Admin', 'Driver', 'Customer'].map((
                                        role,
                                      ) {
                                        return DropdownMenuItem(
                                          value: role,
                                          child: Text(role),
                                        );
                                      }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      updatedRoles[docId] =
                                          value ?? currentRole;
                                    });
                                  },
                                ),
                                const SizedBox(width: 8),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    _confirmDeleteUser(context, docId);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Close the dialog without saving changes
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          // Save the updated roles to Firestore
                          await _saveChanges();
                          Navigator.pop(
                            context,
                          ); // Close the dialog after saving
                        },
                        child: const Text("Save Changes"),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _saveChanges() async {
    try {
      // Update the roles in Firestore for each user
      updatedRoles.forEach((docId, newRole) async {
        // Get the current user's role from Firestore
        final userDoc =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(docId)
                .get();
        final currentRole = userDoc['role'] ?? 'Unknown Role';

        // Save the updated role in Firestore
        await FirebaseFirestore.instance.collection('users').doc(docId).update({
          'role': newRole,
        });

        // Log the activity in the activity_logs collection
        await FirebaseFirestore.instance.collection('activity_logs').add({
          'userId': docId,
          'action': 'Role Updated',
          'oldRole': currentRole,
          'newRole': newRole,
          'timestamp': Timestamp.now(),
          'performedBy':
              FirebaseAuth.instance.currentUser?.uid ?? 'Unknown Admin',
        });
      });
    } catch (e) {
      // Handle any errors that occur during the update process
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  void _confirmDeleteUser(BuildContext context, String docId) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Delete User"),
            content: const Text("Are you sure you want to delete this user?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Get user info before deletion (to log the action)
                  final userDoc =
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(docId)
                          .get();
                  final userName = userDoc['name'];
                  final userRole = userDoc['role'];

                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(docId)
                      .delete();

                  // Log the user deletion in the activity_logs collection
                  await FirebaseFirestore.instance
                      .collection('activity_logs')
                      .add({
                        'userId': docId,
                        'action': 'User Deleted',
                        'name': userName,
                        'role': userRole,
                        'timestamp': Timestamp.now(),
                        'performedBy':
                            FirebaseAuth.instance.currentUser?.uid ??
                            'Unknown Admin',
                      });

                  Navigator.pop(context); // Close confirmation
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text("Delete"),
              ),
            ],
          ),
    );
  }
}

class ActivityLogsDialog extends StatelessWidget {
  const ActivityLogsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 600,
        height: 600,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance
                    .collection('activity_logs')
                    .orderBy('timestamp', descending: true)
                    .limit(10) // Show the 10 most recent activity logs
                    .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final logs = snapshot.data!.docs;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Activity Logs",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: logs.length,
                      itemBuilder: (context, index) {
                        final log = logs[index].data() as Map<String, dynamic>;
                        final action = log['action'] ?? 'No Action';
                        final userId = log['userId'] ?? 'Unknown User';
                        final oldRole = log['oldRole'] ?? 'No Old Role';
                        final newRole = log['newRole'] ?? 'No New Role';
                        final timestamp =
                            (log['timestamp'] as Timestamp).toDate();
                        final performedBy =
                            log['performedBy'] ?? 'Unknown Admin';

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text('$action: $userId'),
                            subtitle: Text(
                              'From: $oldRole to: $newRole\nTimestamp: ${timestamp.toLocal()}\nPerformed by: $performedBy',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                        },
                        child: const Text("Close"),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
