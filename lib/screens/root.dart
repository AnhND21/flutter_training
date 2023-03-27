import 'package:flutter/material.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  List<String> list = <String>[
    "Exercise 1",
    'Exercise 2',
    'Exercise 3',
    'Exercise 4',
    'Exercise 5'
  ];

  void onNavigateToScreen(int index) {
    String route = '';
    switch (index) {
      case 0:
        route = '/listing';
        break;
      case 1:
        route = '/profile';
        break;
      default:
    }

    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          // backgroundColor: Colors.white,
          drawerEnableOpenDragGesture: true,
          appBar: AppBar(
            leading: Container(),
            title: const Text(
              'Flutter Mobile Traning',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            // Here we create one to set status bar color
            elevation: 0,
            // backgroundColor: Colors
            //     .white, // Set any color of status bar you want; or it defaults to your theme's primary color
          ),
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(children: <Widget>[
                const SizedBox(
                  height: 48,
                ),
                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 24,
                  childAspectRatio: 2,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  children: List.generate(list.length, (index) {
                    return InkWell(
                      onTap: () {
                        onNavigateToScreen(index);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.grey.withOpacity(0.3),
                            //     spreadRadius: 1,
                            //     blurRadius: 30,
                            //     offset: const Offset(1, 1),
                            //   )
                            // ],
                            // color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Text(list[index],
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                    );
                  }),
                )
              ]),
            ),
          ),
        ));
  }
}
