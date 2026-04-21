import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Full-screen image viewer with pinch-to-zoom.
class ImageViewerScreen extends StatelessWidget {
  final String imageUrl;
  final String? title;

  const ImageViewerScreen({
    super.key,
    required this.imageUrl,
    this.title,
  });

  static void show({required String imageUrl, String? title}) {
    Get.to(
      () => ImageViewerScreen(imageUrl: imageUrl, title: title),
      transition: Transition.fadeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black.withValues(alpha: 0.5),
        elevation: 0,
        title: title != null
            ? Text(title!, style: AppTextStyles.labelLarge.copyWith(color: Colors.white))
            : null,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 0.5,
          maxScale: 4.0,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.contain,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
            errorWidget: (context, url, error) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.broken_image_rounded, color: Colors.white38, size: 64),
                const SizedBox(height: 16),
                Text('something_went_wrong'.tr,
                    style: AppTextStyles.bodyMedium.copyWith(color: Colors.white54)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
