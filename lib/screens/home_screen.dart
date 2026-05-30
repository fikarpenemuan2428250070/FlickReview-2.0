import 'package:flutter/material.dart';

import 'package:flickreview/models/movies.dart';
import 'package:flickreview/screens/search_screen.dart';
import 'package:flickreview/screens/setting_screen.dart';
import 'package:flickreview/services/tmdb_service.dart';
import 'package:flickreview/utils/scale_fade_route.dart';
import 'package:flickreview/widgets/movie_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie> trendingMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> topRatedMovies = [];
  List<Movie> upcomingMovies = [];
  List<Movie> horrorMovies = [];
  List<Movie> comedyMovies = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    loadMovies();
  }

  Future<void> loadMovies() async {
    try {
      final trending =
          await TmdbService.fetchTrendingMovies();

      final popular =
          await TmdbService.fetchPopularMovies();

      final topRated =
          await TmdbService.fetchTopRatedMovies();

      final upcoming =
          await TmdbService.fetchUpcomingMovies();

      final horror =
          await TmdbService.fetchMoviesByGenre(27);

      final comedy =
          await TmdbService.fetchMoviesByGenre(35);

      setState(() {
        trendingMovies = trending;
        popularMovies = popular;
        topRatedMovies = topRated;
        upcomingMovies = upcoming;
        horrorMovies = horror;
        comedyMovies = comedy;

        isLoading = false;
      });
    } catch (e) {
      print(e);

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ================= DRAWER =================
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration:
                  BoxDecoration(color: Colors.deepPurple),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Setting'),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const SettingScreen(),
                  ),
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
                  applicationLegalese:
                      "© 2025 FlickReview App",
                );
              },
            ),
          ],
        ),
      ),

      // ================= APPBAR =================
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

        title: const Text('FlickReview'),

        centerTitle: true,

        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                ScaleFadeRoute(
                  page: SearchScreen(),
                ),
              );
            },
          ),
        ],
      ),

      // ================= BODY =================
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  MovieSection(
                    title: '🔥 Trending',
                    movies: trendingMovies,
                  ),

                  MovieSection(
                    title: '⭐ Popular',
                    movies: popularMovies,
                  ),

                  MovieSection(
                    title: '🏆 Top Rated',
                    movies: topRatedMovies,
                  ),

                  MovieSection(
                    title: '🎬 Upcoming',
                    movies: upcomingMovies,
                  ),

                  MovieSection(
                    title: '👻 Horror',
                    movies: horrorMovies,
                  ),

                  MovieSection(
                    title: '😂 Comedy',
                    movies: comedyMovies,
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }
}