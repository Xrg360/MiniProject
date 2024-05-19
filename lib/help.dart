import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:miniproj/medical_Card.dart';
import 'package:miniproj/nearby.dart';
import 'package:permission_handler/permission_handler.dart';

class Help extends StatelessWidget {
  const Help({super.key});

  @override
  Widget build(BuildContext context) {
    DatabaseReference db = FirebaseDatabase.instance.ref('/help');
    return Scaffold(
      appBar: AppBar(
        title: Text("ACCELERT"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              MedicalCard(),
              Spacer(),
              Spacer(),
              Align(
                  alignment: Alignment.centerLeft,
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        Map<String, dynamic>? data =
                            snapshot.data?.data() as Map<String, dynamic>?;
                        if (data == null) {
                          return Text('No user logged in');
                        } else {
                          String name = data['name'];
                          return Text(
                            "Hey, $name",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                      }
                    },
                  )),
              SizedBox(height: 20,),
              Text(
                'Need help? Press the button below to send your location to nearby users and emergency services.',
                style: TextStyle(fontSize: 15),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () async {
                  final permissionStatus = await Permission.location.status;
                  if (permissionStatus.isGranted) {
                    final Position position =
                        await Geolocator.getCurrentPosition(
                            desiredAccuracy: LocationAccuracy.high);

                    await db.set({
                      "name": FirebaseAuth.instance.currentUser!.email,
                      "location": {
                        "latitude": position.latitude,
                        "longitude": position.longitude
                      },
                      "uid": FirebaseAuth.instance.currentUser!.uid
                    });
                    print("Latitude: ${position.latitude}");
                    print("Longitude: ${position.longitude}");
                  }
                  print("button pressed");
                },
                child: const Text('Need Help?'),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width, 80)),
                  textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20)),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
