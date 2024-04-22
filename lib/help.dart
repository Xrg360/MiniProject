import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:miniproj/nearby.dart';
import 'package:permission_handler/permission_handler.dart';

class Help extends StatelessWidget {
  const Help({super.key});

  @override
  Widget build(BuildContext context) {
    DatabaseReference db = FirebaseDatabase.instance.ref('/help');
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final permissionStatus = await Permission.location.status;
                if (permissionStatus.isGranted) {
                  final Position position = await Geolocator.getCurrentPosition(
                      desiredAccuracy: LocationAccuracy.high);

                  await db.set({
                    "name": FirebaseAuth.instance.currentUser!.email,
                    "location": {
                      "latitude": position.latitude,
                      "longitude": position.longitude
                    },
                  });
                print("Latitude: ${position.latitude}");
                print("Longitude: ${position.longitude}");
                }
                print("button pressed");
              },
              child: const Text('Help'),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.black),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                minimumSize: MaterialStateProperty.all(Size(200, 200)), 
                textStyle: MaterialStateProperty.all(TextStyle(fontSize: 30)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
