import 'package:flutter/material.dart';
import 'package:flutter_training/models/chat.dart';
import 'package:intl/intl.dart';

class ListingChat extends StatelessWidget {
  final List<Chat> data;
  const ListingChat({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.separated(
          padding:
              const EdgeInsets.only(left: 24, right: 24, bottom: 24, top: 8),
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/message_detail',
                    arguments: data[index]);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Stack(children: [
                    Container(
                      width: 56,
                      height: 56,
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        child: Image.network(
                          data[index].avatar.toString(),
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
                              border:
                                  Border.all(color: Colors.white, width: 1)),
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          data[index].name,
                          style: const TextStyle(fontSize: 18, height: 1),
                        ),
                        Text(
                          data[index].lastMessage ?? 'Sent a message',
                          style: const TextStyle(color: Colors.grey, height: 2),
                          maxLines: 1,
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        DateFormat('HH:mm a')
                            .format(DateTime.parse(data[index].sentAt)),
                        style: const TextStyle(color: Colors.grey),
                      ),
                      data[index].messageUnread != null
                          ? Container(
                              height: 16,
                              margin: const EdgeInsets.only(top: 8),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  color: Color(0xFFD2D5F9),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: Text(
                                data[index].messageUnread.toString(),
                                style: const TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w600),
                              ),
                            )
                          : Container(
                              height: 16,
                            )
                    ],
                  )
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(vertical: 12),
            );
          },
          itemCount: data.length),
    );
  }
}
