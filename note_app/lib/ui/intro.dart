// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:google_fonts/google_fonts.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: const Color.fromARGB(255, 252, 239, 227),
//         body: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     'NOTELY',
//                     style: GoogleFonts.getFont('Titan One',
//                         fontWeight: FontWeight.bold, fontSize: 24),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                       height: 250,
//                       width: 350,
//                       child: Lottie.asset('assets/lotties/book.json',
//                           fit: BoxFit.contain)),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       'Mindset, habits, and routines are the building blocks for success toward your wellness goals',
//                       style: GoogleFonts.nunito(
//                           fontWeight: FontWeight.w800, fontSize: 22),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: SizedBox(
//                       height: 60,
//                       child: ElevatedButton(
//                           onPressed: () {},
//                           style: ButtonStyle(
//                               backgroundColor: MaterialStateProperty.all<Color>(
//                                   const Color.fromARGB(255, 217, 97, 76)),
//                               shape: MaterialStateProperty.all<
//                                       RoundedRectangleBorder>(
//                                   RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12.0),
//                               ))),
//                           child: Text(
//                             'GET STARTED',
//                             style: GoogleFonts.nunito(
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.w800,
//                                 color: Colors.white),
//                           )),
//                     ),
//                   )
//                 ],
//               )
//             ],
//           ),
//         ));
//   }
// }
