import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equipment_request_app/screens/request_details_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RequestsListScreen extends StatelessWidget {
  const RequestsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> availableEquipments = FirebaseFirestore.instance
        .collection('equipments')
        .where('status', isEqualTo: 'available')
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Equipments'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () => FirebaseAuth.instance.signOut(),
              child: const Text(
                "Sign Out",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: availableEquipments,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Something went wrong.');
          }
          if (snapshot.hasError) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.requireData;

          return ListView.builder(
              itemCount: data.size,
              itemBuilder: (_, index) {
                final equipment = data.docs[index];
                return Container(
                  margin: const EdgeInsets.all(5),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.all(20)),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RequestDetailsScreen(
                                equipmentId: equipment.id)));
                      },
                      child: Text(equipment['name'])),
                );
              });
        },
      ),
    );
  }
}
