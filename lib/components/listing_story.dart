// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_training/models/story.dart';

// ignore: must_be_immutable
class ListingStory extends StatelessWidget {
  List<Story> stories;

  ListingStory({
    Key? key,
    required this.stories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width,
      // alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 2, color: Colors.grey.shade200))),
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(top: 16, right: 24, left: 24),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (index == 0) {
              // return the header
              return InkWell(
                child: Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border.fromBorderSide(
                              BorderSide(width: 3, color: Color(0xFFADB5BD)))),
                      child: Container(
                        height: 58,
                        width: 58,
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(18))),
                        child: const Icon(
                          CupertinoIcons.add,
                          color: Color(0xFFADB5BD),
                          size: 30,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Your Story',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
              );
            }
            index -= 1;

            // return row

            return Container(
              constraints: BoxConstraints(maxWidth: 60),
              child: InkWell(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      padding: const EdgeInsets.all(2.5),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          gradient: LinearGradient(colors: [
                            Color(0xFFA6ABF3),
                            Color(0xFF3F49E4),
                          ])),
                      child: Container(
                          height: 58,
                          width: 58,
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18))),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16)),
                            child: Image.network(
                              stories[index].thumbnail,
                              fit: BoxFit.cover,
                              width: 50,
                              height: 50,
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        stories[index].name,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        maxLines: 1,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Container(
              width: 24,
            );
          },
          itemCount: stories.isEmpty ? 1 : stories.length + 1),
    );
  }
}
