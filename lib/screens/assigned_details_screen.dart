import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AssignedDetailsScreen extends StatelessWidget {
  const AssignedDetailsScreen({super.key, required this.equipmentId});

  final String equipmentId;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> assignedEmployee = FirebaseFirestore.instance
        .collection('equipments')
        .doc(equipmentId)
        .collection('requests')
        .where('status', isEqualTo: 'assigned')
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Assigned Employee"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: assignedEmployee,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong.'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.requireData;
          final employee = data.docs[0];

          return Container(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.person_outline_sharp,
                          size: 40,
                        ),
                        Text(
                          '${employee['first_name']} ${employee['last_name']}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        const Text(
                          "Employee ID: ",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          employee['employee_id'],
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        const Text(
                          "Department: ",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          employee['department'],
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        const Text(
                          "Purpose: ",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          employee['purpose'],
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        const Text(
                          "Schedule: ",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          employee['schedule'].toDate().toString(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
