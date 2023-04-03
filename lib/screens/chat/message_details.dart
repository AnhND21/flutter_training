// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_training/components/list_message.dart';

class MessageDetailScreen extends StatefulWidget {
  final String name;
  final String roomID;
  const MessageDetailScreen({
    Key? key,
    required this.name,
    required this.roomID,
  }) : super(key: key);

  @override
  State<MessageDetailScreen> createState() => _MessageDetailScreenState();
}

class _MessageDetailScreenState extends State<MessageDetailScreen> {
  final db = FirebaseFirestore.instance;
  late CollectionReference chatReference;
  final TextEditingController _textController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    chatReference =
        db.collection("chats").doc(widget.roomID).collection('messages');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.name,
        ),
        titleSpacing: 0,
        centerTitle: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(CupertinoIcons.chevron_back),
        ),
        actions: <Widget>[
          InkWell(
            onTap: () {},
            child: const Icon(CupertinoIcons.search),
          ),
          const SizedBox(
            width: 16,
          ),
          InkWell(
            onTap: () {},
            child: const Icon(CupertinoIcons.bars, size: 28),
          ),
          const SizedBox(
            width: 24,
          ),
        ],
      ),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: const ListMessage(data: []),
              ),
            ),
            Container(
              height: 48,
              decoration: const BoxDecoration(
                  // color: Colors.white,
                  ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: const Icon(
                      CupertinoIcons.add,
                      color: Color(0xFFADB5BD),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      height: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: const BoxDecoration(
                          color: Color(0xFFF7F7FC),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: TextFormField(
                        style: const TextStyle(fontWeight: FontWeight.w400),
                        controller: _textController,
                        decoration: const InputDecoration(
                            hintStyle: TextStyle(color: Colors.grey),
                            hintText: "Aa...",
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.send,
                      color: _textController.text.isEmpty
                          ? const Color(0xFFADB5BD)
                          : const Color(0xFF002DE3),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
