import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shewa_ui_kit/elements/widgets/shewa_loading.dart';

class ShewaImage extends StatelessWidget {
  const ShewaImage({
    Key? key,
    required this.url,
    this.height = 225,
    this.width = 225,
    this.radius = 0,
    this.boxFit = BoxFit.fill,
    this.errorWidget,
  }) : super(key: key);
  final String? url;
  final double height;
  final double width;
  final BoxFit boxFit;
  final double radius;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
          imageUrl: url ?? '',
          fit: boxFit,
          height: height,
          width: width,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              ShewaLoading(
                progress: downloadProgress.progress,
              ),
          errorWidget: (context, url, error) {
            return errorWidget ??
                SizedBox(
                  height: height,
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error,
                        size: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'حدثت مشكلة أثناء تحميل الصورة',
                          style: theme.textTheme.titleLarge!.copyWith(
                            color: theme.primaryColor,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 3,
                        ),
                      )
                    ],
                  ),
                );
          }),
    );
  }
}
