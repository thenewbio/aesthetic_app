import 'dart:io';

import 'package:aesthetic_app/models/movie_data.dart';
import 'package:aesthetic_app/screens/onboarding_screen.dart';
import 'package:aesthetic_app/screens/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'providers/auth_providers.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Hive.initFlutter();
  // Register Adapter
  Hive.registerAdapter(MovieDataAdapter());
  await Hive.openBox<MovieData>('moviedata');
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  MyApp({Key? key, required this.prefs}) : super(key: key);

  // final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
            create: (_) => AuthProvider(
                signIn: GoogleSignIn(),
                firebaseAuth: FirebaseAuth.instance,
                firestore: this.firebaseFirestore,
                prefs: prefs)),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AnimatedSplashScreen(),
      ),
    );
  }
}
