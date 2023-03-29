import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/models/upcoming_movie.dart';

class UpcomingMovies extends StatefulWidget {
  final List<UpcomingMovie> comingUpMovieList;
  const UpcomingMovies({super.key, required this.comingUpMovieList});

  @override
  State<UpcomingMovies> createState() => _UpcomingMoviesState();
}

class _UpcomingMoviesState extends State<UpcomingMovies> {
  int _sliderComingUpIndex = 0;

  void onSliderComingUpIndexChange(int index) {
    setState(() {
      _sliderComingUpIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(top: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              "Upcoming releases",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          CarouselSlider(
            options: CarouselOptions(
                pageSnapping: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                // enlargeCenterPage: true,
                autoPlay: true,
                // enlargeFactor: 10,
                viewportFraction: 0.5,
                aspectRatio: 1.5,
                enlargeCenterPage: true,
                enlargeFactor: 0.1,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  onSliderComingUpIndexChange(index);
                },
                initialPage: _sliderComingUpIndex),
            items: widget.comingUpMovieList.map((e) {
              return Builder(
                builder: (context) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Opacity(
                      opacity: widget.comingUpMovieList[_sliderComingUpIndex]
                                  .movieName ==
                              e.movieName
                          ? 1.0
                          : 0.5,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/movie_detals',
                              arguments: e);
                        },
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(32)),
                          child: CachedNetworkImage(
                              height: 214.0,
                              fit: BoxFit.cover,
                              imageUrl: e.thumbnail),
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          const SizedBox(
            height: 16,
          ),
          DotsIndicator(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            dotsCount: widget.comingUpMovieList.length,
            position: _sliderComingUpIndex.toDouble(),
            decorator: const DotsDecorator(
                activeColor: Color.fromARGB(255, 102, 68, 250)),
          )
        ],
      ),
    );
  }
}