// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tadween/firebase_options.dart';
import 'package:tadween/generated/l10n.dart';
import 'package:tadween/pages/home_page.dart';
import 'package:tadween/pages/welcom_page.dart';
// import 'package:supabase/supabase.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  //  await Supabase.initialize(
  //   url: "https://kwlrywkbahxpynfuqozh.supabase.co",
  //   anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imt3bHJ5d2tiYWh4cHluZnVxb3poIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzgyNDczMDAsImV4cCI6MjA1MzgyMzMwMH0.LMtm3YSxoBH5BxxJdv6dgkyof0_cLzGFqYhtvax8EuA",
  // );
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({ super.key });

  @override
  State<MyApp> createState() => __MyAppState();
}

class __MyAppState extends State<MyApp> {
  @override
  void initState() {
   FirebaseAuth.instance
  .authStateChanges()
  .listen((User ? user) {
    if (user == null) {
      print('=====================================================User is currently signed out!');
    } else {
      print('=====================================================User is signed in!');
    }
  });
    super.initState();
  }
  
  @override





  
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale("en"),
       localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
            ],
             supportedLocales: S.delegate.supportedLocales,
         
         home: AnimatedSplashScreen(
      splash: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Image(image: AssetImage('images/list.png')) ,
          SizedBox(width: 10,)
         , Text("Tadween" , style: TextStyle(
          fontSize: 40,
          color: Colors.white
        ),)],),
      ),
      nextScreen: (FirebaseAuth.instance.currentUser != null && FirebaseAuth.instance.currentUser!.emailVerified) ? HomePage() : WelcomPage() ,
      splashTransition: SplashTransition.slideTransition,
      animationDuration: Duration(milliseconds: 2000),
      backgroundColor: Colors.white10,
      curve: Curves.easeInOutCubic,

      // pageTransitionType: PageTransitionType.scale,
    ),
            // home: WelcomPage(),
        // home: (FirebaseAuth.instance.currentUser != null && FirebaseAuth.instance.currentUser!.emailVerified) ? HomePage() : WelcomPage(),
    );
  }
} 