import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/screens/movie_details.dart';
import 'package:flutter_training/screens/movies/model/movie_model.dart';

class MostPopularMovies extends StatefulWidget {
  final List<Movie> movieList;
  const MostPopularMovies({super.key, required this.movieList});

  @override
  State<MostPopularMovies> createState() => _MostPopularMoviesState();
}

class _MostPopularMoviesState extends State<MostPopularMovies> {
  int _sliderIndex = 0;
  final CarouselController _controller = CarouselController();

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
                carouselController: _controller,
                options: CarouselOptions(
                  height: 141.0,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.2,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _sliderIndex = index;
                    });
                    _controller.animateToPage(index,
                        duration: const Duration(microseconds: 300),
                        curve: Curves.slowMiddle);
                  },
                ),
                items: widget.movieList.skip(0).take(5).map((i) {
                  return Builder(
                    key: UniqueKey(),
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 5.0,
                          ),
                          child: InkWell(
                            onTap: () {
                              _sliderIndex == widget.movieList.indexOf(i)
                                  ? Navigator.of(context)
                                      .push(MaterialPageRoute(
                                      builder: (context) {
                                        return MovieDetails(
                                            movieId: i.id!.toInt());
                                      },
                                    ))
                                  : {};
                            },
                            child: Stack(
                                alignment: Alignment.bottomLeft,
                                fit: StackFit.expand,
                                children: [
                                  Opacity(
                                    opacity:
                                        widget.movieList[_sliderIndex].title ==
                                                i.title
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
                                            imageUrl:
                                                "https://image.tmdb.org/t/p/w500/${i.backdropPath}"),
                                      ),
                                    ),
                                  ),
                                  widget.movieList[_sliderIndex].id == i.id
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
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    '${i.title}',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 18,
                                                    ),
                                                    maxLines: 1,
                                                    softWrap: true,
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 8),
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
                                                    "IMDb ${i.voteAverage.toString().substring(0, 3)}",
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
                }).toList(growable: false),
              ),
              const SizedBox(
                height: 16,
              ),
              DotsIndicator(
                dotsCount: widget.movieList.take(5).length,
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
