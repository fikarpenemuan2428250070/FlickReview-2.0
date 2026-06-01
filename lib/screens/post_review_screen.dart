import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flickreview/services/cloudinary_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flickreview/l10n/app_localizations.dart';

import 'location_picker_screen.dart';
import 'package:flickreview/services/notification_service.dart';

class PostReviewScreen extends StatefulWidget {
  final String movieId;
  final String movieTitle;
  final String movieYear;
  final String movieGenre;
  final String movieDirector;
  final String posterUrl;

  const PostReviewScreen({
    super.key,
    required this.movieId,
    required this.movieTitle,
    required this.movieYear,
    required this.movieGenre,
    required this.movieDirector,
    required this.posterUrl,
  });

  @override
  State<PostReviewScreen> createState() => _PostReviewScreenState();
}

class _PostReviewScreenState extends State<PostReviewScreen> {
  final _reviewController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  double rating = 0.0;

  bool isLoading = false;

  String locationName = '';
  double? latitude;
  double? longitude;
  bool isAutoLocation = false;

  List<File> selectedImages = [];

  void setRatingFromStar(int value) {
    setState(() {
      rating = value.toDouble();
    });
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

  Future<void> pickReviewImages() async {
    final images = await _picker.pickMultiImage(
      imageQuality: 80,
      maxWidth: 1280,
      maxHeight: 1280,
    );

    if (images.isEmpty) return;

    setState(() {
      selectedImages.addAll(images.map((e) => File(e.path)).toList());
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

  Future<void> submitReview() async {
    final user = FirebaseAuth.instance.currentUser;
    final l10n = AppLocalizations.of(context)!;

    if (user == null) {
      Navigator.pushNamed(context, '/signin');
      return;
    }

    final reviewText = _reviewController.text.trim();

    if (rating == 0 || reviewText.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.ratingAndReviewRequired)));
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      final userData = userDoc.data();

      final username = userData?['username'] ?? 'User';
      final fullname = userData?['fullname'] ?? 'User';
      final profileImageUrl = userData?['profileImageUrl'] ?? '';

      final reviewImageUrls = await CloudinaryService.uploadMultipleImages(
        selectedImages,
      );

      await FirebaseFirestore.instance
          .collection('movie_reviews')
          .doc(widget.movieId)
          .collection('reviews')
          .doc(user.uid)
          .set({
            'userId': user.uid,
            'movieId': widget.movieId,
            'movieTitle': widget.movieTitle,
            'movieYear': widget.movieYear,
            'movieGenre': widget.movieGenre,
            'movieDirector': widget.movieDirector,
            'posterUrl': widget.posterUrl,
            'username': username,
            'fullname': fullname,
            'profileImageUrl': profileImageUrl,
            'rating': rating,
            'review': reviewText,
            'reviewImageUrls': reviewImageUrls,
            'locationName': locationName,
            'latitude': latitude,
            'longitude': longitude,
            'isAutoLocation': isAutoLocation,
            'createdAt': Timestamp.now(),
            'updatedAt': Timestamp.now(),
            'isEdited': false,
          });

      await NotificationService.sendReviewNotification(
        fullname: fullname,
        username: username,
        movieTitle: widget.movieTitle,
        movieYear: widget.movieYear,
        profileImageUrl: profileImageUrl,
        movieId: widget.movieId,
        reviewId: user.uid,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.reviewSubmittedSuccessfully)));

      Navigator.pop(context, true);
    } catch (e) {
      debugPrint('SUBMIT REVIEW ERROR: $e');

      final l10n = AppLocalizations.of(context)!;

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.failedToSubmitReview)));
    }

    setState(() {
      isLoading = false;
    });
  }

  Widget buildImagePickerRow() {
    return SizedBox(
      height: 96,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ...selectedImages.asMap().entries.map((entry) {
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
                          selectedImages.removeAt(index);
                        });
                      },
                      child: const CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.black54,
                        child: Icon(Icons.close, color: Colors.white, size: 14),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),

          GestureDetector(
            onTap: isLoading ? null : pickReviewImages,
            child: Container(
              width: 86,
              height: 86,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.add, size: 42, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final hasLocation = locationName.isNotEmpty;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.writeReview)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // MOVIE INFO
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.posterUrl,
                    width: 100,
                    height: 150,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 100,
                      height: 150,
                      color: Colors.grey[300],
                      child: const Icon(Icons.movie),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.movieTitle,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text("${widget.movieYear} • ${widget.movieGenre}"),
                      const SizedBox(height: 6),
                      Text(
                        "${l10n.director}: ${widget.movieDirector}",
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // RATING
            Center(
              child: Text(
                l10n.giveYourRating,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
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

            Center(
              child: Text(
                '${rating.toStringAsFixed(1)} / 5',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 22),

            // IMAGE UPLOAD
            Text(
              l10n.addImages,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            buildImagePickerRow(),

            const SizedBox(height: 24),

            // REVIEW TEXT
            Text(
              l10n.writeReview,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: _reviewController,
              maxLines: 7,
              decoration: InputDecoration(
                hintText: l10n.writeYourThoughts,
                border: const OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 18),

            // LOCATION
            Text(
              l10n.location,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                        hasLocation ? locationName : l10n.addLocation,
                        style: TextStyle(
                          color: hasLocation ? Colors.blue : Colors.grey[700],
                          fontWeight: hasLocation
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

            const SizedBox(height: 30),

            // SUBMIT
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : submitReview,
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      )
                    : Text(l10n.submitReview),
              ),
            ),

            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}
