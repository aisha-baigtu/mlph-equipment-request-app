import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equipment_request_app/screens/request_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/flutter_image.dart';

class EquipmentDetailsScreen extends StatelessWidget {
  const EquipmentDetailsScreen({super.key, required this.equipmentId});

  final String equipmentId;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> currentEquipment = FirebaseFirestore.instance
        .collection('equipments')
        .where(FieldPath.documentId, isEqualTo: equipmentId)
        .snapshots();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Equipment Details'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: currentEquipment,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong.'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.requireData;
          final equipment = data.docs[0];
          final specs = equipment['specifications'];

          return Container(
            margin: const EdgeInsets.all(20),
            child: ListView(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Image(
                          image: NetworkImageWithRetry(equipment['image_url']),
                          errorBuilder: (BuildContext context, Object exception,
                                  StackTrace? stackTrace) =>
                              const Text('Failed to load image.',
                                  style: TextStyle(color: Colors.grey)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            equipment['name'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
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
                          "Memory: ",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          specs['memory'],
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
                          "Storage: ",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          specs['storage'],
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
                          "Processor: ",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          specs['processor'],
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
                          "Display: ",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          specs['display'],
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
                          "OS: ",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          specs['operating_system'],
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(4),
                  child: ElevatedButton(
                    onPressed: () => {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => RequestFormScreen(
                                  equipmentId: equipmentId,
                                )),
                      )
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                    ),
                    child: const Text(
                      "Request",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
