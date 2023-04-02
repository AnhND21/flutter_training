import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_training/core/theme_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  late VideoPlayerController _controller;
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });

    _youtubeController = YoutubePlayerController(
      initialVideoId: 'TkrtpiNcfUA',
      flags: const YoutubePlayerFlags(
          // isLive: true,
          ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(top: 64),
              decoration: BoxDecoration(
                  boxShadow: themeChangeProvider.darkTheme == false
                      ? [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 30,
                            offset: const Offset(1, 1),
                          )
                        ]
                      : [],
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              child: Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(60)),
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://cdnimg.vietnamplus.vn/uploaded/bokttj/2023_01_02/avatar_the_way_of_water.jpg",
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text(
                            'Avatar: The way of Water',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text('avatar.com.vn',
                              style: TextStyle(color: Colors.black)),
                        ],
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  boxShadow: themeChangeProvider.darkTheme == false
                      ? [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 30,
                            offset: const Offset(1, 1),
                          )
                        ]
                      : [],
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              child: Container(
                margin: const EdgeInsets.only(left: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SvgPicture.asset("assets/svgs/faq.svg"),
                    Container(
                        margin: const EdgeInsets.only(left: 8, top: 4),
                        child: const Text(
                          "FAQ",
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  boxShadow: themeChangeProvider.darkTheme == false
                      ? [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 30,
                            offset: const Offset(1, 1),
                          )
                        ]
                      : [],
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              child: Container(
                margin: const EdgeInsets.only(left: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SvgPicture.asset("assets/svgs/contact.svg"),
                    Container(
                        margin: const EdgeInsets.only(left: 8, top: 4),
                        child: const Text(
                          "Contact",
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  boxShadow: themeChangeProvider.darkTheme == false
                      ? [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 30,
                            offset: const Offset(1, 1),
                          )
                        ]
                      : [],
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              child: Container(
                margin: const EdgeInsets.only(left: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SvgPicture.asset("assets/svgs/term.svg"),
                    Container(
                        margin: const EdgeInsets.only(left: 8, top: 4),
                        child: const Text(
                          "Term & Conditions",
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('Video',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 8,
                  ),
                  _controller.value.isInitialized
                      ? Stack(alignment: Alignment.center, children: <Widget>[
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16)),
                            child: AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: VideoPlayer(_controller),
                            ),
                          ),
                          Positioned(
                              child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _controller.value.isPlaying
                                          ? _controller.pause()
                                          : _controller.play();
                                    });
                                  },
                                  icon: Icon(
                                    _controller.value.isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    color: Colors.white,
                                    size: 40,
                                  )))
                        ])
                      : const Text("Loading..."),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('Video Youtube',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 8,
                  ),
                  Stack(alignment: Alignment.center, children: <Widget>[
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      child: YoutubePlayer(
                        controller: _youtubeController,
                        showVideoProgressIndicator: true,
                        progressColors: const ProgressBarColors(
                          playedColor: Colors.white,
                          handleColor: Colors.white,
                        ),
                        // onReady: () {
                        //   _youtubeController.addListener(listener);
                        // },
                      ),
                    ),
                  ])
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
