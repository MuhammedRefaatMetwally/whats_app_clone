import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../theme/style.dart';

class ProfileWidget extends StatelessWidget {
final String? imageUrl;
final File? image;
  const ProfileWidget({super.key, this.imageUrl, this.image});

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      if (imageUrl == null || imageUrl == "") {
        return Image.asset(
          'assets/profile_default.png',
          fit: BoxFit.cover,
        );
      } else {
        return CachedNetworkImage(
          imageUrl: imageUrl!,
          fit: BoxFit.cover,
          progressIndicatorBuilder: (context, url, downloadProgress) {
            return const CircularProgressIndicator(color: tabColor,);
          },
          errorWidget: (context, url, error) => Image.asset(
            'assets/profile_default.png',
            fit: BoxFit.cover,
          ),
        );
      }
    } else {
      return Image.file(image!, fit: BoxFit.cover,);
    }
  }
}

