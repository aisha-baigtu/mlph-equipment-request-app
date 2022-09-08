import 'package:equipment_request_app/screens/equipments_screen.dart';
import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  const MenuButton(
      {super.key, required this.title, required this.icon, required this.type});

  final String title;
  final Icon icon;
  final String type;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => EquipmentsScreen(type: type)),
        );
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: icon,
          ),
          Text(title)
        ],
      ),
    );
  }
}
