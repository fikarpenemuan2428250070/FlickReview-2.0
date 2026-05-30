import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GalleryPreviewScreen extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const GalleryPreviewScreen({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  @override
  State<GalleryPreviewScreen> createState() => _GalleryPreviewScreenState();
}

class _GalleryPreviewScreenState extends State<GalleryPreviewScreen> {
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemBuilder: (context, index) {
              return InteractiveViewer(
                minScale: 1,
                maxScale: 4,
                panEnabled: true,
                clipBehavior: Clip.none,
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl: widget.images[index],
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
          ),

          // CLOSE BUTTON
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 28),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // INDICATOR
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "${_currentIndex + 1} / ${widget.images.length}",
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
