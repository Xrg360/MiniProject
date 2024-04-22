import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:miniproj/homescreen/home.dart';
import 'package:miniproj/login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Signup extends StatefulWidget {
  Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _vehicleController = TextEditingController();
  final _addressController = TextEditingController();
  final _nameController = TextEditingController();
  bool _isAmbulance = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Full Name',
              ),
            ),
            SizedBox(
              height: 12,
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Email',
                suffixText: "@gmail.com",
              ),
            ),
            SizedBox(
              height: 12,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(
              height: 12,
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Address',
              ),
            ),
            SizedBox(
              height: 12,
            ),
            TextField(
              controller: _vehicleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Vehicle Number',
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Scaffold(
                    body: LoginPage(),
                  )),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
              child: const Text('already have an account? Login'),
            ),
            Spacer(),
                        CheckboxListTile(
              title: Text('Ambulance'),
              value: _isAmbulance,
              onChanged: (bool? value) {
                setState(() {
                  _isAmbulance = value!;
                });
              },
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () async {
                try {
                  UserCredential userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: '${_emailController.text}@gmail.com',
                    password: _passwordController.text,
                  );
                  try {
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(userCredential.user!.uid)
                        .set({
                      'name': _nameController.text,
                      'email': _emailController.text,
                      'address': _addressController.text,
                      'vehicle': _vehicleController.text,
                      'isAmbulance': _isAmbulance,
                    });
                  } catch (e) {
                    print('Failed to add user: $e');
                  }

                  print(_emailController.text);
                  // ignore: avoid_print
                  print('Logged in successfully');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                  // ignore: avoid_print
                  print(userCredential.user);
                } catch (e) {
                  print(_emailController.text);
                  // ignore: avoid_print
                  print('Login failed: $e');
                }
              },
              child: const Text('Signup'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
