import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:naukri_bloggs/components/pushable_button.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final postRef = FirebaseDatabase.instance.reference().child("Posts");
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  File? _image;
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  TextEditingController companyController = TextEditingController();
  TextEditingController roundController = TextEditingController();
  TextEditingController imptopicController = TextEditingController();
  TextEditingController descController = TextEditingController();
  String company="", rounds="", topics="";
  bool showSpinner = false;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future getGalleryImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image chosen');
      }
    });
  }

  Future getCameraImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image chosen');
      }
    });
  }

  void dialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          content: Container(
            height: 120,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    getCameraImage();
                    Navigator.pop(context);
                  },
                  child: const ListTile(
                    leading: Icon(Icons.camera),
                    title: Text('Camera'),
                  ),
                ),
                InkWell(
                  onTap: () {
                    getGalleryImage();
                    Navigator.pop(context);
                  },
                  child: const ListTile(
                    leading: Icon(Icons.photo_library_outlined),
                    title: Text('Gallery'),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    dialog(context);
                  },
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * .2,
                      width: MediaQuery.of(context).size.height * 2,
                      child: _image != null
                          ? ClipRect(
                              child: Image.file(
                                _image!.absolute,
                                width: 100,
                                height: 100,
                                fit: BoxFit.fill,
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: 100,
                              height: 100,
                              child: const Icon(
                                Icons.camera_alt,
                                color: Color(0xFF5272FF),
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: companyController,
                        minLines: 1,
                        maxLength: 35,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Company Name',
                          hintText: 'Enter Company Name',
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                          hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                          labelStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                        ),
                        onChanged: (String value) {
                          company = value;
                        },
                        validator: (value) {
                          return value!.isEmpty ? 'Enter Company Name' : null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: roundController,
                        maxLength: 20,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Number of Rounds',
                          hintText: 'Enter Number of Rounds',
                         border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                          hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                          labelStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                        ),
                        onChanged: (String value) {
                          rounds = value;
                        },
                        validator: (value) {
                          return value!.isEmpty ? 'Enter Number of Rounds' : null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: imptopicController,
                        maxLength: 200,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Important Topics',
                          hintText: 'Enter Important Topics',
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                          hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                          labelStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                        ),
                        onChanged: (String value) {
                          topics = value;
                        },
                        validator: (value) {
                          return value!.isEmpty ? 'Enter Important Topics' : null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: descController,
                        maxLength: 2000,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'More Information',
                          hintText: 'Enter Detailed Info',
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                          hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                          labelStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                PushableButton(
                  hslColor: const HSLColor.fromAHSL(1.0, 228.87, 0.7874, 0.6608),
                  height: 50,
                  title: const Text('Upload', style: TextStyle(color: Colors.white)),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        showSpinner = true;
                      });

                        try{
                          int date = DateTime.now().microsecondsSinceEpoch;
                          firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('/bloggs$date');
                          UploadTask uploadTask = ref.putFile(_image!.absolute);
                          await Future.value(uploadTask);
                          var newUrl = await ref.getDownloadURL() ;
                          final User? user = _auth.currentUser;
                          postRef.child('Post List').child(date.toString()).set({
                          'pId' : date.toString(),
                          //'pImage' : 'newUrl.toString()',
                          'pImage' : 'images/oracle.png',
                          'pTime' : date.toString(),
                          'pCompany' : companyController.text.toString(),
                          'pRound' : roundController.text.toString(),
                          'ptopics' : imptopicController.text.toString(),
                          'pDesc' : descController.text.toString(),
                          'pEmail' : user!.email.toString(),
                          'pId' : user!.uid.toString(),
                          }).then((value) {
                         toastMessage("Post Published!");
                          setState(() {
                            showSpinner = false;
                          });
                          }).onError((error, stackTrace) {
                         toastMessage(error.toString());
                          setState(() {
                            showSpinner = false;
                          });
                          });
                          }
                      catch (e) {
                        setState(() {
                          showSpinner = false;
                        });
                       toastMessage(e.toString());
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
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
      fontSize: 20.0,
    );
  }
}
