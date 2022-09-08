import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RequestFormScreen extends StatefulWidget {
  const RequestFormScreen({Key? key, required this.equipmentId})
      : super(key: key);

  final String equipmentId;

  @override
  State<RequestFormScreen> createState() => _RequestFormScreenState();
}

class _RequestFormScreenState extends State<RequestFormScreen> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final CollectionReference requests = FirebaseFirestore.instance
        .collection('equipments')
        .doc(widget.equipmentId)
        .collection('requests');

    String firstName = '';
    String lastName = '';
    String employeeId = '';
    String department = '';
    String purpose = '';
    DateTime schedule = DateTime.now();

    inputValidator(value) {
      if (value == null || value.isEmpty) {
        return 'Cannot be empty!';
      }
      return null;
    }

    resetInput() {
      setState(() {
        firstName = '';
        lastName = '';
        employeeId = '';
        department = '';
        purpose = '';
        schedule = DateTime.now();
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Request Equipment'),
        ),
        body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Employee ID', border: OutlineInputBorder()),
                validator: (value) => inputValidator(value),
                onChanged: (value) => employeeId = value,
              ),
              const Padding(padding: EdgeInsets.all(10)),
              TextFormField(
                validator: (value) => inputValidator(value),
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => firstName = value,
              ),
              const Padding(padding: EdgeInsets.all(10)),
              TextFormField(
                validator: (value) => inputValidator(value),
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => lastName = value,
              ),
              const Padding(padding: EdgeInsets.all(10)),
              TextFormField(
                validator: (value) => inputValidator(value),
                decoration: const InputDecoration(
                  labelText: 'Department',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => department = value,
              ),
              const Padding(padding: EdgeInsets.all(10)),
              TextFormField(
                validator: (value) => inputValidator(value),
                decoration: const InputDecoration(
                  labelText: 'Purpose',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => purpose = value,
              ),
              const Padding(padding: EdgeInsets.all(10)),
              InputDatePickerFormField(
                firstDate: DateTime.now(),
                lastDate: DateTime(DateTime.now().year + 5),
                onDateSubmitted: (value) => schedule = value,
                keyboardType: TextInputType.text,
              ),
              const Padding(padding: EdgeInsets.all(10)),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Processing Data...'),
                        backgroundColor: Colors.grey,
                      ),
                    );

                    requests
                        .add({
                          'employee_id': employeeId,
                          'first_name': firstName,
                          'last_name': lastName,
                          'department': department,
                          'status': 'requested',
                          'purpose': purpose,
                          'create_date': DateTime.now(),
                          'schedule': schedule,
                        })
                        .then((value) => resetInput())
                        .then((value) =>
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Request Sent!'),
                                backgroundColor: Colors.grey,
                              ),
                            ))
                        .catchError((error) =>
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Failed to submit request'),
                                backgroundColor: Colors.grey,
                              ),
                            ));
                  }
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
        ));
  }
}
