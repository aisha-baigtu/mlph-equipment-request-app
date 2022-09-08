import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equipment_request_app/shared/widgets/equipment_button.dart';
import 'package:flutter/material.dart';

class EquipmentsScreen extends StatelessWidget {
  const EquipmentsScreen({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    final String title =
        type == 'available' ? 'Available Equipments' : 'Assigned Equipments';

    final Stream<QuerySnapshot> equipments = FirebaseFirestore.instance
        .collection('equipments')
        .where('status', isEqualTo: type)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: equipments,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong.'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.requireData;

          return ListView.builder(
              itemCount: data.size,
              itemBuilder: (_, index) {
                return EquipmentButton(
                  title: data.docs[index]['name'],
                  imageUrl: data.docs[index]['image_url'],
                  id: data.docs[index].id,
                  type: type,
                );
              });
        },
      ),
    );
  }
}
