// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_training/screens/movies/model/genres_model.dart';

class MenuActions extends StatelessWidget {
  List<GenresModel?> actions;
  MenuActions({Key? key, required this.actions}) : super(key: key);

  Widget renderIconAction(String name) {
    late String iconPath;
    switch (name) {
      case 'Action':
        iconPath = "assets/svgs/menu.svg";
        break;
      case "Adventure":
        iconPath = "assets/svgs/movie.svg";
        break;
      case "Animation":
        iconPath = "assets/svgs/tvseries.svg";
        break;
      case "Comedy":
        iconPath = "assets/svgs/theatre.svg";
        break;
    }

    return SizedBox(
      height: 40,
      child: SvgPicture.asset(
        iconPath,
        fit: BoxFit.contain,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32),
      // height: 120,
      child: GridView.count(
        crossAxisCount: 4,
        shrinkWrap: true,
        crossAxisSpacing: 12,
        // scrollDirection: Axis.horizontal,
        childAspectRatio: 0.8,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 16),
        children: List.generate(actions.take(4).length, (index) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 8),
            decoration: const BoxDecoration(
              border: Border.fromBorderSide(
                  BorderSide(width: 1, color: Colors.white38)),
              borderRadius: BorderRadius.all(Radius.circular(16)),
              gradient: LinearGradient(colors: [
                Color.fromARGB(100, 100, 171, 219),
                Color.fromARGB(100, 129, 110, 200)
              ], begin: Alignment.topLeft, end: Alignment.centerRight),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                renderIconAction(actions[index]!.name.toString()),
                const SizedBox(
                  height: 4,
                ),
                Text(actions[index]!.name.toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12))
              ],
            ),
          );
        }),
      ),
    );
  }
}
