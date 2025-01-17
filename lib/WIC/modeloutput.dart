import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Modeloutput extends StatefulWidget {
  const Modeloutput({super.key});

  @override
  State<Modeloutput> createState() => _ModeloutputState();
}

class _ModeloutputState extends State<Modeloutput> {
  double _predictedValue = 0.0; // Initialize with 0.0
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    // Listen to changes in the '/Thermal Comfort/Predicted' node in Firebase
    _databaseRef.child('/D1/Model Output').onValue.listen((event) {
      final newValue = event.snapshot.value;
      if (newValue != null) {
        setState(() {
          // Handle value as num and convert to double if necessary
          _predictedValue = (newValue is num) ? newValue.toDouble() : 0.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Model Output Status'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Predicted Value:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              _predictedValue.toString(), // Convert double to String
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
