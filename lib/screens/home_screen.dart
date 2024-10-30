import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:naukri_bloggs/screens/add_post.dart';
import 'package:naukri_bloggs/screens/bloggs_screen.dart';
import 'package:naukri_bloggs/screens/login_screen.dart';
import 'package:naukri_bloggs/screens/option_screen.dart';
import 'package:naukri_bloggs/screens/sockets.dart';
import 'package:page_transition/page_transition.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

    final List<String> imageUrls = [
        'images/login_screen.png',
        'images/login_screen.png',
        'images/login_screen.png',
        'images/login_screen.png',
        'images/login_screen.png',
  ];

  FirebaseAuth auth = FirebaseAuth.instance; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FadeInUp(
              duration: const Duration(milliseconds: 1000),
              child: Container(
                height: 320,
                width: double.infinity,
                padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50.0),
                    bottomLeft: Radius.circular(50.0),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    colors: [
                      Color(0xFF5272FF),
                      Color(0xFF5272FF),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "WELCOME TO NAUKRI BLOGGS!",
                        style: TextStyle(
                          wordSpacing: 3,
                          letterSpacing: 4,
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Image.asset(
                      'images/home_screen.png', // Replace with your asset image path
                      height: 250, // Adjust the height as needed
                      width: 300, // Adjust the width as needed
                    ),
                  ],
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -35),
              child: FadeInUp(
                duration: const Duration(milliseconds: 1200),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Confirm Logout"),
              content: const Text("Are you sure you want to logout?"),
              actions: <Widget>[
                TextButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text("Logout"),
                  onPressed: () {
                    auth.signOut().then((value) => {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const OptionScreen()),
                      ),
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      child: Container(
        height: 60,
        width: 60, // Square button
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: const Center(
          child: Icon(Icons.logout_sharp, color: Colors.black, size: 25),
        ),
      ),
    ),
                      Expanded(
                        child: Container(
                          height: 60,
                          padding: const EdgeInsets.only(left: 20, top: 8, right: 10),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 20.0,
                                offset: const Offset(0, 10.0),
                              )
                            ],
                            borderRadius: BorderRadius.circular(50.0),
                            color: Colors.white,
                          ),
                          child: const TextField(
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 20.0,
                              ),
                              border: InputBorder.none,
                              hintText: 'Search Company Name',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),                      
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const AddPost()),
                          );
                        },
                        child: Container(
                          height: 60,
                          width: 60, // Square button
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(Icons.add, color: Colors.black, size: 25),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
           // const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 40, right:40), // Add left padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                children: [
                  const Text(
                    "FEATURED",
                    style: TextStyle(
                      wordSpacing: 2.5,
                      letterSpacing: 2.5,
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                   Container(
      height: 200,
      child: CarouselSlider(
        options: CarouselOptions(
          height: 200,
          autoPlay: true,
          enlargeCenterPage: true,
        ),
        items: imageUrls.map((url) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                     // blurRadius: 5,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  image: DecorationImage(
                    image: NetworkImage(url),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    ),
                // const SizedBox(height: 0),
                  Center( 
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const BloggScreen()),
                            );
                          },
                          child: Container(
                            height: 80,
                            width: 80, // Square button
                            decoration: BoxDecoration(
                              color: const Color(0xFF5272FF),
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Icon(Icons.arrow_right_alt_outlined, color: Colors.white, size: 35),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                  const Text(
                    "Click here to see Bloggs",
                    style: TextStyle(
                      color:  Color(0x805272FF),
                      fontSize: 10,
                      //fontWeight: FontWeight.w300,
                    ),
                  ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget makeCard({context, startColor, endColor, image}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(type: PageTransitionType.fade, child: ViewSocks()),
        );
      },
      child: AspectRatio(
        aspectRatio: 4 / 5,
        child: Container(
          margin: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13.0),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              colors: [startColor, endColor],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 10,
                offset: const Offset(5, 10),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Center(
              child: Image.asset(image),
            ),
          ),
        ),
      ),
    );
  }
}
