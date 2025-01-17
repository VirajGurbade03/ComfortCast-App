// import 'package:flutter_blue_plus/flutter_blue_plus.dart';

// class BLEService {
//   FlutterBluePlus _flutterBlue;

//   BLEService() {
//     _flutterBlue = FlutterBluePlus.instance;
//   }

//   Future<void> connectToDevice() async {
//     // Scan for available devices
//     final devices = await _flutterBlue.scanForDevices(
//       withServices: [Guid.parse('YOUR_SERVICE_UUID')], // Replace with your ESP32 device's service UUID
//       timeout: const Duration(seconds: 10),
//     );

//     // Connect to the first device found
//     final device = devices.first;
//     await device.connect();

//     // Discover the heart rate service and characteristic
//     final heartRateService = await device.discoverService(Guid.parse('YOUR_SERVICE_UUID'));
//     final heartRateCharacteristic = await heartRateService.discoverCharacteristic(Guid.parse('YOUR_CHARACTERISTIC_UUID'));

//     // Set up the characteristic to notify when new data is available
//     await heartRateCharacteristic.setNotifyValue(true);

//     // Listen for new data
//     heartRateCharacteristic.value.listen((data) {
//       // Convert the received data to a heart rate value
//       final heartRate = data[0] + (data[1] << 8);
//       print('Received heart rate: $heartRate bpm');

//       // Update the heart rate value in your app
//       // ...
//     });
//   }
// }