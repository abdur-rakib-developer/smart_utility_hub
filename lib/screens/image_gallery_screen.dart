import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

// Image gallery screen displaying network images
class ImageGalleryScreen extends StatelessWidget {
  const ImageGalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.largePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppConstants.galleryTitle,
            style: AppConstants.headingStyle,
          ),
          const SizedBox(height: AppConstants.smallPadding),
          Text(
            'Browse beautiful random images',
            style: AppConstants.labelStyle,
          ),
          const SizedBox(height: AppConstants.largePadding),
          
          // Description card
          Card(
            color: AppConstants.surfaceColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.mediumPadding),
              child: Row(
                children: [
                  Icon(Icons.info, color: AppConstants.primaryColor),
                  const SizedBox(width: AppConstants.smallPadding),
                  Expanded(
                    child: Text(
                      'Images are fetched from Picsum Photos API',
                      style: AppConstants.bodyStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppConstants.largePadding),
          
          // Image grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppConstants.mediumPadding,
              mainAxisSpacing: AppConstants.mediumPadding,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              // Use different seeds for different images
              final seed = index + 1;
              return _ImageCard(
                imageUrl: 'https://picsum.photos/seed/$seed/300',
                index: index,
              );
            },
          ),
        ],
      ),
    );
  }
}

// Image card widget
class _ImageCard extends StatelessWidget {
  final String imageUrl;
  final int index;

  const _ImageCard({
    required this.imageUrl,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                    color: AppConstants.primaryColor,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppConstants.surfaceColor,
                  child: const Center(
                    child: Icon(
                      Icons.error,
                      color: AppConstants.errorColor,
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(AppConstants.smallPadding),
            color: AppConstants.surfaceColor,
            child: Text(
              'Image ${index + 1}',
              style: AppConstants.labelStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
