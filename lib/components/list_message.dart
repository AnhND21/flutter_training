import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_training/models/message.dart';
import 'package:flutter_training/models/message_convert.dart';
import 'package:intl/intl.dart';

class ListMessage extends StatelessWidget {
  final List<Message> data;
  const ListMessage({Key? key, required this.data}) : super(key: key);

  MessageConvert convertMessages(List<Message> messages, int index) {
    MessageConvert messageConvert = MessageConvert();
    messageConvert.currentMessage = messages[index];
    if (index > 0) {
      messageConvert.previousMessage = messages[index - 1];
    } else {
      messageConvert.previousMessage = null;
    }

    if (index + 1 <= messages.length - 1) {
      messageConvert.nextMessage = messages[index + 1];
    } else {
      messageConvert.nextMessage = null;
    }

    return messageConvert;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      physics: const AlwaysScrollableScrollPhysics(),
      reverse: true,
      itemBuilder: (context, index) {
        final messageConvert = convertMessages(data, index);

        var dateTime = DateFormat('HH:mm a')
            .format(DateTime.parse(messageConvert.currentMessage!.createdAt));

        return Container(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 2),
          child: Align(
            alignment: (data[index].senderId == 1
                ? Alignment.topLeft
                : Alignment.topRight),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width / 1.5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(16),
                    topRight: const Radius.circular(16),
                    bottomLeft: data[index].senderId == 1
                        ? const Radius.circular(0)
                        : const Radius.circular(16),
                    bottomRight: data[index].senderId == 1
                        ? const Radius.circular(16)
                        : const Radius.circular(0),
                  ),
                  color: (data[index].senderId == 1
                      ? Colors.grey.shade100
                      : const Color(0xFF002DE3)),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // (messageConvert.currentMessage!.senderId != 0 &&
                    //             messageConvert.previousMessage!.senderId !=
                    //                 0) &&
                    //         messageConvert.currentMessage!.senderId !=
                    //             messageConvert.previousMessage!.senderId
                    //     ? SizedBox(
                    //         height: 16,
                    //       )
                    //     : Container(),
                    Text(
                      messageConvert.currentMessage!.content!.isNotEmpty
                          ? messageConvert.currentMessage!.content!.toString()
                          : '',
                      style: TextStyle(
                        fontSize: 15,
                        color: (data[index].senderId == 1
                            ? Colors.black
                            : Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      dateTime.toString(),
                      style: TextStyle(
                          fontSize: 10,
                          color: (messageConvert.currentMessage!.senderId == 1
                              ? Colors.black
                              : Colors.white)),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
