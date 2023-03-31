import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
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
                child: renderListContact(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget renderListContact(BuildContext context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height,
    child: ListView.separated(
        padding: const EdgeInsets.all(24),
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Row(
            children: <Widget>[
              Stack(children: [
                Container(
                  width: 56,
                  height: 56,
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    child: Image.network(
                      'https://media-cdn-v2.laodong.vn/Storage/NewsPortal/2021/12/17/985676/Rose-Blackpink.jpeg',
                      fit: BoxFit.cover,
                      width: 48,
                      height: 48,
                    ),
                  ),
                ),
                Positioned(
                    right: 0,
                    top: 2,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(32)),
                          border: Border.all(color: Colors.white, width: 1)),
                      child: const Icon(
                        Icons.circle,
                        size: 14,
                        color: Colors.green,
                      ),
                    )),
              ]),
              const SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Athalia Putri',
                    style: TextStyle(fontSize: 18, height: 1),
                  ),
                  Text(
                    'Last seen yesterday',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              )
            ],
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
        itemCount: 10),
  );
}
