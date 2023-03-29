import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/models/movies.dart';

class MostPopularMovies extends StatefulWidget {
  final List<Movies> movieList;
  const MostPopularMovies({super.key, required this.movieList});

  @override
  State<MostPopularMovies> createState() => _MostPopularMoviesState();
}

class _MostPopularMoviesState extends State<MostPopularMovies> {
  int _sliderIndex = 0;

  void onSliderIndexChange(int index) {
    setState(() {
      _sliderIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      // padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            margin: const EdgeInsets.only(top: 24),
            child: const Text('Most popular',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(
            height: 12,
          ),
          Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                    pageSnapping: true,
                    height: 141.0,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    // autoPlay: true,
                    enlargeFactor: 0.2,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, reason) =>
                        {onSliderIndexChange(index)},
                    initialPage: _sliderIndex),
                items: widget.movieList.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 5.0,
                          ),
                          child: InkWell(
                            onTap: () {
                              _sliderIndex == widget.movieList.indexOf(i)
                                  ? Navigator.pushNamed(
                                      context, '/movie_detals',
                                      arguments: i)
                                  : {};
                            },
                            child: Stack(
                                alignment: Alignment.bottomLeft,
                                fit: StackFit.expand,
                                children: [
                                  Opacity(
                                    opacity: widget.movieList[_sliderIndex]
                                                .movieName ==
                                            i.movieName
                                        ? 1.0
                                        : 0.5,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(32)),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black,
                                              spreadRadius: 1,
                                              blurRadius: 30,
                                              offset: Offset(3, 3),
                                            )
                                          ],
                                        ),
                                        child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: i.thumbnail),
                                      ),
                                    ),
                                  ),
                                  widget.movieList[_sliderIndex].movieName ==
                                          i.movieName
                                      ? Positioned(
                                          child: Container(
                                          alignment: Alignment.bottomCenter,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(32)),
                                              gradient: LinearGradient(
                                                  colors: [
                                                    Colors.black12,
                                                    Colors.black
                                                  ],
                                                  begin: Alignment.center,
                                                  end: Alignment.bottomCenter)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 8),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${i.movieName.substring(0, 18)}...',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 18,
                                                  ),
                                                  maxLines: 1,
                                                  softWrap: true,
                                                ),
                                                Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8,
                                                      vertical: 2),
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.yellow,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          16))),
                                                  child: Text(
                                                    "IMDb ${i.imdb}",
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ))
                                      : Container()
                                ]),
                          ));
                    },
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 16,
              ),
              DotsIndicator(
                dotsCount: widget.movieList.length,
                position: _sliderIndex.toDouble(),
                decorator: const DotsDecorator(
                    activeColor: Color.fromARGB(255, 102, 68, 250)),
              )
            ],
          )
        ],
      ),
    );
  }
}
