import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/screens/movies/provider/movie_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchScreen extends StatefulWidget {
  const MovieSearchScreen({super.key});

  @override
  State<MovieSearchScreen> createState() => _MovieSearchScreenState();
}

class _MovieSearchScreenState extends State<MovieSearchScreen> {
  final TextEditingController _editingController =
      TextEditingController(text: '');
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> getMovieByKeyword() async {
    setState(() {
      _isLoading = true;
    });
    Provider.of<MovieProvider>(context, listen: false)
        .fetchMoviesByKeyword(_editingController.text)
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    MovieProvider movieProvider = Provider.of<MovieProvider>(context);
    final searchedList = movieProvider.movieSearch;
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFF2B5876), Color(0xFF4E4376)],
              begin: Alignment.topLeft,
              end: Alignment.centerRight),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: kToolbarHeight + 8),
              child: Hero(
                transitionOnUserGestures: true,
                tag: 'searchHero',
                child: Material(
                  type: MaterialType.transparency,
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
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.only(right: 32, left: 16),
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(colors: [
                                Color.fromARGB(60, 107, 102, 166),
                                Color.fromARGB(60, 158, 189, 251)
                              ]),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              border:
                                  Border.all(width: 0.5, color: Colors.white)),
                          child: TextFormField(
                            controller: _editingController,
                            onFieldSubmitted: (_) {
                              getMovieByKeyword();
                            },
                            textInputAction: TextInputAction.next,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              suffixIcon: Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                        left: BorderSide(
                                  //                   <--- right side
                                  color: Colors.grey,
                                  width: 0.5,
                                ))),
                                child: const Icon(
                                  CupertinoIcons.mic,
                                  color: Colors.grey,
                                ),
                              ),
                              prefixIcon: const Icon(
                                CupertinoIcons.search,
                                color: Colors.white,
                                // size: 22,
                              ),
                              hintText: 'Search',
                              hintStyle: const TextStyle(
                                  fontSize: 16, color: Colors.white, height: 1),
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
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 16, left: 24, right: 24, bottom: 8),
              child: const Text(
                "Search result",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
            _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                    ),
                  )
                : Flexible(
                    child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 8),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16)),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "https://image.tmdb.org/t/p/w500${searchedList[index].posterPath}",
                                    fit: BoxFit.cover,
                                    width: 120,
                                    height: 120,
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          searchedList[index].title.toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          child: Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 2,
                                                        horizontal: 8),
                                                decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.2),
                                                        spreadRadius: 3,
                                                        blurRadius: 10,
                                                        offset:
                                                            const Offset(1, 1),
                                                      )
                                                    ],
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius
                                                                .circular(16)),
                                                    gradient:
                                                        const LinearGradient(
                                                            colors: [
                                                          Color.fromARGB(100,
                                                              100, 171, 219),
                                                          Color.fromARGB(100,
                                                              129, 110, 200)
                                                        ],
                                                            begin: Alignment
                                                                .topLeft,
                                                            end: Alignment
                                                                .centerRight)),
                                                child: const Text(
                                                  'Action',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 2,
                                                        horizontal: 12),
                                                decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.2),
                                                        spreadRadius: 3,
                                                        blurRadius: 10,
                                                        offset:
                                                            const Offset(1, 1),
                                                      )
                                                    ],
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius
                                                                .circular(16)),
                                                    gradient:
                                                        const LinearGradient(
                                                            colors: [
                                                          Color.fromARGB(100,
                                                              100, 171, 219),
                                                          Color.fromARGB(100,
                                                              129, 110, 200)
                                                        ],
                                                            begin: Alignment
                                                                .topLeft,
                                                            end: Alignment
                                                                .centerRight)),
                                                child: Text(
                                                    searchedList[index].adult ==
                                                            true
                                                        ? '18+'
                                                        : '16+',
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 2,
                                                        horizontal: 12),
                                                decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 255, 204, 0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.2),
                                                      spreadRadius: 3,
                                                      blurRadius: 10,
                                                      offset:
                                                          const Offset(1, 1),
                                                    )
                                                  ],
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(16)),
                                                ),
                                                child: Text(
                                                    'IMDb ${searchedList[index].voteAverage}',
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        searchedList[index].overview!.isNotEmpty
                                            ? Text(
                                                '${searchedList[index].overview}...',
                                                maxLines: 2,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ))
                                            : Container(),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          'Release Date: ${searchedList[index].releaseDate}',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 24,
                          );
                        },
                        itemCount: searchedList.length),
                  )
          ],
        ),
      ),
    );
  }
}
