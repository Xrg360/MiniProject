import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Home',
            style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold)
          )
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Welcome to the Home Page'),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}