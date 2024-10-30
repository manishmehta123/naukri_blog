import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:naukri_bloggs/screens/home_screen.dart';
import 'package:naukri_bloggs/screens/option_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    final user = auth.currentUser;
    if(user!= null) {
    Timer(Duration(seconds: 3),()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen())));  
    }
    else {
     Timer(Duration(seconds: 3),()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> OptionScreen())));   
    }
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final imageHeight = size.height * 0.6; 
    final imageWidth = size.width * 0.9;   

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: imageHeight,
              width: imageWidth,
              child: const Image(
                image: AssetImage('images/naukri_bloggs-2-removebg.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
