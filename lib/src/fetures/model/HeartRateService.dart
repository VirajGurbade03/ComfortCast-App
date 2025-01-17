// import 'package:flutter/material.dart';

// class HeartRateSensor extends StatefulWidget {
//   const HeartRateSensor({super.key});

//   @override
//   _HeartRateSensorState createState() => _HeartRateSensorState();
// }

// class _HeartRateSensorState extends State<HeartRateSensor> {
//   final BLEService _bleService = BLEService();
//   int _heartRate = 0;

//   @override
//   void initState() {
//     super.initState();
//     _bleService.connectToDevice();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       '$_heartRate bpm',
//       style: const TextStyle(
//         color: Colors.white,
//         fontSize: 32,
//         fontWeight: FontWeight.bold,
//       ),
//     );
//   }
// }