import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MedicalCard extends StatefulWidget {
  @override
  _MedicalCardState createState() => _MedicalCardState();
}

class _MedicalCardState extends State<MedicalCard> {
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              
              SizedBox(height: 10.0),
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    Map<String, dynamic>? data = snapshot.data?.data() as Map<String, dynamic>?;
                    if (data == null) {
                      return Text('No user logged in');
                    } else {
                      String name = data['name'];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "$name",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.medical_services, color: Colors.white),
                          ],
                        ),
                      );
                    }
                  }
                },
              ),
              SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  Text(
                    _isHidden ? '**** **** **** ****' : '1234 5678 9012 3456',
                    style: TextStyle(color: Colors.white),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(_isHidden ? Icons.visibility : Icons.visibility_off, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        _isHidden = !_isHidden;
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}