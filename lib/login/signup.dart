import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:miniproj/homescreen/home.dart';

class Signup extends StatelessWidget {
  Signup({super.key});
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
              controller: _emailController,
              decoration:  InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Email',
                suffixText: "@gmail.com",
              ),
            ),
            SizedBox(height: 12,),
            TextField(
              controller: _passwordController,
              decoration:  InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 12,),
            TextField(
              controller: _passwordController,
              decoration:  InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 12,),
            TextField(
              controller: _passwordController,
              decoration:  InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Signup()),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
              child: const Text('Don\'t have an account? Sign up'),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () async {
                try {
                  UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: '${_emailController.text}@gmail.com',
                    password: _passwordController.text,
                  );
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
              child: const Text('Login'),
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