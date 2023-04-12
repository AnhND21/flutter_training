import 'package:flutter/material.dart';

class SearchContent extends StatelessWidget {
  final String? content;
  final TextEditingController? editingController;
  final Widget? widget;
  const SearchContent({
    super.key,
    this.content,
    this.editingController,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        child: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.black38, Colors.black],
              begin: Alignment.center,
              end: Alignment.bottomCenter)),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Marvel_Logo.png',
              fit: BoxFit.contain,
              width: 260,
            ),
            editingController != null
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 24),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      controller: editingController,
                      cursorColor: Colors.red,
                      decoration: const InputDecoration(
                          hintText: "Search...", border: InputBorder.none),
                    ),
                  )
                : Container(),
            editingController != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    child: Text(
                      content ?? "",
                      style: const TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                          fontWeight: FontWeight.w800),
                      textAlign: TextAlign.center,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    ));
  }
}
