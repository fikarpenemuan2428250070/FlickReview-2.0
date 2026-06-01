import 'package:flutter/material.dart';

import 'package:flickreview/models/movies.dart';
import 'package:flickreview/screens/search_screen.dart';
import 'package:flickreview/screens/setting_screen.dart';
import 'package:flickreview/services/tmdb_service.dart';
import 'package:flickreview/utils/scale_fade_route.dart';
import 'package:flickreview/widgets/movie_section.dart';
import 'package:flickreview/l10n/app_localizations.dart';

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
      final trending = await TmdbService.fetchTrendingMovies();

      final popular = await TmdbService.fetchPopularMovies();

      final topRated = await TmdbService.fetchTopRatedMovies();

      final upcoming = await TmdbService.fetchUpcomingMovies();

      final horror = await TmdbService.fetchMoviesByGenre(27);

      final comedy = await TmdbService.fetchMoviesByGenre(35);

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
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.deepPurple),
              child: Text(
                AppLocalizations.of(context)!.menu,
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.settings),

              title: Text(AppLocalizations.of(context)!.settings),

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

              title: Text(AppLocalizations.of(context)!.about),

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

        title: Text(AppLocalizations.of(context)!.flickReview),

        centerTitle: true,

        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(context, ScaleFadeRoute(page: SearchScreen()));
            },
          ),
        ],
      ),

      // ================= BODY =================
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MovieSection(
                    title: ' ${AppLocalizations.of(context)!.trending}',
                    movies: trendingMovies,
                  ),

                  MovieSection(
                    title: ' ${AppLocalizations.of(context)!.popular}',
                    movies: popularMovies,
                  ),

                  MovieSection(
                    title: ' ${AppLocalizations.of(context)!.topRated}',
                    movies: topRatedMovies,
                  ),

                  MovieSection(
                    title: ' ${AppLocalizations.of(context)!.upcoming}',
                    movies: upcomingMovies,
                  ),

                  MovieSection(
                    title: ' ${AppLocalizations.of(context)!.horror}',
                    movies: horrorMovies,
                  ),

                  MovieSection(
                    title: ' ${AppLocalizations.of(context)!.comedy}',
                    movies: comedyMovies,
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }
}
