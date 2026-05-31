import 'package:cached_network_image/cached_network_image.dart';
import 'package:flickreview/models/movies.dart';
import 'package:flickreview/screens/detail_screnn.dart';
import 'package:flickreview/services/tmdb_service.dart';
import 'package:flickreview/utils/slide_route.dart';
import 'package:flutter/material.dart';
import 'package:flickreview/l10n/app_localizations.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<Movie> movies = [];

  bool isLoading = false;

  // ================= SEARCH =================
  Future<void> searchMovies(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        movies = [];
      });

      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final results = await TmdbService.fetchMovies(
        '/search/movie?query=$query',
      );

      setState(() {
        movies = results;
      });
    } catch (e) {
      print(e);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.searchMovies), centerTitle: true),

      body: Column(
        children: [
          // ================= SEARCH FIELD =================
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,

              onChanged: searchMovies,

              decoration: InputDecoration(
                hintText: l10n.searchMovieHint,

                prefixIcon: const Icon(Icons.search),

                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();

                          setState(() {
                            movies = [];
                          });
                        },
                        icon: const Icon(Icons.close),
                      )
                    : null,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),

          // ================= CONTENT =================
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : movies.isEmpty
                ? Center(
                    child: Text(
                      l10n.searchMovie,
                      style: const TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: movies.length,

                    itemBuilder: (context, index) {
                      final movie = movies[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            SlidePageRoute(page: DetailScreen(movie: movie)),
                          );
                        },

                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),

                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,

                            borderRadius: BorderRadius.circular(16),

                            boxShadow: const [
                              BoxShadow(color: Colors.black12, blurRadius: 4),
                            ],
                          ),

                          child: Row(
                            children: [
                              // ================= POSTER =================
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16),

                                  bottomLeft: Radius.circular(16),
                                ),

                                child: CachedNetworkImage(
                                  imageUrl: movie.posterUrl,

                                  width: 110,

                                  height: 160,

                                  fit: BoxFit.cover,

                                  placeholder: (context, url) => const SizedBox(
                                    width: 110,
                                    height: 160,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),

                                  errorWidget: (context, url, error) =>
                                      Container(
                                        width: 110,
                                        height: 160,
                                        color: Colors.grey,
                                        child: const Icon(Icons.broken_image),
                                      ),
                                ),
                              ),

                              // ================= INFO =================
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(14),

                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,

                                    children: [
                                      Text(
                                        movie.title,

                                        maxLines: 2,

                                        overflow: TextOverflow.ellipsis,

                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      const SizedBox(height: 10),

                                      Text(movie.year),

                                      const SizedBox(height: 6),

                                      Text(movie.genre),

                                      const SizedBox(height: 10),

                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 18,
                                          ),

                                          const SizedBox(width: 4),

                                          Text(
                                            movie.imdbRating.toStringAsFixed(1),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}