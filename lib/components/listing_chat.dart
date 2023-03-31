import 'package:flutter/material.dart';

class ListingChat extends StatelessWidget {
  const ListingChat({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.separated(
          padding:
              const EdgeInsets.only(left: 24, right: 24, bottom: 24, top: 8),
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(children: [
                  Container(
                    width: 56,
                    height: 56,
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      child: Image.network(
                        'https://media-cdn-v2.laodong.vn/Storage/NewsPortal/2021/12/17/985676/Rose-Blackpink.jpeg',
                        fit: BoxFit.cover,
                        width: 48,
                        height: 48,
                      ),
                    ),
                  ),
                  Positioned(
                      right: 0,
                      top: 2,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(32)),
                            border: Border.all(color: Colors.white, width: 1)),
                        child: const Icon(
                          Icons.circle,
                          size: 14,
                          color: Colors.green,
                        ),
                      )),
                ]),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Athalia Putri',
                        style: TextStyle(fontSize: 18, height: 1),
                      ),
                      Text(
                        'Last message sent----',
                        style: TextStyle(color: Colors.grey, height: 2),
                        maxLines: 1,
                      )
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Today',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Container(
                      width: 16,
                      height: 16,
                      margin: const EdgeInsets.only(top: 8),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color(0xFFD2D5F9),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: const Text(
                        '2',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                )
              ],
            );
          },
          separatorBuilder: (context, index) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(vertical: 12),
            );
          },
          itemCount: 10),
    );
  }
}
