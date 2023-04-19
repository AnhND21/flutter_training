import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/screens/chat/chat_screen.dart';
import 'package:get/route_manager.dart';
import 'package:path/path.dart' as p;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  TextEditingController firstNameController = TextEditingController(text: '');
  TextEditingController lastNameController = TextEditingController(text: '');

  File? _photo;
  String? image;

  final ImagePicker _picker = ImagePicker();
  final user = FirebaseAuth.instance.currentUser;

  Future<void> onCreateUser() async {
    try {
      final params =
          ModalRoute.of(context)!.settings.arguments as UserCredential;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(params.user!.uid)
          .set({
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'email': params.user!.email,
        'uid': params.user!.uid,
        'phoneNumber': params.user!.phoneNumber,
        'photoURL': image,
      }).then((_) {
        user?.updateDisplayName(
            "${firstNameController.text} ${lastNameController.text}");
        if (image != null) user?.updatePhotoURL(image);
        navigateToHomeChat();
      });
    } on FirebaseException catch (e) {
      log(e.toString());
    }
  }

  Future<void> onImagePicker() async {
    try {
      final result = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        if (result != null) {
          _photo = File(result.path);
          uploadFile();
        } else {
          // ignore: avoid_print
          print('No image selected.');
        }
      });
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = p.basename(_photo!.path);
    final destination = 'files/$fileName';

    try {
      // setState(() {
      //   isUploading = true;
      // });
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      await ref.putFile(_photo!);
      String url = (await ref.getDownloadURL()).toString();
      setState(() {
        image = url;
        // isUploading = false;
      });
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  void navigateToHomeChat() {
    Get.off(() => const ChatScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Create profile"),
        titleSpacing: 0,
        centerTitle: true,
        leading: Container(),
      ),
      body: SafeArea(
          child: WillPopScope(
        onWillPop: () async => false,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            // color: Colors.white,
            margin: const EdgeInsets.only(top: 24),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          onImagePicker();
                        },
                        child: Stack(
                          children: [
                            image != null
                                ? ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50)),
                                    child: Image.network(
                                      image!,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ))
                                : Container(
                                    width: 100,
                                    height: 100,
                                    decoration: const BoxDecoration(
                                        color: Color(0xFFF7F7FC),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50))),
                                    child: const Icon(
                                      Icons.person_outline,
                                      size: 50,
                                      color: Colors.black,
                                    ),
                                  ),
                            Positioned(
                              right: 3,
                              bottom: -2,
                              child: Container(
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: const Icon(
                                    Icons.add_circle_rounded,
                                  )),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        child: TextFormField(
                          controller: firstNameController,
                          autocorrect: false,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                          decoration: const InputDecoration(
                            hintStyle:
                                TextStyle(height: 2, color: Color(0xFFADB5BD)),
                            filled: true,
                            fillColor: Color(0xFFF7F7FC),
                            hintText: 'First Name (required)',
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        child: TextFormField(
                          controller: lastNameController,
                          autocorrect: false,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                          decoration: const InputDecoration(
                            hintStyle:
                                TextStyle(height: 2, color: Color(0xFFADB5BD)),
                            filled: true,
                            fillColor: Color(0xFFF7F7FC),
                            hintText: 'Last Name (optional)',
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    onCreateUser();
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: Color(0xFF002DE3),
                        borderRadius: BorderRadius.all(Radius.circular(32))),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
