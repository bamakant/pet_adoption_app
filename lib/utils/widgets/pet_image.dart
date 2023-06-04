import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PetImageWidget extends StatelessWidget {
  const PetImageWidget({super.key, this.imagePath});

  final String? imagePath;

  static const width = 150.0;
  static const height = 150.0;

  @override
  Widget build(BuildContext context) {
    if (imagePath != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: '$imagePath',
          width: width,
          height: height,
          placeholder: (_, __) => Shimmer.fromColors(
            baseColor: Colors.black26,
            highlightColor: Colors.black12,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black54),
              width: width,
              height: height,
            ),
          ),
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade900,
        boxShadow: kElevationToShadow[8],
      ),
    );
  }
}
