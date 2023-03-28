import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24, top: 12),
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
          CupertinoIcons.heart_fill,
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
