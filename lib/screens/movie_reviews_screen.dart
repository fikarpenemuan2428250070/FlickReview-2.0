import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flickreview/l10n/app_localizations.dart';

import 'review_screen.dart';

class MovieReviewsScreen extends StatelessWidget {
  final String movieId;
  final String movieTitle;
  final String movieYear;

  const MovieReviewsScreen({
    super.key,
    required this.movieId,
    required this.movieTitle,
    required this.movieYear,
  });

  String shortReview(String text) {
    if (text.length <= 130) return text;
    return '${text.substring(0, 130)}...';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final reviewStream = FirebaseFirestore.instance
        .collection('movie_reviews')
        .doc(movieId)
        .collection('reviews')
        .orderBy('createdAt', descending: true)
        .snapshots();

    return Scaffold(
      appBar: AppBar(title: Text('$movieTitle ($movieYear)')),
      body: StreamBuilder<QuerySnapshot>(
        stream: reviewStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final reviewDocs = snapshot.data?.docs ?? [];

          if (reviewDocs.isEmpty) {
            return Center(child: Text(l10n.noReviewsYet));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: reviewDocs.length,
            itemBuilder: (context, index) {
              final data = reviewDocs[index].data() as Map<String, dynamic>;

              data['reviewId'] = reviewDocs[index].id;

              final fullname = data['fullname'] ?? l10n.unknownUser;
              final username = data['username'] ?? 'user';
              final profileImageUrl = data['profileImageUrl'] ?? '';
              final rating = (data['rating'] ?? 0).toDouble();
              final review = data['review'] ?? '';

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ReviewScreen(reviewData: data),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 4),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 26,
                        backgroundImage: profileImageUrl.isNotEmpty
                            ? NetworkImage(profileImageUrl)
                            : const AssetImage('images/placeholder_image.png')
                                  as ImageProvider,
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fullname,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '@$username',
                              style: const TextStyle(fontSize: 12),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                  size: 18,
                                ),
                                const SizedBox(width: 4),
                                Text('${rating.toStringAsFixed(1)}/5'),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              shortReview(review),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(height: 1.5),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
