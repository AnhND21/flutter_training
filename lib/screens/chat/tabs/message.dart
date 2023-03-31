import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_training/components/listing_chat.dart';
import 'package:flutter_training/components/listing_story.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
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
            child: Container(
              child: Column(
                children: [
                  const ListingStory(),
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
                  const Flexible(child: ListingChat())
                ],
              ),
            )));
  }
}
