import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/components/custom_bottom_tabs.dart';
import 'package:flutter_training/models/movies.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({
    super.key,
  });

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    final moive = ModalRoute.of(context)!.settings.arguments as Movies;
    return Scaffold(
      body: DefaultTabController(
          length: 5,
          child: Scaffold(
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                // alignment: Alignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: moive.thumbnail,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.width / 1.2,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: kToolbarHeight, left: 16),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.white,
                          size: 30,
                        )),
                  ),
                  Positioned(
                      bottom: 0,
                      child: SingleChildScrollView(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height -
                              (MediaQuery.of(context).size.width / 1.2),
                          // alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            border: Border.fromBorderSide(
                                BorderSide(width: 0.2, color: Colors.white)),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(64),
                                topRight: Radius.circular(64)),
                            gradient: LinearGradient(
                                colors: [Color(0xFF2B5876), Color(0xFF4E4376)],
                                begin: Alignment.topLeft,
                                end: Alignment.centerRight),
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 12),
                                width: 32,
                                height: 2,
                                color: Colors.white,
                              ),
                              Container(
                                  margin: const EdgeInsets.only(top: 32),
                                  child: Text(
                                    moive.mainActor,
                                    style: const TextStyle(
                                        height: 1,
                                        color: Colors.white,
                                        fontSize: 64,
                                        fontWeight: FontWeight.w700),
                                    maxLines: 1,
                                    textScaleFactor: 1,
                                  )),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 32),
                                child: Text(
                                  moive.movieName,
                                  style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 32),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 8),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              spreadRadius: 3,
                                              blurRadius: 10,
                                              offset: const Offset(1, 1),
                                            )
                                          ],
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(16)),
                                          gradient: const LinearGradient(
                                              colors: [
                                                Color.fromARGB(
                                                    100, 100, 171, 219),
                                                Color.fromARGB(
                                                    100, 129, 110, 200)
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.centerRight)),
                                      child: Text(
                                        moive.category,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 12),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              spreadRadius: 3,
                                              blurRadius: 10,
                                              offset: const Offset(1, 1),
                                            )
                                          ],
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(16)),
                                          gradient: const LinearGradient(
                                              colors: [
                                                Color.fromARGB(
                                                    100, 100, 171, 219),
                                                Color.fromARGB(
                                                    100, 129, 110, 200)
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.centerRight)),
                                      child: Text(
                                          moive.requireAge != 0
                                              ? moive.requireAge.toString()
                                              : '18+',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 12),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 255, 204, 0),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            spreadRadius: 3,
                                            blurRadius: 10,
                                            offset: const Offset(1, 1),
                                          )
                                        ],
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(16)),
                                      ),
                                      child: Text('IMDb ${moive.imdb}',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    Expanded(
                                        child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: const Icon(
                                            CupertinoIcons.share,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: const Icon(
                                            CupertinoIcons.heart_fill,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    )),
                                  ],
                                ),
                              ),
                              Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 32, vertical: 16),
                                  child: Text(
                                    '${moive.description.substring(0, 150)}...',
                                    // maxLines: 3,
                                    style: const TextStyle(color: Colors.white),
                                  )),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 32),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Text('Cast',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700)),
                                        Expanded(
                                            child: InkWell(
                                          onTap: () {},
                                          child: const Text(
                                            'See all',
                                            style:
                                                TextStyle(color: Colors.white),
                                            textAlign: TextAlign.right,
                                          ),
                                        ))
                                      ],
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      width: MediaQuery.of(context).size.width,
                                      child: GridView.count(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        padding: const EdgeInsets.only(top: 8),
                                        shrinkWrap: true,
                                        crossAxisSpacing: 24,
                                        crossAxisCount: 5,
                                        childAspectRatio: 0.3,
                                        children: List.generate(
                                            moive.actors!.length, (index) {
                                          return Container(
                                            alignment: Alignment.topLeft,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(16)),
                                                  child: CachedNetworkImage(
                                                    imageUrl: moive
                                                            .actors![index]
                                                            .avatar
                                                            .isNotEmpty
                                                        ? moive.actors![index]
                                                            .avatar
                                                        : '',
                                                    fit: BoxFit.cover,
                                                    width: 50,
                                                    height: 50,
                                                  ),
                                                ),
                                                Text(
                                                  moive.actors![index].name,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                  textAlign: TextAlign.center,
                                                  maxLines: 2,
                                                ),
                                                Text(
                                                  moive
                                                      .actors![index].actorName,
                                                  style: const TextStyle(
                                                      color: Colors.grey),
                                                  textAlign: TextAlign.center,
                                                  maxLines: 2,
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            ),
            backgroundColor: Colors.white,
            bottomNavigationBar: customBottomNavigationBar(context),
          )),
    );
  }
}
