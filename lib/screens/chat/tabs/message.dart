import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_training/components/listing_chat.dart';
import 'package:flutter_training/components/listing_story.dart';
import 'package:flutter_training/models/chat.dart';
import 'package:flutter_training/models/story.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  List<Chat> lstChat = <Chat>[];
  List<Story> stories = <Story>[];

  @override
  void initState() {
    super.initState();
    lstChat.addAll([
      Chat(
          id: '123123123',
          name: 'Lisá',
          createdAt: DateTime.now().toString(),
          sentAt: DateTime.now().toString(),
          status: 1,
          messageUnread: 10,
          lastMessage: 'I love u so muchhhhh :)))) ',
          avatar:
              "https://images2.thanhnien.vn/Uploaded/trucdl/2021_12_30/moneycualisalapkyluc3-8661.png"),
      Chat(
          id: '2212312',
          name: 'Rosé',
          createdAt: DateTime.now().toString(),
          sentAt: DateTime.now().toString(),
          status: 2,
          lastMessage: "You're so cutewwwwww😻",
          avatar:
              "https://static2.yan.vn/YanNews/2167221/201911/xinh-qua-muc-cho-phep-trong-vay-trang-ai-co-the-lam-ngo-rose-77847861.jpg")
    ]);
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Chats'),
          titleSpacing: 24,
          centerTitle: false,
          leadingWidth: 0,
          leading: Container(),
          actions: <Widget>[
            InkWell(
              onTap: () {},
              child: SvgPicture.asset("assets/svgs/chat_add.svg"),
            ),
            const SizedBox(
              width: 16,
            ),
            InkWell(
              onTap: () {},
              child: SvgPicture.asset("assets/svgs/menu_checked.svg"),
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
            child: Column(
              children: [
                ListingStory(stories: stories),
                Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(
                        top: 24, left: 24, right: 24, bottom: 16),
                    child: TextFormField(
                      style: const TextStyle(fontWeight: FontWeight.w500),
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(height: 2),
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
                Flexible(child: ListingChat(data: lstChat))
              ],
            )));
  }
}
