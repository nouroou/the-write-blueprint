import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:the_write_blueprint/core/common/widgets/loader.dart';

class BlogImage extends StatelessWidget {
  const BlogImage({
    super.key,
    required this.blogImage,
    required this.height,
    required this.width,
  });

  final String blogImage;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: CachedNetworkImage(
            fit: BoxFit.cover,
            placeholder: (context, url) => Center(child: Loader()),
            errorWidget: (context, url, error) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.broken_image, size: 50, color: Colors.grey),
                      SizedBox(height: 8),
                      Text(
                        'Failed to load image',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                ),
            height: height,
            width: width,
            imageUrl: blogImage));
  }
}
