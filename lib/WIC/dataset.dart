// import 'dart:io'; // Necessary for Platform checks
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart'; // Ensure this is imported only once

// class Dataset extends StatefulWidget {
//   const Dataset({super.key});

//   @override
//   State<Dataset> createState() => _DatasetState();
// }

// class _DatasetState extends State<Dataset> {
//   late WebViewController _controller;

//   @override
//   void initState() {
//     super.initState();
//     // Required for Android WebView initialization.
//     if (Platform.isAndroid) {
//       WebView.platform = SurfaceAndroidWebView();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Google Sheet View"),
//       ),
//       body: WebView(
//         initialUrl:
//             "https://docs.google.com/spreadsheets/d/1v_2KjuYt5y6bi_b7XrFSzPbRhExxXTqbSU4I0EcjQXI/edit?usp=sharing",
//         javascriptMode: JavascriptMode.unrestricted,
//         onWebViewCreated: (WebViewController webViewController) {
//           _controller = webViewController;
//         },
//       ),
//     );
//   }
// }
