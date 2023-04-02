import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_training/screens/chat/tabs/contact.dart';
import 'package:flutter_training/screens/chat/tabs/message.dart';
import 'package:flutter_training/screens/chat/tabs/setting_chat.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int _tabSelectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: renderTabSelected(context, _tabSelectedIndex),
        ),
      ),
      bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(1, 1),
              )
            ],
          ),
          child: GNav(
              gap: 8,
              backgroundColor: Colors.white,
              color: Colors.black,
              activeColor: Colors.black,
              haptic: true,
              padding: const EdgeInsets.all(16),
              selectedIndex: _tabSelectedIndex,
              onTabChange: (value) {
                setState(() {
                  _tabSelectedIndex = value;
                });
              },
              tabs: const <GButton>[
                GButton(
                  icon: CupertinoIcons.person_2,
                  text: "Contact",
                ),
                GButton(
                  icon: CupertinoIcons.chat_bubble,
                  text: "Chat",
                ),
                GButton(
                  icon: Icons.more_horiz,
                  text: "More",
                ),
              ])),
    );
  }
}

Widget renderTabSelected(BuildContext context, int index) {
  switch (index) {
    case 0:
      return const ContactScreen();
    case 1:
      return const MessageScreen();
    case 2:
      return const SettingChatScreen();
    default:
      return Container();
  }
}
