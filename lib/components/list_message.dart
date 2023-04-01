import 'package:flutter/material.dart';
import 'package:flutter_training/models/message.dart';

class ListMessage extends StatelessWidget {
  final List<Message> data;
  const ListMessage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        reverse: true,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
                color: data[index].senderId == 1 ? Colors.grey : Colors.blue),
            child: Text(data[index].content.toString()),
          );
        },
        separatorBuilder: (context, index) {
          return Container(
            height: 16,
          );
        },
        itemCount: data.length);
  }
}
