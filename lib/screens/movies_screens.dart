import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/components/custom_bottom_tabs.dart';
import 'package:flutter_training/components/menu_actions.dart';
import 'package:flutter_training/components/most_popular_movie.dart';
import 'package:flutter_training/components/upcoming_movies.dart';
import 'package:flutter_training/models/actor.dart';
import 'package:flutter_training/models/movies.dart';
import 'package:flutter_training/models/upcoming_movie.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  // int _selectedIndex = 0;

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  CarouselController buttonCarouselController = CarouselController();
  List<Movies> movieList = <Movies>[];
  List<UpcomingMovie> comingUpMovieList = <UpcomingMovie>[];
  List<Actor> actorList = <Actor>[];

  @override
  void initState() {
    super.initState();

    actorList.addAll([
      Actor(
          name: "Chris Hemsworth",
          actorName: "Thor",
          avatar:
              "https://www.pinkvilla.com/imageresize/leonardo_dicaprio_0.jpeg?width=752&t=pvorg"),
      Actor(
          name: "Natalie Portman",
          actorName: "Jane Foster",
          avatar:
              "https://ichef.bbci.co.uk/news/976/cpsprodpb/62CB/production/_126319252_gettyimages-1361454688.jpg"),
      Actor(
          name: "Tom Hiddleston",
          actorName: "Loki",
          avatar:
              "https://i.insider.com/5751876c52bcd05b008c6a5b?width=1071&format=jpeg"),
    ]);

    comingUpMovieList.addAll([
      UpcomingMovie(
          movieName: 'To the moon',
          imdb: '9.9',
          thumbnail:
              'https://marketplace.canva.com/EAFMqwkPfOY/2/0/1131w/canva-black-minimalist-horror-movie-poster-3bttgZhMDnA.jpg',
          description:
              "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text.",
          category: 'Romantic',
          mainActor: 'Biden',
          actors: actorList),
      UpcomingMovie(
          movieName: 'Putin Đại Đế',
          imdb: '10',
          thumbnail:
              'https://i.ebayimg.com/images/g/hYgAAOSw2hdi2g74/s-l500.jpg',
          description:
              "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text.",
          category: 'Romantic',
          mainActor: 'Putin',
          actors: actorList),
      UpcomingMovie(
          movieName: 'Đô nan Chăm',
          imdb: '9.1',
          thumbnail:
              'https://upload.wikimedia.org/wikipedia/vi/f/fe/1917_%282019%29_Film_Poster.jpeg',
          description:
              "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text.",
          category: 'Romantic',
          mainActor: 'Chăm',
          actors: actorList)
    ]);

    movieList.addAll([
      Movies(
          movieName: "Avatar: The way of Water",
          imdb: '9.8',
          thumbnail:
              'https://bloganchoi.com/wp-content/uploads/2022/08/avatar-a2.jpg',
          description:
              "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text.",
          category: 'Romantic',
          mainActor: 'Jake Sully',
          actors: actorList),
      Movies(
          movieName: "Minion: The Growth of Gru",
          imdb: '9.6',
          thumbnail:
              'https://media.vov.vn/sites/default/files/styles/large/public/2022-07/untitled-11.jpg',
          category: 'Cartoon',
          description:
              "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text.",
          mainActor: 'Gru',
          actors: actorList),
      Movies(
          movieName: "Ant-Man: The Quantumania",
          imdb: '8.8',
          thumbnail:
              'https://images2.thanhnien.vn/zoom/700_438/528068263637045248/2023/2/17/ant-man-3-4x5-16766045112201851823482-103-0-778-1080-crop-1676606662304105094367.jpeg',
          description:
              "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text.",
          category: 'Action',
          mainActor: 'Ant-Man',
          actors: actorList)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 5,
        child: Scaffold(
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF2B5876), Color(0xFF4E4376)],
                  begin: Alignment.topLeft,
                  end: Alignment.centerRight),
            ),
            child: SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {},
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 64),
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: Row(
                                  children: const <Widget>[
                                    Text(
                                      "Hello,",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 4.0),
                                      child: Text("Duy Anh",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)),
                                    ),
                                  ],
                                )),
                                const Icon(
                                  CupertinoIcons.bell,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 50,
                            margin: const EdgeInsets.symmetric(horizontal: 32),
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [
                                  Color.fromARGB(60, 107, 102, 166),
                                  Color.fromARGB(60, 158, 189, 251)
                                ]),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(16)),
                                border: Border.all(
                                    width: 0.5, color: Colors.white)),
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              textAlignVertical: TextAlignVertical.bottom,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                              // obscuringCharacter: "*",
                              decoration: InputDecoration(
                                suffixIcon: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 4),
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
                                  size: 22,
                                ),
                                filled: true,
                                hintText: 'Search',
                                hintStyle: const TextStyle(
                                    fontSize: 16, color: Colors.white),
                                isDense: true,
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                              ),
                            ),
                          ),
                          MostPopularMovies(movieList: movieList),
                          const MenuActions(),
                          UpcomingMovies(comingUpMovieList: comingUpMovieList),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: customBottomNavigationBar(context),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}

// Widget customBottomNavigationBar(BuildContext context) {
//   double myHeight = 70.0; //Your height HERE
//   return Container(
//     decoration: const BoxDecoration(
//         border: Border(top: BorderSide(width: 0.5, color: Colors.white)),
//         gradient: LinearGradient(
//             colors: [Color(0xFF2B5876), Color(0xFF4E4376)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight)),
//     height: myHeight,
//     width: MediaQuery.of(context).size.width,
//     padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24, top: 12),
//     child: const TabBar(
//       dividerColor: Colors.white,
//       tabs: [
//         Tab(
//             icon: Icon(
//           CupertinoIcons.house_alt,
//           size: 26.0,
//           color: Colors.white,
//         )),
//         Tab(
//             icon: Icon(
//           CupertinoIcons.heart_fill,
//           size: 26.0,
//           color: Colors.white,
//         )),
//         Tab(
//             icon: Icon(
//           CupertinoIcons.ticket,
//           size: 26.0,
//           color: Colors.white,
//         )),
//         Tab(
//             icon: Icon(
//           CupertinoIcons.person,
//           size: 26.0,
//           color: Colors.white,
//         )),
//         Tab(
//             icon: Icon(
//           Icons.share_outlined,
//           size: 26.0,
//           color: Colors.white,
//         ))
//       ],
//       // labelStyle: TextStyle(fontSize: 12.0),
//       labelColor: Colors.white,
//       indicatorSize: TabBarIndicatorSize.label,
//       indicatorWeight: 1,
//       indicator: UnderlineTabIndicator(
//         borderRadius: BorderRadius.all(Radius.circular(10)),
//         borderSide: BorderSide(width: 3.0, color: Colors.white),
//         insets: EdgeInsets.symmetric(
//           horizontal: 10,
//         ),
//       ),
//     ),
//   );
// }
