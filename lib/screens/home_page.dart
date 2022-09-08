import 'package:equipment_request_app/shared/widgets/menu_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.all(20),
                child: Image.asset(
                  'assets/images/monstar_logo_grey.png',
                  width: 300,
                )),
            const Text(
              "Equipment Request",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 33,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 50, 20, 0),
              child: const MenuButton(
                title: 'Available Equipments',
                icon: Icon(
                  Icons.computer,
                  size: 50,
                ),
                type: "available",
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: const MenuButton(
                title: 'Assigned Equipments',
                icon: Icon(
                  Icons.person_outline_sharp,
                  size: 50,
                ),
                type: "assigned",
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: FractionallySizedBox(
                  widthFactor: .8,
                  child: ElevatedButton(
                    onPressed: () => FirebaseAuth.instance.signOut(),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        padding: const EdgeInsets.all(20)),
                    child: const Text(
                      "Sign Out",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
