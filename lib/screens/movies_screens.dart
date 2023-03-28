import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_training/models/movies.dart';

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
  int _sliderIndex = 0;
  List<Movies> movieList = <Movies>[];

  @override
  void initState() {
    super.initState();
    movieList.add(Movies(
        movieName: "Avatar: The way of Water",
        imdb: '9.8',
        thumbnail:
            'https://bloganchoi.com/wp-content/uploads/2022/08/avatar-a2.jpg'));
    movieList.add(Movies(
        movieName: "Minion: The Growth of Gru",
        imdb: '9.6',
        thumbnail:
            'https://media.vov.vn/sites/default/files/styles/large/public/2022-07/untitled-11.jpg'));
    movieList.add(Movies(
        movieName: "Ant-Man: The Quantumania",
        imdb: '8.8',
        thumbnail:
            'https://images2.thanhnien.vn/zoom/700_438/528068263637045248/2023/2/17/ant-man-3-4x5-16766045112201851823482-103-0-778-1080-crop-1676606662304105094367.jpeg'));
  }

  void onSliderIndexChange(int index) {
    setState(() {
      _sliderIndex = index;
    });
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
                                    color: Colors.white,
                                    width: 0.5,
                                  ))),
                                  child: const Icon(
                                    CupertinoIcons.mic,
                                    color: Colors.white,
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
                          Container(
                            alignment: Alignment.topLeft,
                            // padding: const EdgeInsets.all(32),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32),
                                  margin: const EdgeInsets.only(top: 24),
                                  child: const Text('Most popular',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600)),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Column(
                                  children: [
                                    CarouselSlider(
                                      options: CarouselOptions(
                                          pageSnapping: true,
                                          height: 141.0,
                                          autoPlayInterval:
                                              const Duration(seconds: 3),
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
                                      items: movieList.map((i) {
                                        return Builder(
                                          builder: (BuildContext context) {
                                            return Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 5.0,
                                                ),
                                                child: Stack(
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    fit: StackFit.expand,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    32)),
                                                        child:
                                                            CachedNetworkImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                imageUrl: i
                                                                    .thumbnail),
                                                      ),
                                                      Positioned(
                                                          child: Container(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        decoration: const BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius
                                                                        .circular(
                                                                            32)),
                                                            gradient: LinearGradient(
                                                                colors: [
                                                                  Colors
                                                                      .black12,
                                                                  Colors.black
                                                                ],
                                                                begin: Alignment
                                                                    .center,
                                                                end: Alignment
                                                                    .bottomCenter)),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      16,
                                                                  vertical: 8),
                                                              child: Text(
                                                                  i.movieName,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          18)),
                                                            ),
                                                            Container(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal: 8,
                                                                  vertical: 2),
                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          16),
                                                              decoration: const BoxDecoration(
                                                                  color: Colors
                                                                      .yellow,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              16))),
                                                              child: Text(
                                                                "IMDb ${i.imdb}",
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        10),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ))
                                                    ]));
                                          },
                                        );
                                      }).toList(),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    DotsIndicator(
                                      dotsCount: movieList.length,
                                      position: _sliderIndex.toDouble(),
                                      decorator: const DotsDecorator(
                                          activeColor: Color.fromARGB(
                                              255, 102, 68, 250)),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 32),
                            // height: 120,
                            child: GridView.count(
                              crossAxisCount: 4,
                              shrinkWrap: true,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              // scrollDirection: Axis.horizontal,
                              childAspectRatio: 0.8,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.only(top: 16),
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(top: 16),
                                  decoration: const BoxDecoration(
                                    border: Border.fromBorderSide(BorderSide(
                                        width: 1, color: Colors.white38)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                    gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF64ABDB),
                                          Color(0xFF826EC8)
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.centerRight),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 40,
                                        child: SvgPicture.asset(
                                          "assets/svgs/menu.svg",
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Container(
                                        height: 8,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(top: 16),
                                  decoration: const BoxDecoration(
                                    border: Border.fromBorderSide(BorderSide(
                                        width: 1, color: Colors.white38)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                    gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF64ABDB),
                                          Color(0xFF826EC8)
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.centerRight),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 40,
                                        child: SvgPicture.asset(
                                            'assets/svgs/tvseries.svg'),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      const Text('TV series',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500))
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(top: 16),
                                  decoration: const BoxDecoration(
                                    border: Border.fromBorderSide(BorderSide(
                                        width: 1, color: Colors.white38)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                    gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF64ABDB),
                                          Color(0xFF826EC8)
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.centerRight),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          height: 40,
                                          child: SvgPicture.asset(
                                              'assets/svgs/movie.svg')),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      const Text('Movies',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500))
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(top: 16),
                                  decoration: const BoxDecoration(
                                    border: Border.fromBorderSide(BorderSide(
                                        width: 1, color: Colors.white38)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                    gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF64ABDB),
                                          Color(0xFF826EC8)
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.centerRight),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 40,
                                        child: SvgPicture.asset(
                                          "assets/svgs/theatre.svg",
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      const Text('In Theatre',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.only(top: 32),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 32),
                                  child: Text(
                                    "Upcoming Release",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                CarouselSlider(
                                  options: CarouselOptions(
                                      pageSnapping: true,
                                      // height: 214.0,
                                      autoPlayInterval:
                                          const Duration(seconds: 3),
                                      autoPlayAnimationDuration:
                                          const Duration(milliseconds: 800),
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      // enlargeCenterPage: true,
                                      // autoPlay: true,
                                      enlargeFactor: 0.5,
                                      aspectRatio: 1.8,
                                      scrollDirection: Axis.horizontal,
                                      onPageChanged: (index, reason) =>
                                          {onSliderIndexChange(index)},
                                      initialPage: _sliderIndex),
                                  items: movieList.map((e) {
                                    return Builder(
                                      builder: (context) {
                                        return Container(
                                          width: 145,
                                          height: 214,
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(32)),
                                            child: CachedNetworkImage(
                                                width: 145,
                                                height: 214,
                                                fit: BoxFit.cover,
                                                imageUrl: e.thumbnail),
                                          ),
                                        );
                                      },
                                    );
                                  }).toList(),
                                )
                              ],
                            ),
                          )
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

