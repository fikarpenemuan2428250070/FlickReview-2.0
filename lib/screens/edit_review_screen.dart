import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flickreview/services/cloudinary_service.dart';
import 'package:image_picker/image_picker.dart';
import 'location_picker_screen.dart';

class EditReviewScreen extends StatefulWidget {
  final Map<String, dynamic> reviewData;

  const EditReviewScreen({super.key, required this.reviewData});

  @override
  State<EditReviewScreen> createState() => _EditReviewScreenState();
}

class _EditReviewScreenState extends State<EditReviewScreen> {
  final TextEditingController _reviewController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  List<String> existingImageUrls = [];
  List<File> newSelectedImages = [];

  String locationName = '';
  double? latitude;
  double? longitude;
  bool isAutoLocation = false;

  double rating = 0.0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    rating = (widget.reviewData['rating'] ?? 0).toDouble();
    _reviewController.text = widget.reviewData['review'] ?? '';
    existingImageUrls = List<String>.from(
      widget.reviewData['reviewImageUrls'] ?? [],
    );

    locationName = widget.reviewData['locationName'] ?? '';
    latitude = widget.reviewData['latitude'];
    longitude = widget.reviewData['longitude'];
    isAutoLocation = widget.reviewData['isAutoLocation'] ?? false;
  }

  void increaseRating() {
    setState(() {
      rating = double.parse((rating + 0.1).toStringAsFixed(1));
      if (rating > 5.0) rating = 5.0;
    });
  }

  void decreaseRating() {
    setState(() {
      rating = double.parse((rating - 0.1).toStringAsFixed(1));
      if (rating < 0.0) rating = 0.0;
    });
  }

  void setRatingFromStar(int value) {
    setState(() {
      rating = value.toDouble();
    });
  }

  IconData getStarIcon(int starNumber) {
    final fullStars = rating.floor();
    final decimal = rating - fullStars;

    if (starNumber <= fullStars) return Icons.star;

    if (starNumber == fullStars + 1) {
      if (decimal >= 0.5 && decimal <= 0.8) return Icons.star_half;
      if (decimal > 0.8) return Icons.star;
    }

    return Icons.star_border;
  }

  Widget buildStar(int starNumber) {
    return GestureDetector(
      onTap: () => setRatingFromStar(starNumber),
      child: Icon(getStarIcon(starNumber), color: Colors.orange, size: 34),
    );
  }

  Future<void> updateReview() async {
    final movieId = widget.reviewData['movieId'];
    final reviewId = widget.reviewData['reviewId'];
    final reviewText = _reviewController.text.trim();

    if (rating == 0 || reviewText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Rating and review are required')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final newUploadedUrls = await CloudinaryService.uploadMultipleImages(
        newSelectedImages,
      );

      final finalImageUrls = [...existingImageUrls, ...newUploadedUrls];

      await FirebaseFirestore.instance
          .collection('movie_reviews')
          .doc(movieId)
          .collection('reviews')
          .doc(reviewId)
          .update({
            'rating': rating,
            'review': reviewText,
            'reviewImageUrls': finalImageUrls,
            'locationName': locationName,
            'latitude': latitude,
            'longitude': longitude,
            'isAutoLocation': isAutoLocation,
            'updatedAt': Timestamp.now(),
            'isEdited': true,
          });

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Review updated')));

      Navigator.pop(context, true);
      Navigator.pop(context, true);
    } catch (e) {
      debugPrint('UPDATE REVIEW ERROR: $e');

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to update review')));
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> pickNewImages() async {
    final images = await _picker.pickMultiImage(
      imageQuality: 80,
      maxWidth: 1280,
      maxHeight: 1280,
    );

    if (images.isEmpty) return;

    setState(() {
      newSelectedImages.addAll(
        images.map((image) => File(image.path)).toList(),
      );
    });
  }

  Future<void> openLocationPicker() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(builder: (_) => const LocationPickerScreen()),
    );

    if (result == null) return;

    setState(() {
      locationName = result['locationName'] ?? '';
      latitude = result['latitude'];
      longitude = result['longitude'];
      isAutoLocation = result['isAutoLocation'] ?? false;
    });
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final movieTitle = widget.reviewData['movieTitle'] ?? 'Movie';

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Review')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              movieTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 24),

            const Text(
              'Edit Rating',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: decreaseRating,
                  icon: const Icon(Icons.remove_circle),
                  color: Colors.red,
                  iconSize: 32,
                ),
                Row(
                  children: [
                    buildStar(1),
                    buildStar(2),
                    buildStar(3),
                    buildStar(4),
                    buildStar(5),
                  ],
                ),
                IconButton(
                  onPressed: increaseRating,
                  icon: const Icon(Icons.add_circle),
                  color: Colors.green,
                  iconSize: 32,
                ),
              ],
            ),

            Text(
              '${rating.toStringAsFixed(1)} / 5',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 24),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Edit Review',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Images',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 8),

            SizedBox(
              height: 96,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ...existingImageUrls.asMap().entries.map((entry) {
                    final index = entry.key;
                    final imageUrl = entry.value;

                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              imageUrl,
                              width: 86,
                              height: 86,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  existingImageUrls.removeAt(index);
                                });
                              },
                              child: const CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.black54,
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),

                  ...newSelectedImages.asMap().entries.map((entry) {
                    final index = entry.key;
                    final image = entry.value;

                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              image,
                              width: 86,
                              height: 86,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  newSelectedImages.removeAt(index);
                                });
                              },
                              child: const CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.black54,
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),

                  GestureDetector(
                    onTap: isLoading ? null : pickNewImages,
                    child: Container(
                      width: 86,
                      height: 86,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 42,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            TextField(
              controller: _reviewController,
              maxLines: 7,
              decoration: const InputDecoration(
                hintText: 'Update your review...',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 18),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Location',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 8),

            InkWell(
              onTap: openLocationPicker,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.location_on),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        locationName.isNotEmpty ? locationName : 'Add location',
                        style: TextStyle(
                          color: locationName.isNotEmpty
                              ? Colors.blue
                              : Colors.grey[700],
                          fontWeight: locationName.isNotEmpty
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                    const Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : updateReview,
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      )
                    : const Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
