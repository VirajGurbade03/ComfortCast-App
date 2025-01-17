// import 'package:flutter/material.dart';
// import 'package:comfortcast_1/src/fetures/model/user_model.dart';
// import 'package:comfortcast_1/src/repository/user_repository.dart';

// class OtpPage extends StatefulWidget {
//   const OtpPage({super.key});

//   @override
//   _OtpPageState createState() => _OtpPageState();
// }

// class _OtpPageState extends State<OtpPage> {
//   final TextEditingController _otpController = TextEditingController();
//   String? verificationId;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     verificationId = ModalRoute.of(context)?.settings.arguments as String?;
//   }

//   void _verifyOtp() async {
//     final otp = _otpController.text;
//     if (otp.isNotEmpty && verificationId != null) {
//       try {
//         // Assuming you get phoneNo as a string somewhere else in your code
//         final phoneNoString = ''; // Replace with actual phone number
//         final phoneNo = int.tryParse(phoneNoString) ?? 0;

//         final user = UserModel(
//           id: '', // Update with actual user ID if available
//           email: '',
//           fullName: '',
//           password: '',
//           phoneNo: phoneNo,
//           dob: '',
//         );

//         await UserRepository.instance.signInWithOtp(
//           verificationId!,
//           otp,
//           user,
//         );
//         Navigator.pushNamed(context, "/Heightpage");
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to verify OTP: $e')),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please enter OTP and try again')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 30),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text(
//                   "Enter OTP",
//                   style: TextStyle(color: Colors.white, fontSize: 24),
//                 ),
//                 const SizedBox(height: 20),
//                 TextField(
//                   controller: _otpController,
//                   decoration: InputDecoration(
//                     hintText: "Enter OTP",
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   keyboardType: TextInputType.number,
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: _verifyOtp,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green, // Button color
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: const Text("Verify OTP"),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
