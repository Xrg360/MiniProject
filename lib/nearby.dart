import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NearbyUser extends StatefulWidget {
  const NearbyUser({super.key});

  @override
  State<NearbyUser> createState() => _NearbyUserState();
}

class _NearbyUserState extends State<NearbyUser> {
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
                return ElevatedButton(
                  onPressed: () => _launchMaps(latitude, longitude),
                  child: Text('Navigate to ${values['name']}'),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
