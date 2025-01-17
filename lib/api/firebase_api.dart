import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print("title: ${message.notification?.title}");
  print("body: ${message.notification?.body}");
  print("Payload: ${message.data}");
}

class FirebaseApi {
  final _FirebaseMessassing = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _FirebaseMessassing.requestPermission();

    final fcmToken = await _FirebaseMessassing.getToken();

    print("Token: $fcmToken");

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
