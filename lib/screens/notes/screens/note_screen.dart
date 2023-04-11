import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/screens/notes/provider/note_provider.dart';
import 'package:flutter_training/screens/notes/screens/add_note_screen.dart';
import 'package:flutter_training/screens/notes/utils/random_color.dart';
import 'package:provider/provider.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  @override
  void initState() {
    Provider.of<NoteProvider>(context, listen: false).getNotes().then((_) {
      setState(() {});
    });
    super.initState();
  }

  void showInfoDialog(BuildContext context) {
    showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: Builder(
            builder: (context) {
              return Container(
                padding: const EdgeInsets.all(32),
                width: MediaQuery.of(context).size.width - 32,
                height: 300,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Design by - AnhND'),
                      SizedBox(
                        height: 16,
                      ),
                      Text('Redesigned by - AnhND'),
                      SizedBox(
                        height: 16,
                      ),
                      Text('Illustrations by - AnhND'),
                      SizedBox(
                        height: 16,
                      ),
                      Text('Icons by - AnhND'),
                      SizedBox(
                        height: 16,
                      ),
                      Text('Fonts by - AnhND'),
                      SizedBox(
                        height: 32,
                      ),
                      Center(
                        child: Text(
                          'Made by - AnhND',
                          textAlign: TextAlign.center,
                        ),
                      )
                    ]),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    NoteProvider noteProvider = Provider.of<NoteProvider>(context);
    final notes = noteProvider.notes;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
                  onTap: () {
                    Navigator.pushNamed(context, '/search_note');
                  },
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16))),
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
                  onTap: () {
                    showInfoDialog(context);
                  },
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16))),
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
      body: Container(
        padding: const EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: notes.isEmpty
              ? Center(
                  child: Image.asset(
                    'assets/images/rafiki.png',
                    width: 300,
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return AddNoteScreen(id: notes[index].id);
                          },
                        ));
                      },
                      child: Card(
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                          color: notes[index].color.toColor(),
                          child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Text(
                                notes[index].title,
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ))),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Container(height: 8);
                  },
                  itemCount: notes.length),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return const AddNoteScreen();
            },
          ));
        },
        child: const Icon(
          CupertinoIcons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
