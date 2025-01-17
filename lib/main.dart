import 'dart:async';
import 'package:comfortcast_1/Pages/Female_Pages/f_clothing.dart';
import 'package:comfortcast_1/Pages/Male_Pages/clothing.dart';
import 'package:comfortcast_1/Pages/activity_page.dart';
import 'package:comfortcast_1/Pages/bmi_page.dart';
import 'package:comfortcast_1/Pages/connection.dart';
// import 'package:comfortcast_1/Pages/devices_page.dart';
import 'package:comfortcast_1/Pages/height_page.dart';
import 'package:comfortcast_1/Pages/home_page.dart';
// import 'package:comfortcast_1/Pages/infor.dart';
import 'package:comfortcast_1/WIC/intro_screan.dart';
import 'package:comfortcast_1/WIC/modeloutput.dart';
import 'package:comfortcast_1/Pages/notifi_page.dart';
import 'package:comfortcast_1/Pages/profile_page.dart';
import 'package:comfortcast_1/Pages/setting_page.dart';
import 'package:comfortcast_1/Pages/sex_page.dart';
import 'package:comfortcast_1/Pages/sign_in.dart';
import 'package:comfortcast_1/Pages/sign_up.dart';
import 'package:comfortcast_1/api/firebase_api.dart';
import 'package:comfortcast_1/src/repository/user_repository.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: unnecessary_import
import 'package:get/get_core/src/get_main.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCNjWTi5PKMYJvfo5Y4ynNMT0MiEAGaBeY',
      appId: '1:250521934280:android:10f54b7b0de7ff556548fd',
      messagingSenderId: '250521934280',
      projectId: 'comfortcast-5c2e4',
      storageBucket: 'comfortcast-5c2e4.appspot.com',
    ),
  );

  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.playIntegrity,
  );

  await FirebaseApi().initNotifications();

  // Register UserRepository with GetX
  Get.lazyPut<UserRepository>(() => UserRepository());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<SexPageState> sexPageKey = GlobalKey<SexPageState>();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ComfortCast",
      home: AuthCheck(sexPageKey: sexPageKey), // Pass the key to AuthCheck
      getPages: [
        GetPage(name: "/SignIn", page: () => const SignIn()),
        GetPage(name: "/SettingPage", page: () => const SettingsPage()),
        GetPage(
            name: "/Homepage", page: () => HomePage(sexPageKey: sexPageKey)),
        GetPage(name: "/Signup", page: () => const Signup()),
        GetPage(name: "/Clothing", page: () => const Clothing()),
        GetPage(name: "/FClothing", page: () => const FClothing()),
        GetPage(name: "/Heightpage", page: () => const HeightPage()),
        GetPage(name: "/Connection", page: () => const Connection()),
        // GetPage(name: "/DevicesPage", page: () => const DevicesPage()),
        GetPage(name: "/BMIpage", page: () => const BmiPage()),
        GetPage(name: "/Modeloutput", page: () => const Modeloutput()),
        GetPage(name: "/ActivityPage", page: () => const ActivityPage()),
        GetPage(
            name: "/NotifyPage",
            page: () => NotifiPage(sexPageKey: sexPageKey)),
        GetPage(name: "/Sexpage", page: () => SexPage(key: sexPageKey)),
        GetPage(name: '/ProfilePage', page: () => const ProfilePage()),
        GetPage(name: "/IntroScreen", page: () => const IntroScreen()),
        // GetPage(name: "/InforPage", page: () => const Infor()),
      ],
    );
  }
}

class AuthCheck extends StatelessWidget {
  final GlobalKey<SexPageState> sexPageKey;

  const AuthCheck({super.key, required this.sexPageKey});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData) {
          return HomePage(sexPageKey: sexPageKey);
        }
        return const SignIn();
      },
    );
  }
}
