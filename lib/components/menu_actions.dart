import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuActions extends StatelessWidget {
  const MenuActions({
    super.key,
  });

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
        children: <Widget>[
          Container(
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
                const Text('Genres',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12))
              ],
            ),
          ),
          Container(
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
                SizedBox(
                  height: 40,
                  child: SvgPicture.asset('assets/svgs/tvseries.svg'),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text('TV series',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12))
              ],
            ),
          ),
          Container(
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
                SizedBox(
                    height: 40,
                    child: SvgPicture.asset('assets/svgs/movie.svg')),
                const SizedBox(
                  height: 4,
                ),
                const Text('Movies',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12))
              ],
            ),
          ),
          Container(
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
                        fontWeight: FontWeight.w500,
                        fontSize: 12))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
