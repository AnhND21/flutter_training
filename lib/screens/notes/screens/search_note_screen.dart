import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/screens/notes/models/note.dart';
import 'package:flutter_training/screens/notes/provider/note_provider.dart';
import 'package:flutter_training/screens/notes/screens/add_note_screen.dart';
import 'package:flutter_training/screens/notes/utils/random_color.dart';
import 'package:provider/provider.dart';

class SearchNoteScreen extends StatefulWidget {
  const SearchNoteScreen({super.key});

  @override
  State<SearchNoteScreen> createState() => _SearchNoteScreenState();
}

class _SearchNoteScreenState extends State<SearchNoteScreen> {
  TextEditingController searchController = TextEditingController(text: '');
  List<Note> lstNote = <Note>[];

  Future<void> onSearchNote() async {
    try {
      final response = await Provider.of<NoteProvider>(context, listen: false)
          .searchNoteByTitle(searchController.text);
      setState(() {
        lstNote = response;
      });
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(top: kToolbarHeight + 8),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 24.0),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        height: 50,
                        margin: const EdgeInsets.only(right: 32, left: 16),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(32)),
                            border:
                                Border.all(width: 0.5, color: Colors.white)),
                        child: TextFormField(
                          controller: searchController,
                          onChanged: (value) {
                            if (value.isEmpty && lstNote.isNotEmpty) {
                              setState(() {
                                lstNote = [];
                              });
                            }
                          },
                          onFieldSubmitted: (_) {
                            if (searchController.text.isNotEmpty) {
                              onSearchNote();
                            }
                          },
                          textInputAction: TextInputAction.next,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              CupertinoIcons.search,
                              color: Colors.black,
                              // size: 22,
                            ),
                            suffixIcon: searchController.text.isNotEmpty
                                ? InkWell(
                                    onTap: () {
                                      searchController.text = '';
                                      setState(() {
                                        lstNote = [];
                                      });
                                    },
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.grey,
                                    ),
                                  )
                                : null,
                            hintText: 'Search',
                            hintStyle: const TextStyle(
                                fontSize: 16, color: Colors.black, height: 1),
                            isDense: true,
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Text(
                  'Search result',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return AddNoteScreen(id: lstNote[index].id);
                            },
                          ));
                        },
                        child: Card(
                            shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                            color: lstNote[index].color.toColor(),
                            child: Padding(
                                padding: const EdgeInsets.all(24),
                                child: Text(
                                  lstNote[index].title,
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ))),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Container(height: 8);
                    },
                    itemCount: lstNote.length),
              )
            ])));
  }
}
