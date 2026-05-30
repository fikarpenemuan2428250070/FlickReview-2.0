import 'package:firebase_auth/firebase_auth.dart';
import 'package:flickreview/models/movies.dart';
import 'package:flickreview/screens/detail_screnn.dart';
import 'package:flickreview/screens/search_screen.dart';
import 'package:flickreview/screens/setting_screen.dart';
import 'package:flickreview/services/tmdb_service.dart';
import 'package:flickreview/utils/slide_route.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'sign_in_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Movie> favoriteMovies = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const SignInScreen()),
        );
      });
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = prefs.getStringList('favorites_${user.uid}') ?? [];

    List<Movie> loadedMovies = [];

    for (final id in favoriteIds) {
      try {
        final movie = await TmdbService.fetchMovieDetails(id);
        loadedMovies.add(movie);
      } catch (e) {
        debugPrint('Failed to load favorite movie: $e');
      }
    }

    setState(() {
      favoriteMovies = loadedMovies;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Setting'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                showAboutDialog(
                  context: context,
                  applicationName: "FlickReview",
                  applicationVersion: "1.0.0",
                  applicationLegalese: "© 2025 FlickReview App",
                );
              },
            ),
          ],
        ),
      ),

      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: const Text('Favorite Movies'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchScreen()),
              );
            },
          ),
        ],
      ),

      body: favoriteMovies.isEmpty
          ? const Center(
              child: Text(
                'There is no favorite movie yet.',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: favoriteMovies.length,
              itemBuilder: (context, index) {
                final movie = favoriteMovies[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      SlidePageRoute(page: DetailScreen(movie: movie)),
                    ).then((_) {
                      loadFavorites();
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            movie.posterUrl,
                            width: 90,
                            height: 135,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 90,
                              height: 135,
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
                                movie.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${movie.type} • ${movie.year}",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                movie.genre,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
