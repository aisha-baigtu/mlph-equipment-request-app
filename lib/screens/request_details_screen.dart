import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RequestDetailsScreen extends StatelessWidget {
  const RequestDetailsScreen({super.key, required this.equipmentId});

  final String equipmentId;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> requests = FirebaseFirestore.instance
        .collection('equipments')
        .doc(equipmentId)
        .collection('requests')
        .snapshots();

    final DocumentReference equipment =
        FirebaseFirestore.instance.collection('equipments').doc(equipmentId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Requests'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: requests,
        builder: (context, snapshot) {
          final isConnectionWaiting =
              snapshot.connectionState == ConnectionState.waiting;
          final isConnectionFailed = snapshot.hasError;

          if (isConnectionFailed) {
            return const Text('Something went wrong.');
          }
          if (isConnectionWaiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.requireData;

          return ListView.builder(
              itemCount: data.size,
              itemBuilder: (_, index) {
                final employee = data.docs[index];
                return Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
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
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              const Text(
                                "Status: ",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                employee['status'],
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: FractionallySizedBox(
                              widthFactor: 1,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green),
                                  onPressed: () {
                                    final DocumentReference<
                                            Map<String, dynamic>>
                                        currentRequest = FirebaseFirestore
                                            .instance
                                            .collection('equipments')
                                            .doc(equipmentId)
                                            .collection('requests')
                                            .doc(employee.id);

                                    currentRequest
                                        .update({'status': 'assigned'})
                                        .then((value) =>
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Successfully assigned.'),
                                                backgroundColor: Colors.grey,
                                              ),
                                            ))
                                        .catchError((error) =>
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content:
                                                    Text('Failed to assign.'),
                                                backgroundColor: Colors.grey,
                                              ),
                                            ));

                                    equipment
                                        .update({'status': 'assigned'})
                                        .then((value) =>
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Assigned to equipment.'),
                                                backgroundColor: Colors.grey,
                                              ),
                                            ))
                                        .catchError((error) =>
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content:
                                                    Text('Failed to assign.'),
                                                backgroundColor: Colors.grey,
                                              ),
                                            ))
                                        .then(
                                            (value) => Navigator.pop(context));
                                  },
                                  child: const Text("Assign")),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: FractionallySizedBox(
                              widthFactor: 1,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red),
                                  onPressed: () {
                                    final DocumentReference currentRequest =
                                        FirebaseFirestore.instance
                                            .collection('equipments')
                                            .doc(equipmentId)
                                            .collection('requests')
                                            .doc(employee.id);

                                    currentRequest
                                        .update({'status': 'denied'})
                                        .then((value) =>
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content:
                                                    Text('Request denied.'),
                                                backgroundColor: Colors.grey,
                                              ),
                                            ))
                                        .catchError((error) =>
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text('Failed.'),
                                                backgroundColor: Colors.grey,
                                              ),
                                            ));
                                  },
                                  child: const Text("Deny")),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
