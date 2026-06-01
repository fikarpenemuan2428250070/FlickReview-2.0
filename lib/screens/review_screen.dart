import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flickreview/l10n/app_localizations.dart';
import 'gallery_preview_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'edit_review_screen.dart';

class ReviewScreen extends StatelessWidget {
  final Map<String, dynamic> reviewData;

  const ReviewScreen({super.key, required this.reviewData});

  Future<void> openMaps() async {
    final locationName = reviewData['locationName'] ?? '';
    final latitude = reviewData['latitude'];
    final longitude = reviewData['longitude'];

    String url = '';

    if (latitude != null && longitude != null) {
      url =
          'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    } else if (locationName.toString().isNotEmpty) {
      final encoded = Uri.encodeComponent(locationName);
      url = 'https://www.google.com/maps/search/?api=1&query=$encoded';
    }

    if (url.isEmpty) return;

    final uri = Uri.parse(url);

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final fullname = reviewData['fullname'] ?? l10n.unknownUser;
    final username = reviewData['username'] ?? 'user';
    final profileImageUrl = reviewData['profileImageUrl'] ?? '';
    final rating = (reviewData['rating'] ?? 0).toDouble();
    final review = reviewData['review'] ?? '';
    final locationName = reviewData['locationName'] ?? '';
    final reviewImageUrls = List<String>.from(
      reviewData['reviewImageUrls'] ?? [],
    );
    final userId = reviewData['userId'] ?? '';
    final currentUser = FirebaseAuth.instance.currentUser;
    final isOwner = currentUser != null && currentUser.uid == userId;

    final createdAt = reviewData['createdAt'];
    final isEdited = reviewData['isEdited'] ?? false;
    final reviewDateText = formatReviewDate(createdAt, isEdited, l10n);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.flickReview),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'info') {
                showReviewInfo(context, reviewDateText);
              } else if (value == 'edit') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditReviewScreen(reviewData: reviewData),
                  ),
                );
              } else if (value == 'delete') {
                deleteReview(context);
              }
            },
            itemBuilder: (context) => [
              if (isOwner) PopupMenuItem(value: 'edit', child: Text(l10n.edit)),
              if (isOwner)
                PopupMenuItem(value: 'delete', child: Text(l10n.delete)),
              PopupMenuItem(value: 'info', child: Text(l10n.information)),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // USER
            Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundImage: profileImageUrl.isNotEmpty
                      ? NetworkImage(profileImageUrl)
                      : const AssetImage('images/placeholder_image.png')
                            as ImageProvider,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fullname,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('@$username'),
                      if (locationName.toString().isNotEmpty)
                        InkWell(
                          onTap: openMaps,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 14,
                                color: Colors.blue,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  locationName,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // RATING SECTION
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).dividerColor.withOpacity(0.5),
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Rating',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Colors.orange, size: 34),
                        const SizedBox(width: 8),
                        Text(
                          rating.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text('/5', style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 18),

            //IMAGES

            // REVIEW TEXT
            Text(
              l10n.reviews,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            if (reviewImageUrls.isNotEmpty) ...[
              const SizedBox(height: 12),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: reviewImageUrls.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final imageUrl = reviewImageUrls[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => GalleryPreviewScreen(
                            images: reviewImageUrls,
                            initialIndex: index,
                          ),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (_, __) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (_, __, ___) => Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.broken_image),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],

            Text(
              review,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 15, height: 1.6),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  String formatReviewDate(
    dynamic timestamp,
    bool isEdited,
    AppLocalizations l10n,
  ) {
    if (timestamp == null) return '';

    DateTime date;

    if (timestamp is Timestamp) {
      date = timestamp.toDate();
    } else {
      return '';
    }

    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    final formatted = '${date.day} ${months[date.month - 1]} ${date.year}';

    return isEdited ? '$formatted ${l10n.edited}' : formatted;
  }

  void showReviewInfo(BuildContext context, String reviewDateText) {
    final l10n = AppLocalizations.of(context)!;
    final fullname = reviewData['fullname'] ?? l10n.unknownUser;
    final username = reviewData['username'] ?? 'user';
    final locationName = reviewData['locationName'] ?? '';

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return Container(
          decoration: BoxDecoration(
            color: isDark
                ? const Color(0xFF1F1B2E)
                : Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 44,
                      height: 5,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.white24 : Colors.black26,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),

                  Text(
                    l10n.reviewInformation,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text('${l10n.reviewer}: $fullname'),
                  const SizedBox(height: 8),

                  Text('Username: @$username'),
                  const SizedBox(height: 8),

                  if (locationName.toString().isNotEmpty)
                    InkWell(
                      onTap: openMaps,
                      child: Row(
                        children: [
                          Text('${l10n.location}: '),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              locationName,
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 8),

                  if (reviewDateText.isNotEmpty)
                    Text('${l10n.date}: $reviewDateText'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> deleteReview(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final movieId = reviewData['movieId'];
    final reviewId = reviewData['reviewId'];

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteReview),
        content: Text(l10n.confirmDeleteReview),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    await FirebaseFirestore.instance
        .collection('movie_reviews')
        .doc(movieId)
        .collection('reviews')
        .doc(reviewId)
        .delete();

    if (context.mounted) {
      Navigator.pop(context);
    }
  }
}
