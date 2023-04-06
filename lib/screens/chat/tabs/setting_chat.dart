import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/screens/chat/model/user_chat.dart';
import 'package:flutter_training/screens/chat/services/firebase_auth_provider.dart';
import 'package:provider/provider.dart';

class SettingChatScreen extends StatefulWidget {
  const SettingChatScreen({super.key});

  @override
  State<SettingChatScreen> createState() => _SettingChatScreenState();
}

class _SettingChatScreenState extends State<SettingChatScreen> {
  User? userInfo = FirebaseAuth.instance.currentUser;
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  UserChat? user;

  @override
  void initState() {
    super.initState();
    Future(() => getUserInfo());
  }

  Future<void> getUserInfo() async {
    _userCollection.doc((userInfo!.uid)).get().then((DocumentSnapshot value) {
      if (value.exists) {
        final credentials =
            UserChat.fromJson(value.data() as Map<String, dynamic>);
        setState(() {
          user = credentials;
        });
      }
    });
  }

  Future<void> logout() async {
    AuthProvider().signOut();
    Navigator.of(context).popUntil(ModalRoute.withName('/chat_welcome'));
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('More'),
          titleSpacing: 24,
          centerTitle: false,
          leadingWidth: 0,
          leading: Container(),
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            margin: const EdgeInsets.only(top: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      authProvider.user?.photoURL != null
                          ? ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25)),
                              child: Image.network(
                                authProvider.user!.photoURL.toString(),
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              width: 50,
                              height: 50,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  color: Color(0xFFEDEDED),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              child: const Icon(
                                Icons.person_2_outlined,
                                color: Colors.grey,
                              ),
                            ),
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/update_profile');
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                authProvider.user?.displayName ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              Text(
                                authProvider.user?.email ??
                                    authProvider.user?.phoneNumber ??
                                    '',
                                style: const TextStyle(
                                    height: 1.5, color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      )),
                      const Icon(
                        CupertinoIcons.chevron_right,
                        size: 20,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  menuAction(context, 'Account', CupertinoIcons.person,
                      onPressed: () {
                    Navigator.pushNamed(context, '/update_profile');
                  }),
                  menuAction(context, 'Chats', CupertinoIcons.chat_bubble),
                  const SizedBox(
                    height: 16,
                  ),
                  menuAction(context, 'Appearance', CupertinoIcons.brightness),
                  menuAction(context, 'Notification', CupertinoIcons.bell),
                  menuAction(context, 'Privacy', Icons.warning_amber),
                  menuAction(context, 'Data Usage', CupertinoIcons.folder),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 0.5,
                    color: Colors.grey.shade300,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  menuAction(context, 'Help', CupertinoIcons.info_circle),
                  menuAction(
                      context, 'Invite Your Friends', CupertinoIcons.mail),
                  menuAction(context, 'Logout', Icons.logout_rounded,
                      color: Colors.red, isShowRightIcon: false, onPressed: () {
                    logout();
                  }),
                ],
              ),
            ),
          ),
        ));
  }
}

Widget menuAction(BuildContext context, String title, IconData icon,
    {Color? color, bool? isShowRightIcon = true, Function? onPressed}) {
  return InkWell(
    onTap: () {
      if (onPressed != null) {
        onPressed();
      }
    },
    child: Container(
      // padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: color,
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600, color: color),
                )),
          ),
          isShowRightIcon == true
              ? const Icon(
                  CupertinoIcons.chevron_right,
                  size: 20,
                )
              : Container()
        ],
      ),
    ),
  );
}
