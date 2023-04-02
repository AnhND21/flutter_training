import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/components/list_message.dart';
import 'package:flutter_training/models/chat.dart';
import 'package:flutter_training/models/message.dart';

class MessageDetailScreen extends StatefulWidget {
  const MessageDetailScreen({super.key});

  @override
  State<MessageDetailScreen> createState() => _MessageDetailScreenState();
}

class _MessageDetailScreenState extends State<MessageDetailScreen> {
  String message = '';
  List<Message> data = <Message>[];
  List<Photo> photos = <Photo>[];

  @override
  void initState() {
    super.initState();
    photos.addAll([
      Photo(
          url:
              'https://znews-photo.zingcdn.me/w660/Uploaded/bzwvopcg/2021_02_12/bl.jpg',
          name: 'name.jpg',
          type: 'jpg')
    ]);
    data.addAll([
      Message(
          createdAt: DateTime.now().toString(),
          senderId: 1,
          status: 1,
          content: 'Create a DateTime'),
      Message(
          createdAt: DateTime.now().toString(),
          senderId: 1,
          status: 1,
          content: 'Create a DateTime'),
      Message(
          createdAt: DateTime.now().toString(),
          senderId: 1,
          status: 1,
          content: 'Create a DateTime'),
      Message(
          createdAt: DateTime.now().toString(),
          senderId: 2,
          status: 1,
          content: 'Create a DateTime'),
      Message(
          createdAt: DateTime.now().toString(),
          senderId: 2,
          status: 1,
          photos: photos,
          content: 'Create a DateTime object by one of the constructors'),
    ]);
  }

  void onChangeMessage(String text) {
    setState(() {
      message = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    final params = ModalRoute.of(context)!.settings.arguments as Chat;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          params.name,
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
                child: ListMessage(data: data),
              ),
            ),
            Container(
              height: 48,
              decoration: const BoxDecoration(
                color: Colors.white,
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
                        initialValue: message,
                        onChanged: (value) {
                          onChangeMessage(value);
                        },
                        decoration: const InputDecoration(
                            hintText: "Aa...", border: InputBorder.none),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.send,
                      color: message.isEmpty
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
