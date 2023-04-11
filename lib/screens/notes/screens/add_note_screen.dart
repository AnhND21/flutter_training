import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/screens/notes/models/note.dart';
import 'package:flutter_training/screens/notes/provider/note_provider.dart';
import 'package:flutter_training/screens/notes/utils/random_color.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddNoteScreen extends StatefulWidget {
  final String? id;
  const AddNoteScreen({super.key, this.id});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController titleController = TextEditingController(text: '');
  TextEditingController contentController = TextEditingController(text: '');
  String lastUpdated = '';
  bool isLoading = false;

  @override
  void initState() {
    if (widget.id != null) {
      setState(() {
        isLoading = true;
      });
      Provider.of<NoteProvider>(context, listen: false)
          .selectNoteById(widget.id!)
          .then((Note value) {
        titleController.text = value.title;
        contentController.text = value.content;
        lastUpdated = value.updatedAt;
        setState(() {
          isLoading = false;
        });
      });
    }
    super.initState();
  }

  void onSaveOrUpdateNote(BuildContext context) async {
    if (titleController.text.isNotEmpty) {
      NoteProvider noteProvider =
          Provider.of<NoteProvider>(context, listen: false);
      Navigator.pop(context);
      Navigator.pop(context);
      if (widget.id != null) {
        await noteProvider.updateProductNameById(
            widget.id.toString(),
            titleController.text,
            contentController.text,
            DateTime.now().toString());
      } else {
        await noteProvider.insertDatabase(titleController.text,
            contentController.text, randomColor().toString());
      }
    } else {
      Navigator.pop(context);
    }
  }

  void showDialogConfirmSave() {
    showCupertinoDialog(
        barrierDismissible: true,
        context: context,
        builder: (_) => AlertDialog(
              contentPadding: const EdgeInsets.all(0),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: Builder(
                builder: (context) {
                  return Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width - 32,
                    height: 180,
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          const Icon(CupertinoIcons.info),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(widget.id != null
                              ? 'Update changes?'
                              : "Save changes?"),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    width: 120,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 12),
                                    decoration: const BoxDecoration(
                                        color: Colors.redAccent,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: const Text(
                                      'Discard',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    onSaveOrUpdateNote(context);
                                  },
                                  child: Container(
                                    width: 120,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 12),
                                    decoration: const BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: Text(
                                      widget.id != null ? 'Update' : 'Save',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]),
                  );
                },
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    String outputDate = '';
    if (lastUpdated.isNotEmpty) {
      DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(lastUpdated);
      final outputFormat = DateFormat('dd/MM/yyyy hh:mm a');
      outputDate = outputFormat.format(parseDate);
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios),
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16))),
                    child: const Icon(
                      CupertinoIcons.eye,
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
                    showDialogConfirmSave();
                  },
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16))),
                    child: const Icon(
                      CupertinoIcons.printer,
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(strokeWidth: 1),
              )
            : Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    widget.id != null
                        ? Text(
                            "Last updated: $outputDate",
                            style: const TextStyle(color: Colors.grey),
                          )
                        : Container(),
                    SizedBox(
                      child: TextFormField(
                        controller: titleController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: const TextStyle(fontSize: 28),
                        decoration: const InputDecoration(
                            hintText: "Title",
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontSize: 28)),
                      ),
                    ),
                    SizedBox(
                      child: TextFormField(
                        controller: contentController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: const TextStyle(fontSize: 18),
                        decoration: const InputDecoration(
                            hintText: "Type something...",
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontSize: 18)),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
