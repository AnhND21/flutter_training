import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/screens/welcome/index.dart';
import 'package:get/get.dart';

class WelcomePage extends GetView<WelcomeController> {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => SizedBox(
        // width: 360,
        // height: 780,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView(
              scrollDirection: Axis.horizontal,
              reverse: false,
              onPageChanged: (index) {
                controller.onPageChaged(index);
              },
              controller: PageController(
                  initialPage: 0, keepPage: false, viewportFraction: 1),
              pageSnapping: true,
              physics: const ClampingScrollPhysics(),
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/poster4.jpg'))),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text(
                          'Welcome, there!',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Connect with all your friends \nin the internet.',
                          style: TextStyle(height: 1.5),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/poster4.jpg'))),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text(
                          'Chat - Call Video',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Chat and call video P2P in your application.\n Connect all friends in the world.',
                          style: TextStyle(height: 1.5),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/poster4.jpg'))),
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Text(
                              'Watching',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              'Watching perfect movies with Full HD mode.',
                              style: TextStyle(height: 1.5),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                        Positioned(
                            bottom: 110,
                            child: SizedBox(
                              width: 100,
                              height: 32,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(16)))),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.blueAccent)),
                                  onPressed: () {
                                    controller.goToMainPage();
                                  },
                                  child: const Text(
                                    'Start',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  )),
                            ))
                      ],
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 80,
              child: DotsIndicator(
                reversed: false,
                position: controller.state.slideIndex.value.toDouble(),
                dotsCount: 3,
                decorator: const DotsDecorator(
                    size: Size.square(9),
                    activeSize: Size(18, 9),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    color: Colors.grey,
                    activeColor: Colors.blue),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
