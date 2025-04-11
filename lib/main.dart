import 'package:admin_dash/pages/home_screen.dart';
import 'package:admin_dash/pages/login_page.dart';
import 'package:admin_dash/pages/signup_page.dart';
import 'package:admin_dash/pages/user_management_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAhBdKftoocppn5JnemMLJevD9LKbk7WXs",
      appId: "226910423052",
      messagingSenderId: "226910423052",
      projectId: "truck-management-dd830",
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),

      routes: {
        "login": (context) => LoginPage(),
        "home": (context) => HomeScreen(),
        "signup": (context) => SignupPage(),
        "user": (context) => UserManagementPage(),
      },
    );
  }
}
