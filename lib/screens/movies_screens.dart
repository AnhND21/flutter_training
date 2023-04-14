import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/components/custom_bottom_tabs.dart';
import 'package:flutter_training/components/menu_actions.dart';
import 'package:flutter_training/components/most_popular_movie.dart';
import 'package:flutter_training/components/upcoming_movies.dart';
import 'package:flutter_training/screens/movies/controller.dart';
import 'package:flutter_training/screens/movies/provider/genres_provider.dart';
import 'package:flutter_training/screens/movies/provider/movie_provider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MoviesScreen extends GetView<MovieController> {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: Obx(() {
          return Container(
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
                    // FocusScope.of(context).unfocus();
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Obx(() => SingleChildScrollView(
                          padding: const EdgeInsets.only(bottom: 64),
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
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
                                              color: Colors.white,
                                              fontSize: 20),
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
                              InkWell(
                                onTap: () {
                                  // Navigator.pushNamed(context, '/movie_search');
                                },
                                child: Hero(
                                  tag: 'searchHero',
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: Container(
                                      height: 50,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 32),
                                      decoration: BoxDecoration(
                                          gradient:
                                              const LinearGradient(colors: [
                                            Color.fromARGB(60, 107, 102, 166),
                                            Color.fromARGB(60, 158, 189, 251)
                                          ]),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(16)),
                                          border: Border.all(
                                              width: 0.5, color: Colors.white)),
                                      child: TextFormField(
                                        textInputAction: TextInputAction.next,
                                        enabled: false,
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
                                              fontSize: 16,
                                              color: Colors.white,
                                              height: 1),
                                          isDense: true,
                                          border: const OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(16))),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // if (controller
                              //     .state.rxStatus.isLoading.obs.isTrue)
                              //   const Padding(
                              //     padding: EdgeInsets.only(top: 32.0),
                              //     child: Center(
                              //       child: CircularProgressIndicator(
                              //           strokeWidth: 1),
                              //     ),
                              //   )
                              // else
                              //   Column(
                              //     children: [
                              //       // MostPopularMovies(movieList: fetchedMovie),
                              //       // MenuActions(actions: fetchedGenres),
                              //       // UpcomingMovies(
                              //       //     comingUpMovieList: fetchedMovie),
                              //     ],
                              //   )
                            ],
                          ),
                        )),
                  ),
                ),
              )));
        }),
        bottomNavigationBar: customBottomNavigationBar(context),
        backgroundColor: Colors.white,
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
