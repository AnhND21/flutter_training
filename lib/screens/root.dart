import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/commons/routes/app_routes.dart';
import 'package:flutter_training/screens/root/controller.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class RootScreen extends GetView<RootController> {
  RootScreen({super.key});
  final List<String> list = <String>[
    "Listing",
    'Profile',
    'Movies',
    'Weather',
    'Firebase Chat',
    'Notes',
    'Routes',
  ];

  void onNavigateToScreen(int index) {
    String route = '';
    switch (index) {
      case 0:
        route = AppRoutes.LISTING_SCREEN;
        break;
      case 1:
        route = AppRoutes.PROFILE_SCREEN;
        break;
      case 2:
        route = AppRoutes.MOVIE_SCREEN;
        break;
      case 3:
        route = AppRoutes.WEATHER_SCREEN;
        break;
      case 4:
        route = AppRoutes.WELCOME_CHAT_SCREEN;
        break;
      case 5:
        route = AppRoutes.NOTE_SCREEN;
        break;
      case 6:
        route = AppRoutes.SEARCH_SCREEN;
        break;
      default:
    }

    controller.goToPage(route);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Obx(() => Scaffold(
              // backgroundColor: Colors.white,
              drawerEnableOpenDragGesture: true,
              appBar: AppBar(
                leading: const Icon(CupertinoIcons.bars),
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
                  padding: const EdgeInsets.all(24),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 16,
                        ),
                        ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(0),
                            itemCount: list.length,
                            separatorBuilder: (context, index) {
                              return Container(
                                height: 24,
                              );
                            },
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  onNavigateToScreen(index);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 1,
                                          blurRadius: 30,
                                          offset: const Offset(1, 1),
                                        )
                                      ],
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8))),
                                  child: Row(
                                    children: [
                                      const FlutterLogo(
                                        size: 20,
                                        curve: Curves.bounceIn,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: Text(list[index],
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black)),
                                      ),
                                      const Icon(
                                        CupertinoIcons.chevron_right,
                                        size: 20,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ]),
                ),
              ),
              bottomNavigationBar: Container(
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: GNav(
                      selectedIndex: controller.state.tabIndex.value.toInt(),
                      curve: Curves.bounceIn,
                      gap: 8,
                      backgroundColor: Colors.white,
                      color: Colors.blue.shade100,
                      activeColor: Colors.blueAccent,
                      haptic: true,
                      tabBorderRadius: 32,
                      tabBackgroundColor: Colors.blueAccent.withOpacity(0.2),
                      padding: const EdgeInsets.all(16),
                      onTabChange: (value) {
                        controller.onTabChaged(value);
                      },
                      tabs: const [
                        GButton(
                          icon: Icons.home,
                        ),
                        GButton(
                          icon: Icons.search,
                        ),
                        GButton(
                          icon: Icons.star,
                        ),
                        GButton(
                          icon: Icons.list_alt,
                        ),
                        GButton(
                          icon: Icons.person_2_outlined,
                        )
                      ]),
                ),
              ),
            )));
  }
}
