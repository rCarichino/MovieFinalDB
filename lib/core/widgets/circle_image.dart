import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:moviedb/core/widgets/loading.dart';
import '../resources/dimens.dart';

class CircleImage extends StatelessWidget {
  final String url;
  final double? size;

  const CircleImage({super.key, required this.url, this.size});

  @override
  Widget build(BuildContext context) {
    /// TODO Need to change with Fix on error image url
    return ClipRRect(
      /// 360 degree circle
      child: CachedNetworkImage(
        fit: BoxFit.contain,
        width: size,
        height: size,
        fadeInDuration: const Duration(milliseconds: 300),
        imageUrl: url,
        placeholder: (context, url) => SizedBox(
          width: Dimens.space46,
          height: Dimens.space46,
          child: const Loading(showMessage: false),
        ),
        // errorWidget: (context, url, error) =>
        //     new SvgPicture.asset(Images.icEmpty),
      ),
    );
  }
}
