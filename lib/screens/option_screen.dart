import 'package:flutter/material.dart';
import 'package:naukri_bloggs/components/pushable_button.dart';
import 'package:naukri_bloggs/screens/login_screen.dart';
import 'package:naukri_bloggs/screens/register_screen.dart';

class OptionScreen extends StatefulWidget {
  const OptionScreen({super.key});

  @override
  _OptionScreenState createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final imageHeight = size.height * 0.4; 
    final imageWidth = size.width * 0.7;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
              height: imageHeight,
              width: imageWidth,
                child: const Image(image: AssetImage('images/onboarding.png'),
                ),
                ),
                const SizedBox(height: 30,),
              PushableButton(
                hslColor: const HSLColor.fromAHSL(1.0, 228.87, 0.7874, 0.6608),
                height: 50,
                title: const Text('Login',style: TextStyle(color: Colors.white),),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
                },
              ),
              const SizedBox(height: 30,),
              PushableButton(
                hslColor: const HSLColor.fromAHSL(1.0, 228.87, 0.7874, 0.6608),
                height: 50,
                title: const Text('Register',style: TextStyle(color: Colors.white),),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignIn()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
