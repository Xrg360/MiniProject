// import 'package:flutter/material.dart';
// import 'package:miniproj/login/login.dart';

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
  
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(30.0),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Spacer(),
//               Image.asset('assets/splash.png'),
//               Text(
//                 'ACCELERT',
//                 style: TextStyle(
//                     fontSize: 36,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black),
//               ),
//               SizedBox(height: 60),
//               Container(
//                 width: 300,
//                 child: Text(
//                   "ALERTS YOU BEFORE YOU LEAVE THIS WORLD",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//               Spacer(),
//               Container(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     MaterialPageRoute route = MaterialPageRoute(
//                       builder: (context) => LoginPage(),
//                     );
//                   },
//                   child: Text(
//                     'Get Started',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.black,
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 40,
//                       vertical: 20,
//                     ),
//                     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(20), 
//                   ),
//                   )
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
