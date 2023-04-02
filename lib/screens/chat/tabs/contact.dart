// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_training/models/contact.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  List<Contact> contacts = <Contact>[];

  @override
  void initState() {
    super.initState();
    contacts.addAll([
      Contact(
          name: "DuyAnie",
          id: '234e',
          status: 1,
          lastSeen: 'a month ago',
          avatar:
              'http://midias.correiobraziliense.com.br/_midias/png/2022/01/26/jisoo-7377278.png'),
      Contact(
          name: "Lisá",
          id: '234e',
          status: 1,
          lastSeen: 'a month ago',
          avatar:
              'https://vtv1.mediacdn.vn/thumb_w/650/2020/6/2/1591067420-20200601-lisa-15910726681152074573621.jpg'),
      Contact(
          name: "Rosé",
          id: '234e',
          status: 1,
          lastSeen: 'a minute',
          avatar:
              'https://ss-ava.saostar.vn/w800/pc/1679385212182/saostar-p8xo8nmmug38yecr.png'),
      Contact(
          name: "Jennie",
          id: '234e',
          status: 1,
          avatar:
              'https://img.inews.co.id/media/600/files/inews_new/2021/12/03/lisa_blackpink.jpg'),
      Contact(
        name: "Jisoo",
        id: '234e',
        status: 1,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
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
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                    ),
                  )),
              Flexible(
                child: renderListContact(context, contacts),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget renderListContact(BuildContext context, List<Contact> contacts) {
  return SizedBox(
    height: MediaQuery.of(context).size.height,
    child: ListView.separated(
        padding: const EdgeInsets.all(24),
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // Navigator.pushNamed(
              //   context,
              //   '/message_detail',
              // );
            },
            child: Row(
              children: <Widget>[
                Stack(children: [
                  Container(
                    width: 56,
                    height: 56,
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      child: contacts[index].avatar != null
                          ? Image.network(
                              contacts[index].avatar.toString(),
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
                  contacts[index].lastSeen == null
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
                      contacts[index].name,
                      style: const TextStyle(fontSize: 18, height: 1),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      contacts[index].lastSeen != null
                          ? 'Last seen ${contacts[index].lastSeen}'
                          : 'Active',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey.shade100,
            margin: const EdgeInsets.symmetric(vertical: 16),
          );
        },
        itemCount: contacts.length),
  );
}
