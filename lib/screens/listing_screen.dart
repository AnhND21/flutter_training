import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/components/listing_food.dart';
import 'package:flutter_training/core/theme_provider.dart';
import 'package:flutter_training/models/food.dart';
import 'package:provider/provider.dart';

class ListingScreen extends StatefulWidget {
  const ListingScreen({super.key});

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  late List<Foods> list = [];

  @override
  void initState() {
    super.initState();
    list.add(
      Foods(
          name: 'Salad',
          src:
              "https://cdn.britannica.com/36/123536-050-95CB0C6E/Variety-fruits-vegetables.jpg",
          description: "16,232 photos"),
    );
    list.add(
      Foods(
          name: 'Cucumbers',
          src:
              "https://swsphn.com.au/wp-content/uploads/2022/04/eating-healthy.jpg",
          description: '20,300 photos'),
    );
    list.add(
      Foods(
          name: 'Tomatos',
          src:
              "https://www.heart.org/-/media/Images/News/2019/April-2019/0429SustainableFoodSystem_SC.jpg",
          description: "98,122 photos"),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        title: const Text(
          'Listing',
          style: TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // automaticallyImplyLeading: true,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                themeChange.darkTheme = !themeChange.darkTheme;
              },
              icon: const Icon(
                CupertinoIcons.search,
              ))
        ],
      ),
      body: RefreshIndicator(
          color: Colors.red,
          onRefresh: () async {},
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(16),
              // color: Colors.white,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ListingFood(list: list, horizontal: true),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Expanded(
                              child: Text(
                            'Browser category',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          )),
                          Row(
                            children: const <Widget>[
                              Text('Sort by',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600)),
                              Icon(Icons.swap_vert_rounded, color: Colors.red)
                            ],
                          )
                        ],
                      ),
                    ),
                    ListingFood(
                      list: list,
                    ),
                  ]),
            ),
          )),
    );
  }
}
