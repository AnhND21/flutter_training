// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import 'package:flutter_training/components/custom_bottom_tabs.dart';
import 'package:flutter_training/screens/movies/provider/movie_provider.dart';

class MovieDetails extends StatefulWidget {
  final int movieId;
  const MovieDetails({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  bool isLoading = false;

  @override
  void initState() {
    getMovieDetails();
    super.initState();
  }

  Future<void> getMovieDetails() async {
    setState(() {
      isLoading = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      Provider.of<MovieProvider>(context, listen: false)
          .fetchMoviesDetails(widget.movieId)
          .then((_) {
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    MovieProvider movieProvider = Provider.of<MovieProvider>(context);
    final mData = movieProvider.movieDetails;
    return Scaffold(
      body: DefaultTabController(
          length: 5,
          child: Scaffold(
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: isLoading
                  ? Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xFF2B5876), Color(0xFF4E4376)],
                            begin: Alignment.topLeft,
                            end: Alignment.centerRight),
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                        ),
                      ),
                    )
                  : Stack(
                      // alignment: Alignment.center,
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                              "https://image.tmdb.org/t/p/w500/${mData.backdropPath}",
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.width / 1.2,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: kToolbarHeight, left: 16),
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                CupertinoIcons.arrow_uturn_left,
                                color: Colors.white,
                                size: 30,
                              )),
                        ),
                        Positioned(
                            height: MediaQuery.of(context).size.height,
                            top: MediaQuery.of(context).size.width / 1.5,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              // alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                border: Border.fromBorderSide(BorderSide(
                                    width: 0.2, color: Colors.white)),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(64),
                                    topRight: Radius.circular(64)),
                                gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF2B5876),
                                      Color(0xFF4E4376)
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.centerRight),
                              ),
                              child: SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.width),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 12),
                                      width: 32,
                                      height: 2,
                                      color: Colors.white,
                                    ),
                                    Container(
                                        margin: const EdgeInsets.only(
                                            top: 32, left: 24, right: 24),
                                        child: Text(
                                          mData.originalTitle.toString(),
                                          style: const TextStyle(
                                              height: 1,
                                              color: Colors.white,
                                              fontSize: 40,
                                              fontWeight: FontWeight.w700),
                                          maxLines: 1,
                                          textScaleFactor: 1,
                                          textAlign: TextAlign.center,
                                        )),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 32),
                                      child: Text(
                                        mData.title.toString(),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.white70,
                                            fontWeight: FontWeight.w700),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 32),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 2, horizontal: 8),
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    spreadRadius: 3,
                                                    blurRadius: 10,
                                                    offset: const Offset(1, 1),
                                                  )
                                                ],
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(16)),
                                                gradient: const LinearGradient(
                                                    colors: [
                                                      Color.fromARGB(
                                                          100, 100, 171, 219),
                                                      Color.fromARGB(
                                                          100, 129, 110, 200)
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end:
                                                        Alignment.centerRight)),
                                            child: const Text(
                                              'Action',
                                              style: TextStyle(
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
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    spreadRadius: 3,
                                                    blurRadius: 10,
                                                    offset: const Offset(1, 1),
                                                  )
                                                ],
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(16)),
                                                gradient: const LinearGradient(
                                                    colors: [
                                                      Color.fromARGB(
                                                          100, 100, 171, 219),
                                                      Color.fromARGB(
                                                          100, 129, 110, 200)
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end:
                                                        Alignment.centerRight)),
                                            child: Text(
                                                mData.adult == true
                                                    ? '18+'
                                                    : '16+',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 2, horizontal: 12),
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 255, 204, 0),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.2),
                                                  spreadRadius: 3,
                                                  blurRadius: 10,
                                                  offset: const Offset(1, 1),
                                                )
                                              ],
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(16)),
                                            ),
                                            child: Text(
                                                'IMDb ${mData.voteAverage}',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                          Expanded(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
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
                                        child: ReadMoreText(
                                          mData.overview.toString(),
                                          trimLines: 3,
                                          colorClickableText:
                                              const Color(0xFFA1F3FE),
                                          trimMode: TrimMode.Line,
                                          trimCollapsedText: ' More',
                                          trimExpandedText: ' Less',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white),
                                          moreStyle: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFFA1F3FE)),
                                        )),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 32),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              const Text('Cast',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                              Expanded(
                                                  child: InkWell(
                                                onTap: () {},
                                                child: const Text(
                                                  'See all',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  textAlign: TextAlign.right,
                                                ),
                                              ))
                                            ],
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: GridView.count(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              padding:
                                                  const EdgeInsets.only(top: 8),
                                              shrinkWrap: true,
                                              crossAxisSpacing: 24,
                                              crossAxisCount: 5,
                                              childAspectRatio: 0.3,
                                              children:
                                                  List.generate(4, (index) {
                                                return Container(
                                                  alignment: Alignment.topLeft,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    16)),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              'https://image.tmdb.org/t/p/w500/${mData.posterPath}',
                                                          fit: BoxFit.cover,
                                                          width: 50,
                                                          height: 50,
                                                        ),
                                                      ),
                                                      Text(
                                                        mData.originalTitle
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                        textAlign:
                                                            TextAlign.center,
                                                        maxLines: 2,
                                                      ),
                                                      Text(
                                                        mData.releaseDate
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color: Colors.grey),
                                                        textAlign:
                                                            TextAlign.center,
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
