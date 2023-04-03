import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_training/components/listing_story.dart';
import 'package:flutter_training/core/theme_provider.dart';
import 'package:flutter_training/models/story.dart';
import 'package:flutter_training/screens/chat/tabs/contact.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  List<Story> stories = <Story>[];
  DarkThemeProvider darkThemeProvider = DarkThemeProvider();

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users')
      .snapshots(includeMetadataChanges: true);

  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    stories.addAll([
      Story(
          name: 'Lisá',
          id: '123a2',
          thumbnail:
              'https://i0.wp.com/short-biography.com/wp-content/uploads/jisoo-kim/Kim-Ji-soo.jpg?fit=1024%2C1024&ssl=1'),
      Story(
          name: 'Rosé',
          id: '3231',
          thumbnail:
              'https://2sao.vietnamnetjsc.vn/images/2021/11/24/17/15/lisa.jpg'),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Chats'),
        titleSpacing: 24,
        centerTitle: false,
        leadingWidth: 0,
        leading: Container(),
        actions: <Widget>[
          InkWell(
            onTap: () {},
            child: SvgPicture.asset(
              "assets/svgs/chat_add.svg",
              color: darkThemeProvider.darkTheme ? Colors.black : Colors.white,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          InkWell(
            onTap: () {},
            child: SvgPicture.asset(
              "assets/svgs/menu_checked.svg",
              color: darkThemeProvider.darkTheme ? Colors.black : Colors.white,
            ),
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
                ));
              }
              return Column(
                children: [
                  ListingStory(stories: stories),
                  Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                          top: 16, left: 24, right: 24, bottom: 16),
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
