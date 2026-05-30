import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/external_rating.dart';
import '../models/movies.dart';
import '../services/reeldb_service.dart';
import '../services/tmdb_service.dart';
import 'gallery_preview_screen.dart';
import 'post_review_screen.dart';
import 'review_screen.dart';

class DetailScreen extends StatefulWidget {
  final Movie movie;

  const DetailScreen({super.key, required this.movie});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Movie? movieDetail;
  ExternalRating? externalRating;

  bool isLoading = true;
  bool isFavorite = false;
  bool isSignedIn = false;

  String favoritesKey = "";

  User? get currentUser => FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    loadMovieDetail();
    loadExternalRatings();
    _checkSignInStatus();
    _loadFavoriteStatus();
  }

  Future<void> loadMovieDetail() async {
    try {
      final detail = await TmdbService.fetchMovieDetails(widget.movie.id);

      setState(() {
        movieDetail = detail;
        isLoading = false;
      });
    } catch (e) {
      debugPrint(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> loadExternalRatings() async {
    final ratings = await ReelDbService.fetchRatings(widget.movie.title);

    setState(() {
      externalRating = ratings;
    });
  }

  Future<void> _checkSignInStatus() async {
    setState(() {
      isSignedIn = currentUser != null;
    });
  }

  Future<void> _loadFavoriteStatus() async {
    final user = currentUser;

    if (user == null) return;

    final prefs = await SharedPreferences.getInstance();

    favoritesKey = "favorites_${user.uid}";

    final favorites = prefs.getStringList(favoritesKey) ?? [];

    setState(() {
      isFavorite = favorites.contains(widget.movie.id);
    });
  }

  Future<void> _toggleFavorite() async {
    final user = currentUser;

    if (user == null) {
      Navigator.pushNamed(context, '/signin');
      return;
    }

    final prefs = await SharedPreferences.getInstance();

    favoritesKey = "favorites_${user.uid}";

    final favorites = prefs.getStringList(favoritesKey) ?? [];

    setState(() {
      isFavorite = !isFavorite;
    });

    if (isFavorite) {
      if (!favorites.contains(widget.movie.id)) {
        favorites.add(widget.movie.id);
      }
    } else {
      favorites.remove(widget.movie.id);
    }

    await prefs.setStringList(favoritesKey, favorites);
  }

  Future<void> openTrailer() async {
    if (movieDetail == null) return;

    if (movieDetail!.trailerId.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Trailer tidak tersedia")));
      return;
    }

    final url = 'https://www.youtube.com/watch?v=${movieDetail!.trailerId}';
    final uri = Uri.parse(url);

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  double calculateFlickReviewAverage(List<QueryDocumentSnapshot> docs) {
    if (docs.isEmpty) return 0;

    double total = 0;

    for (final doc in docs) {
      final data = doc.data() as Map<String, dynamic>;
      total += (data['rating'] ?? 0).toDouble();
    }

    return total / docs.length;
  }

  String shortReview(String text) {
    if (text.length <= 90) return text;
    return '${text.substring(0, 90)}...';
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (movieDetail == null) {
      return const Scaffold(body: Center(child: Text("Failed to load movie")));
    }

    final movie = movieDetail!;

    final reviewStream = FirebaseFirestore.instance
        .collection('movie_reviews')
        .doc(movie.id)
        .collection('reviews')
        .orderBy('createdAt', descending: true)
        .snapshots();

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: reviewStream,
        builder: (context, snapshot) {
          final reviewDocs = snapshot.data?.docs ?? [];
          final flickRating = calculateFlickReviewAverage(reviewDocs);

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: movie.backdropUrl ?? movie.posterUrl,
                      width: double.infinity,
                      height: 320,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      width: double.infinity,
                      height: 320,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.2),
                            Colors.black.withOpacity(0.95),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 45,
                      left: 16,
                      child: CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      right: 20,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl: movie.posterUrl,
                              width: 120,
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "${movie.year} • ${movie.genre}",
                                  style: const TextStyle(color: Colors.white70),
                                ),
                                const SizedBox(height: 14),
                                Row(
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: openTrailer,
                                      icon: const Icon(Icons.play_arrow),
                                      label: const Text("Trailer"),
                                    ),
                                    const SizedBox(width: 10),
                                    IconButton(
                                      onPressed: _toggleFavorite,
                                      icon: Icon(
                                        isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Rating",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ratingColumn(
                              "⭐ IMDb",
                              externalRating == null
                                  ? "..."
                                  : externalRating!.imdbRating.toStringAsFixed(
                                      1,
                                    ),
                            ),
                            ratingColumn(
                              "🍅 Critics",
                              externalRating == null
                                  ? "..."
                                  : "${externalRating!.rottenTomatoes}%",
                            ),
                            ratingColumn(
                              "🎬 FlickReview",
                              flickRating.toStringAsFixed(1),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      Wrap(
                        spacing: 20,
                        runSpacing: 12,
                        children: [
                          infoItem(Icons.timer, movie.duration),
                          infoItem(
                            Icons.language,
                            movie.language.toUpperCase(),
                          ),
                          infoItem(Icons.calendar_today, movie.releaseDate),
                        ],
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        "Director",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(movie.director),

                      const SizedBox(height: 30),

                      const Text(
                        "Cast",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: movie.cast.map((actor) {
                          return Chip(label: Text(actor));
                        }).toList(),
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        "Synopsis",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(movie.synopsis, style: const TextStyle(height: 1.6)),

                      const SizedBox(height: 30),

                      const Text(
                        "Gallery",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: movie.imageUrls.length,
                          itemBuilder: (context, index) {
                            final image = movie.imageUrls[index];

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => GalleryPreviewScreen(
                                      images: movie.imageUrls,
                                      initialIndex: index,
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CachedNetworkImage(
                                    imageUrl: image,
                                    width: 180,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 30),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Reviews",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PostReviewScreen(
                                    movieId: movie.id,
                                    movieTitle: movie.title,
                                    movieYear: movie.year,
                                    movieGenre: movie.genre,
                                    movieDirector: movie.director,
                                    posterUrl: movie.posterUrl,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.add),
                            label: const Text("Add Review"),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      reviewDocs.isEmpty
                          ? const Text('Belum ada review untuk film ini.')
                          : SizedBox(
                              height: 180,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: reviewDocs.length,
                                itemBuilder: (context, index) {
                                  final data =
                                      reviewDocs[index].data()
                                          as Map<String, dynamic>;

                                  data['reviewId'] = reviewDocs[index].id;

                                  final fullname =
                                      data['fullname'] ?? 'Unknown User';

                                  final username = data['username'] ?? 'user';

                                  final profileImageUrl =
                                      data['profileImageUrl'] ?? '';

                                  final rating = (data['rating'] ?? 0)
                                      .toDouble();

                                  final review = data['review'] ?? '';

                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              ReviewScreen(reviewData: data),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 280,
                                      margin: const EdgeInsets.only(right: 14),
                                      padding: const EdgeInsets.all(14),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 24,
                                                backgroundImage:
                                                    profileImageUrl.isNotEmpty
                                                    ? NetworkImage(
                                                        profileImageUrl,
                                                      )
                                                    : const AssetImage(
                                                            'images/placeholder_image.png',
                                                          )
                                                          as ImageProvider,
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      fullname,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 2),
                                                    Text(
                                                      '@$username',
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.star,
                                                          color: Colors.orange,
                                                          size: 18,
                                                        ),
                                                        const SizedBox(
                                                          width: 4,
                                                        ),
                                                        Text(
                                                          rating
                                                              .toStringAsFixed(
                                                                1,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 14),
                                          Text(
                                            shortReview(review),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(height: 1.5),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget infoItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [Icon(icon, size: 18), const SizedBox(width: 6), Text(text)],
    );
  }
}

Widget ratingColumn(String title, String value) {
  return Column(
    children: [
      Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      Text(
        value,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ],
  );
}
