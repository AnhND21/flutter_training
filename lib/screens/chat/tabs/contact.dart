// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_training/models/contact.dart';
import 'package:flutter_training/screens/chat/message_details.dart';
import 'package:flutter_training/screens/chat/model/user_chat.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  List<Contact> contacts = <Contact>[];

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users')
      .snapshots(includeMetadataChanges: true);

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Contact'),
        titleSpacing: 24,
        centerTitle: false,
        leadingWidth: 0,
        leading: Container(),
        actions: <Widget>[
          InkWell(
            onTap: () {},
            child: const Icon(CupertinoIcons.add),
          ),
          const SizedBox(
            width: 24,
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                );
              }
              return Column(
                children: [
                  Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                          top: 24, left: 24, right: 24, bottom: 16),
                      child: TextFormField(
                        style: const TextStyle(fontWeight: FontWeight.w500),
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(height: 1, color: Colors.black),
                          filled: true,
                          prefixIcon:
                              Icon(CupertinoIcons.search, color: Colors.black),
                          fillColor: Color(0xFFF7F7FC),
                          hintText: 'Search...',
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                        ),
                      )),
                  Flexible(
                    child: ListView(
                      key: UniqueKey(),
                      padding: const EdgeInsets.only(
                          top: 16, left: 16, right: 16, bottom: 32),
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return renderListContact(context, data, user);
                      }).toList(),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}

Widget renderListContact(
    BuildContext context, Map<String, dynamic> contacts, User? user) {
  return contacts['uid'] == user!.uid
      ? Container(
          height: 0,
        )
      : InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MessageDetailScreen(
                          name:
                              "${contacts['firstName']} ${contacts['lastName'] ?? ''}",
                          roomID: user.uid + contacts['uid'],
                        )));
          },
          child: Container(
            margin: const EdgeInsets.only(top: 16),
            padding: const EdgeInsets.only(bottom: 16),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 0.5, color: Colors.black12))),
            child: Row(
              children: <Widget>[
                Stack(children: [
                  Container(
                    width: 56,
                    height: 56,
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      child: contacts['photoURL'] != null
                          ? Image.network(
                              contacts['photoURL'].toString(),
                              fit: BoxFit.cover,
                              width: 48,
                              height: 48,
                            )
                          : Container(
                              decoration:
                                  BoxDecoration(color: Colors.grey.shade100),
                              width: 48,
                              height: 48,
                              child: const Icon(
                                Icons.person,
                                color: Colors.grey,
                              ),
                            ),
                    ),
                  ),
                  contacts['phoneNumber'] != null
                      ? Positioned(
                          right: 0,
                          top: 2,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(32)),
                                border:
                                    Border.all(color: Colors.white, width: 1)),
                            child: const Icon(
                              Icons.circle,
                              size: 14,
                              color: Colors.green,
                            ),
                          ))
                      : Container(),
                ]),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${contacts['firstName']} ${contacts['lastName'] ?? ''}",
                      style: const TextStyle(
                          fontSize: 18, height: 1, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      contacts['phoneNumber'] != null
                          ? 'Last seen a minute'
                          : 'Active',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
}
