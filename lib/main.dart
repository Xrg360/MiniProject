import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:miniproj/login/login.dart';
import 'package:miniproj/login/signup.dart';
import 'package:miniproj/homescreen/home.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Login',
            style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold)
          )
        ),
      ),
      body: Home()
    );
  }
}