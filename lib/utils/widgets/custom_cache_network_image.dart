import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedImageCircle extends StatelessWidget {
  final String image;
  final double height;
  final BorderRadius? borderRadius;
  final double width;
  final Border? border;
  const CustomCachedImageCircle({
    super.key,
    required this.image,
    this.borderRadius,
    this.height = 40,
    this.border,
    this.width = 40,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(5),
          border: border ?? Border.all(color: Colors.transparent),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      height: height,
      width: width,
      placeholder: (context, url) => Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(5),
          border: Border.all(
            width: 0.5,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
        child: const Center(
          child: Icon(
            Icons.mood_rounded,
            size: 30,
          ),
        ),
      ),
      errorWidget: (context, url, error) => const Icon(
        Icons.mood_bad,
        size: 30,
      ),
    );
  }
}
