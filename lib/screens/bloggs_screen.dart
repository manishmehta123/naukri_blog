import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class BloggScreen extends StatefulWidget {
  const BloggScreen({super.key});

  @override
  State<BloggScreen> createState() => _BloggScreenState();
}

class _BloggScreenState extends State<BloggScreen> {
  final dRef = FirebaseDatabase.instance.ref().child('Posts');
  TextEditingController searchcontroller = TextEditingController();
  String search = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff9fafc),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            TextFormField(
              controller: searchcontroller,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Enter Company Name',
                prefixIcon: Icon(
                  Icons.search,
                  color: Color(0xFF5272FF),
                ),
                label: Text('Search'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                ),
              ),
              onChanged: (String value) {
                setState(() {
                  search = value;
                });
              },
            ),
            Expanded(
              child: FirebaseAnimatedList(
                query: dRef.child('Post List'),
                itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                  Map post = snapshot.value as Map;
                  String temp = post['pCompany'].toString();
                  
                  if (searchcontroller.text.isEmpty) {
                    return buildPostItem(context, post);
                  } else if (temp.toLowerCase().contains(searchcontroller.text.toLowerCase())) {
                    return buildPostItem(context, post);
                  } else {
                    return const Padding(
                      padding: const EdgeInsets.only(top: 40,),
                      child: Column(
                                  children: [
                                    Text('No such Bloggs found!!',style: TextStyle(fontWeight: FontWeight.w100,fontSize: 18, color: Color(0x805272FF),),),
                                  ],
                                ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPostItem(BuildContext context, Map post) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage.assetNetwork(
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * .25,
                placeholder: 'images/naukri_bloggs-2-removebg.png',
                image: 'images/oracle.png',
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Company Name: ${post['pCompany']}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Number of Rounds: ${post['pRound']}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Text(
              'Major Topics: ${post['ptopics']}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Text(
              'More Info: ${post['pDesc']}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w200),
            ),
          ],
        ),
      ),
    );
  }
}
