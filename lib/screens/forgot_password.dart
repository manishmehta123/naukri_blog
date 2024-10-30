import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:naukri_bloggs/components/pushable_button.dart';
import 'package:naukri_bloggs/screens/login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
 bool showSpinner = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailcontroller = TextEditingController();
  final _formKey  =GlobalKey<FormState>();
  String email="";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final imageHeight = size.height * 0.4; 
    final imageWidth = size.width * 0.7;
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                  height: imageHeight,
                  width: imageWidth,
                  child: const Image(image: AssetImage('images/reset_pass.png'),)),
                ),
                //const SizedBox(height: 10,),
                const Text('Forgot Password',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 32,color: Color(0xFF5272FF),),),
                //const SizedBox(height: 10,),
                const Text('Enter the credentails',style: TextStyle(fontWeight: FontWeight.w100,fontSize: 12, color: Color(0x805272FF),),),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Form(
                    key: _formKey,
                    child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                        controller: emailcontroller,
                        keyboardType: TextInputType.emailAddress,  
                        decoration: const InputDecoration(
                        hintText: 'Input Email',
                        prefixIcon: Icon(Icons.email,color: Color(0xFF5272FF),),
                        label: Text('Email'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                        ), 
                        onChanged: (String value){
                          email = value;
                        },
                        validator: (value) {
                          return value!.isEmpty ? 'Enter Email' : null ;
                        },  
                        ),
                  
                        const SizedBox(height: 15,),
                  
                     PushableButton(
                      hslColor: const HSLColor.fromAHSL(1.0, 228.87, 0.7874, 0.6608),
                      height: 50,
                      title: const Text('Recover Password',style: TextStyle(color: Colors.white),),
                      onPressed: () async{
                      if(_formKey.currentState!.validate()){
                        setState(() {
                          showSpinner = true;
                        });
                        try {
  _auth.sendPasswordResetEmail(email: emailcontroller.text.toString())
    .then((value) {
      setState(() {
                          showSpinner = false;
                        });
      toastMessage('Please check your email for password reset!');
       Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
    })
    .onError((error, StackTrace) {
      toastMessage(error.toString());
      
      setState(() {
                          showSpinner = false;
                        });
    });
} catch (e) {
  toastMessage(e.toString());
}
                        catch(e){
                          print(e.toString());
                          toastMessage(e.toString());
                          setState(() {
                          showSpinner = false;
                        });
                        }
                      }  
                      },
                      ),
                      ]) ,
                    ),
                )
              ],),
          ),
        )
      ),
    );
  }
  void toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 20.0
    );
  }
}