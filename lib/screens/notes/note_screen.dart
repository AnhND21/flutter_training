import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Expanded(
              child: Text(
                'Notes',
                style: TextStyle(fontSize: 24),
              ),
            ),
            Row(
              children: [
                InkWell(
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: const BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: const Icon(
                      CupertinoIcons.search,
                      size: 18,
                      weight: 2,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                InkWell(
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: const BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: const Icon(
                      CupertinoIcons.info,
                      size: 18,
                      weight: 2,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        titleSpacing: 24,
        centerTitle: false,
        leadingWidth: 0,
        leading: Container(),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black87,
        onPressed: () {},
        child: const Icon(
          CupertinoIcons.add,
        ),
      ),
    );
  }
}
