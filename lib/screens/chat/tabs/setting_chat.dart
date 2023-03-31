import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingChatScreen extends StatefulWidget {
  const SettingChatScreen({super.key});

  @override
  State<SettingChatScreen> createState() => _SettingChatScreenState();
}

class _SettingChatScreenState extends State<SettingChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
                      Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            color: Color(0xFFEDEDED),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        child: const Icon(Icons.person_2_outlined),
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[
                            Text(
                              'Duy Anh',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 15),
                            ),
                            Text(
                              '0338889999',
                              style: TextStyle(height: 1.5, color: Colors.grey),
                            )
                          ],
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
                  menuAction(context, 'Account', CupertinoIcons.person),
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
                ],
              ),
            ),
          ),
        ));
  }
}

Widget menuAction(BuildContext context, String title, IconData icon) {
  return Container(
    // padding: const EdgeInsets.all(8),
    margin: const EdgeInsets.symmetric(vertical: 12),
    child: Row(
      children: [
        Icon(
          icon,
          size: 20,
        ),
        Expanded(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              )),
        ),
        const Icon(
          CupertinoIcons.chevron_right,
          size: 20,
        )
      ],
    ),
  );
}
