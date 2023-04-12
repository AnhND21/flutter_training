import 'package:flutter/material.dart';

class ButtonBottom extends StatelessWidget {
  final String title;
  final Function onPress;
  const ButtonBottom({
    super.key,
    required this.title,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 32,
        child: InkWell(
          onTap: () {
            onPress();
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 32),
            width: MediaQuery.of(context).size.width - 64,
            decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Text(title,
                style: const TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ));
  }
}
