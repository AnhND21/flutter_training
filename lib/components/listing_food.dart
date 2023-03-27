import 'package:flutter/material.dart';
import 'package:flutter_training/models/food.dart';

class ListingFood extends StatelessWidget {
  final List<Foods> list;
  final bool horizontal;

  const ListingFood({Key? key, required this.list, this.horizontal = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return horizontal
        ? HorizontalListItem(list: list)
        : SizedBox(
            child: GridView.count(
              padding: const EdgeInsets.all(0),
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.8,
              shrinkWrap: true,
              children: List.generate(list.length, (index) {
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      child: Image.network(
                        list[index].src,
                        fit: BoxFit.cover,
                        height: 262,
                      ),
                    ),
                    Positioned(
                        child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          gradient: LinearGradient(
                              colors: [Colors.black12, Colors.black],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                      height: 262,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(list[index].name,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16)),
                          Text(list[index].description,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ))
                  ],
                );
              }),
            ),
          );
  }
}

class HorizontalListItem extends StatelessWidget {
  const HorizontalListItem({
    super.key,
    required this.list,
  });

  final List<Foods> list;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Stack(
              alignment: Alignment.topLeft,
              children: <Widget>[
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  child: Image.network(
                    list[index].src,
                    height: 232,
                    width: MediaQuery.of(context).size.width - 32,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    child: Container(
                  alignment: Alignment.bottomLeft,
                  height: 232,
                  width: MediaQuery.of(context).size.width - 32,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      gradient: LinearGradient(
                          colors: [Colors.black12, Colors.black],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(list[index].name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600)),
                      Text(list[index].description,
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ))
              ],
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              width: 10,
              height: 1,
            );
          },
          itemCount: list.length),
    );
  }
}