Widget customBottomNavigationBar(BuildContext context) {
  double myHeight = 70.0; //Your height HERE
  return Container(
    decoration: const BoxDecoration(
        border: Border(top: BorderSide(width: 0.5, color: Colors.white)),
        gradient: LinearGradient(
            colors: [Color(0xFF2B5876), Color(0xFF4E4376)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight)),
    height: myHeight,
    width: MediaQuery.of(context).size.width,
    padding: const EdgeInsets.only(left: 32, right: 32, bottom: 24, top: 12),
    child: const TabBar(
      dividerColor: Colors.white,
      tabs: [
        Tab(
            icon: Icon(
          CupertinoIcons.house_alt,
          size: 26.0,
          color: Colors.white,
        )),
        Tab(
            icon: Icon(
          CupertinoIcons.heart,
          size: 26.0,
          color: Colors.white,
        )),
        Tab(
            icon: Icon(
          CupertinoIcons.ticket,
          size: 26.0,
          color: Colors.white,
        )),
        Tab(
            icon: Icon(
          CupertinoIcons.person,
          size: 26.0,
          color: Colors.white,
        )),
        Tab(
            icon: Icon(
          Icons.share_outlined,
          size: 26.0,
          color: Colors.white,
        ))
      ],
      // labelStyle: TextStyle(fontSize: 12.0),
      labelColor: Colors.white,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 1,
      indicator: UnderlineTabIndicator(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(width: 3.0, color: Colors.white),
        insets: EdgeInsets.symmetric(
          horizontal: 10,
        ),
      ),
    ),
  );
}
