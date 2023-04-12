import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BackgroundRoute extends StatelessWidget {
  final String url;
  const BackgroundRoute({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      height: MediaQuery.of(context).size.height,
    );
  }
}
