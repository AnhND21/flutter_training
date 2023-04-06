import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/screens/chat/model/user_chat.dart';
import 'package:flutter_training/screens/chat/services/firebase_auth_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:provider/provider.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  bool isLoading = false;
  bool isUploading = false;
  bool loadingScreen = true;
  TextEditingController firstNameController = TextEditingController(text: '');
  TextEditingController lastNameController = TextEditingController(text: '');
  TextEditingController phoneController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');

  String? image;
  File? file;
  final ImagePicker _picker = ImagePicker();
  final user = FirebaseAuth.instance.currentUser;
  User? userInfo = FirebaseAuth.instance.currentUser;
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  Future<void> getUserInfo() async {
    _userCollection.doc((userInfo!.uid)).get().then((DocumentSnapshot value) {
      if (value.exists) {
        final credentials =
            UserChat.fromJson(value.data() as Map<String, dynamic>);
        setState(() {
          firstNameController.text = credentials.firstName;
          emailController.text = credentials.email;
          lastNameController.text = credentials.lastName ?? '';
          phoneController.text = credentials.phoneNumber ?? '';
          image = credentials.photoURL;
          loadingScreen = false;
        });
      }
    });
  }

  Future<void> onUpdateProfile() async {
    FocusScope.of(context).unfocus();
    setState(() {
      isLoading = true;
    });
    _userCollection.doc((userInfo!.uid)).update({
      'firstName': firstNameController.text,
      'lastName': lastNameController.text,
      'phoneNumber': phoneController.text,
      'email': emailController.text,
      'photoURL': image
    }).then((value) {
      setState(() {
        isLoading = false;
      });
      user?.updateEmail(emailController.text);
      user?.updateDisplayName(
          "${firstNameController.text} ${lastNameController.text}");
      if (image != null) user?.updatePhotoURL(image);
      Navigator.pop(context);
    });
  }

  Future<void> onImagePicker() async {
    try {
      final result = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        if (result != null) {
          file = File(result.path);
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
    if (file == null) return;
    final fileName = p.basename(file!.path);
    final destination = 'files/$fileName';

    try {
      setState(() {
        isUploading = true;
      });
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      await ref.putFile(file!);
      String url = (await ref.getDownloadURL()).toString();
      setState(() {
        image = url;
        isUploading = false;
      });
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<AuthProvider>(context);
    image = userProvider.user!.photoURL;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
        titleSpacing: 0,
        centerTitle: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(CupertinoIcons.chevron_back),
        ),
      ),
      body: SafeArea(
          child: WillPopScope(
        onWillPop: () async => false,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: loadingScreen
              ? const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                )
              : Container(
                  color: Colors.transparent,
                  margin: const EdgeInsets.only(top: 24),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              InkWell(
                                onTap: () async {
                                  onImagePicker();
                                },
                                child: Stack(
                                  children: [
                                    image != null
                                        ? ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(50)),
                                            child: isUploading
                                                ? const SizedBox(
                                                    width: 100,
                                                    height: 100,
                                                    child:
                                                        CircularProgressIndicator(),
                                                  )
                                                : Image.network(
                                                    image.toString(),
                                                    width: 100,
                                                    height: 100,
                                                    fit: BoxFit.cover,
                                                  ),
                                          )
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
                                              color: Colors.grey,
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
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                decoration: const BoxDecoration(
                                    color: Color(0xFFF7F7FC),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: TextFormField(
                                  enabled: emailController.text == '',
                                  autocorrect: false,
                                  controller: emailController,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                  decoration: const InputDecoration(
                                    hintStyle: TextStyle(
                                        height: 1, color: Color(0xFFADB5BD)),
                                    hintText: 'Email',
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                decoration: const BoxDecoration(
                                    color: Color(0xFFF7F7FC),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: TextFormField(
                                  controller: firstNameController,
                                  autocorrect: false,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                  decoration: const InputDecoration(
                                    hintStyle: TextStyle(
                                        height: 1, color: Color(0xFFADB5BD)),
                                    hintText: 'First Name (required)',
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                decoration: const BoxDecoration(
                                    color: Color(0xFFF7F7FC),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: TextFormField(
                                  controller: lastNameController,
                                  autocorrect: false,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                  decoration: const InputDecoration(
                                    hintStyle: TextStyle(
                                        height: 1, color: Color(0xFFADB5BD)),
                                    hintText: 'Last Name (optional)',
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                decoration: const BoxDecoration(
                                    color: Color(0xFFF7F7FC),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: TextFormField(
                                  controller: phoneController,
                                  enabled: phoneController.text.isEmpty,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                  decoration: const InputDecoration(
                                    hintStyle: TextStyle(
                                        height: 1, color: Color(0xFFADB5BD)),
                                    hintText: 'Phone Number',
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          onUpdateProfile();
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 8),
                          padding: const EdgeInsets.all(16),
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                              color: Color(0xFF002DE3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32))),
                          child: isLoading
                              ? const SizedBox(
                                  height: 19,
                                  width: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1.5,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  'Update',
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
