import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobiresto/screens/login_screens.dart';
import 'package:mobiresto/screens/splashscreen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mobi-Resto App',
      theme: ThemeData(
        // textTheme: Theme.of(context).textTheme.apply(bodyColor: primaryColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(),
    );
  }
}
