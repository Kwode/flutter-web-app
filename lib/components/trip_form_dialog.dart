import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TripFormDialog extends StatefulWidget {
  const TripFormDialog({super.key});

  @override
  _TripFormDialogState createState() => _TripFormDialogState();
}

class _TripFormDialogState extends State<TripFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final vehicleController = TextEditingController();
  final driverController = TextEditingController();
  final startLocationController = TextEditingController();
  final destinationController = TextEditingController();
  DateTime? scheduledDate;
  bool isLoading = false;

  void saveTrip() async {
    if (_formKey.currentState!.validate() && scheduledDate != null) {
      setState(() => isLoading = true);

      final tripId = const Uuid().v4(); // generate unique trip ID

      await FirebaseFirestore.instance.collection('trips').add({
        'tripId': tripId,
        'driver': driverController.text,
        'vehicle': vehicleController.text,
        'route': '${startLocationController.text} → ${destinationController.text}',
        'scheduledDate': scheduledDate,
        'status': 'Active',
        'createdAt': FieldValue.serverTimestamp(),
      });

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Schedule Trip'),
      content: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTextField(driverController, 'Driver Name'),
                    _buildTextField(vehicleController, 'Vehicle'),
                    _buildTextField(startLocationController, 'Start Location'),
                    _buildTextField(destinationController, 'Destination'),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            scheduledDate == null
                                ? 'Pick Scheduled Date & Time'
                                : 'Scheduled: ${scheduledDate!.toLocal()}',
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () async {
                            final pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                const Duration(days: 365),
                              ),
                            );
                            if (pickedDate != null) {
                              final pickedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (pickedTime != null) {
                                setState(() {
                                  scheduledDate = DateTime(
                                    pickedDate.year,
                                    pickedDate.month,
                                    pickedDate.day,
                                    pickedTime.hour,
                                    pickedTime.minute,
                                  );
                                });
                              }
                            }
                          },
                        ),
                      ],
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
          onPressed: saveTrip,
          child: const Text('Save'),
        ),
      ],
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    bool isNumber = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) =>
            value == null || value.isEmpty ? 'Required' : null,
      ),
    );
  }
}
