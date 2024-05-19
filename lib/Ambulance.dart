import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class AmbulanceInterface extends StatefulWidget {
  const AmbulanceInterface({super.key});

  @override
  State<AmbulanceInterface> createState() => _AmbulanceInterfaceState();
}

class _AmbulanceInterfaceState extends State<AmbulanceInterface> {
  late Stream<DatabaseEvent> _dataSnapshot;

  @override
  void initState() {
    super.initState();
    _dataSnapshot = FirebaseDatabase.instance.reference().child('help').onValue;
  }

  Future<void> _launchMaps(double latitude, double longitude) async {
    final url = 'https://maps.google.com/?q=$latitude,$longitude';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    DatabaseReference db = FirebaseDatabase.instance.ref('/help');
    return Scaffold(
      body: Center(
        child: StreamBuilder<DataSnapshot>(
          stream: _dataSnapshot.map((event) => event.snapshot),
          builder:
              (BuildContext context, AsyncSnapshot<DataSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              Map<dynamic, dynamic>? values =
                  snapshot.data!.value as Map<dynamic, dynamic>?;
              if (values == null) {
                return Text('No value');
              } else {
                double latitude = values['location']['latitude'];
                double longitude = values['location']['longitude'];

                // Assuming you're using Firebase Authentication for user authentication
                // Get the current user's UID
                String currentUserUID = values['uid'];

                // Now, you can fetch the vehicle details from Firestore or Realtime Database
                return FutureBuilder<DocumentSnapshot>(
                  future: currentUserUID != null
                      ? FirebaseFirestore.instance
                          .collection('users')
                          .doc(currentUserUID)
                          .get()
                      : null,
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (currentUserUID == null) {
                      return Text('User not found.');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Return a loading indicator if the data is still loading
                      return CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      // Handle any errors
                      print("Error fetching user data: ${snapshot.error}");
                      return Text('Error fetching user data.');
                    }
                    if (!snapshot.hasData || !snapshot.data!.exists) {
                      // Handle case where document doesn't exist
                      return Text('User data not found.');
                    }

                    // Access the 'vehicle' field from the user document
                    Map<String, dynamic>? userData =
                        snapshot.data!.data() as Map<String, dynamic>?;

                    if (userData != null && userData.containsKey('vehicle')) {
                      String vehicleDetails = userData['vehicle'];
                      String address = userData['address'];

                      // Now you can use the vehicle details in your UI
                      return Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Spacer(),
                            Text('Vehicle details: $vehicleDetails'),
                            Text('Address details: $address'),
                            Text('Nearest Hospital: Amritha Hospital'),
                            SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: () => _launchMaps(latitude, longitude),
                              child: Text(
                                  'Navigate to ${values['name'].replaceAll('@gmail.com', '')}'),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                minimumSize: MaterialStateProperty.all(Size(
                                    MediaQuery.of(context).size.width, 60)),
                                textStyle: MaterialStateProperty.all(
                                    TextStyle(fontSize: 20)),
                              ),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () async {
                                Position currentPosition =
                                    await Geolocator.getCurrentPosition(
                                        desiredAccuracy: LocationAccuracy.high);
                                double distanceInMeters =
                                    Geolocator.distanceBetween(
                                        currentPosition.latitude,
                                        currentPosition.longitude,
                                        latitude,
                                        longitude);

                                // Assuming an average speed of 50 km/h
                                double speed = 50;
                                double eta = distanceInMeters / (speed * 1000) * 60 * 60;

                                // Update Realtime Database
                                db.update({'eta': eta.toInt()});
                              },
                              child: Text('Accept'),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                minimumSize: MaterialStateProperty.all(Size(
                                    MediaQuery.of(context).size.width, 60)),
                                textStyle: MaterialStateProperty.all(
                                    TextStyle(fontSize: 20)),
                              ),
                            ),
                            // Display the vehicle details

                            Spacer(),
                          ],
                        ),
                      );
                    } else {
                      // Handle case where userData is null or vehicle details are missing
                      return Text('User data or vehicle details not found.');
                    }
                  },
                );
              }
            }
          },
        ),
      ),
    );
  }
}
