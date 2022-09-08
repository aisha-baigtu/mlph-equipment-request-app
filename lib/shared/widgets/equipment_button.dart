import 'package:equipment_request_app/screens/assigned_details_screen.dart';
import 'package:equipment_request_app/screens/equipment_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/flutter_image.dart';

class EquipmentButton extends StatelessWidget {
  const EquipmentButton(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.id,
      required this.type});

  final String title;
  final String imageUrl;
  final String id;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                if (type == "available") {
                  return EquipmentDetailsScreen(equipmentId: id);
                } else {
                  return AssignedDetailsScreen(equipmentId: id);
                }
              }),
            );
          },
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                width: 250,
                height: 200,
                child: Image(
                    image: NetworkImageWithRetry(imageUrl),
                    fit: BoxFit.contain,
                    errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) =>
                        const Center(
                            child: Text(
                          "Failed to load image.",
                          style: TextStyle(color: Colors.grey),
                        ))),
              ),
              Text(title),
            ],
          )),
    );
  }
}
