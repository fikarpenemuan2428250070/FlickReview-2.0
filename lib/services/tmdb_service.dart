import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/movies.dart';

class TmdbService {
  static const String apiKey = '89b16629199fc39f773ae11dfbc7d915';

  static const String baseUrl = 'https://api.themoviedb.org/3';

  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  // ================= POPULAR =================
  static Future<List<Movie>> fetchPopularMovies() async {
    return fetchMovies('/movie/popular');
  }

  // ================= TOP RATED =================
  static Future<List<Movie>> fetchTopRatedMovies() async {
    return fetchMovies('/movie/top_rated');
  }

  // ================= UPCOMING =================
  static Future<List<Movie>> fetchUpcomingMovies() async {
    return fetchMovies('/movie/upcoming');
  }

  // ================= TRENDING =================
  static Future<List<Movie>> fetchTrendingMovies() async {
    return fetchMovies('/trending/movie/day');
  }

  // ================= GENRE =================
  static Future<List<Movie>> fetchMoviesByGenre(int genreId) async {
    return fetchMovies('/discover/movie?with_genres=$genreId');
  }

  // ================= MAIN FETCH =================
  static Future<List<Movie>> fetchMovies(String endpoint) async {
    final fixedUrl = endpoint.contains('?')
        ? Uri.parse('$baseUrl$endpoint&api_key=$apiKey&language=en-US')
        : Uri.parse('$baseUrl$endpoint?api_key=$apiKey&language=en-US');

    final response = await http.get(fixedUrl);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final List results = data['results'];

      return results.map((json) {
        return Movie.fromTmdb(json);
      }).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  // ================= DETAIL MOVIE =================
  static Future<Movie> fetchMovieDetails(String movieId) async {
    // DETAIL
    final detailResponse = await http.get(
      Uri.parse('$baseUrl/movie/$movieId?api_key=$apiKey&language=en-US'),
    );

    // VIDEOS
    final videoResponse = await http.get(
      Uri.parse(
        '$baseUrl/movie/$movieId/videos?api_key=$apiKey&language=en-US',
      ),
    );

    // CREDITS
    final creditResponse = await http.get(
      Uri.parse(
        '$baseUrl/movie/$movieId/credits?api_key=$apiKey&language=en-US',
      ),
    );

    // IMAGES
    final imageResponse = await http.get(
      Uri.parse('$baseUrl/movie/$movieId/images?api_key=$apiKey'),
    );

    final detailData = json.decode(detailResponse.body);

    final videoData = json.decode(videoResponse.body);

    final creditData = json.decode(creditResponse.body);

    final imageData = json.decode(imageResponse.body);

    // ================= TRAILER =================
    String trailerId = '';

    if (videoData['results'].isNotEmpty) {
      for (var video in videoData['results']) {
        if (video['site'] == 'YouTube') {
          trailerId = video['key'];
          break;
        }
      }
    }

    // ================= DIRECTOR =================
    String director = 'Unknown';

    for (var crew in creditData['crew']) {
      if (crew['job'] == 'Director') {
        director = crew['name'];
        break;
      }
    }

    // ================= CAST =================
    List<String> cast = [];

    for (int i = 0; i < creditData['cast'].length && i < 10; i++) {
      cast.add(creditData['cast'][i]['name']);
    }

    // ================= GALLERY =================
    List<String> gallery = [];

    for (int i = 0; i < imageData['backdrops'].length && i < 10; i++) {
      gallery.add('$imageBaseUrl${imageData['backdrops'][i]['file_path']}');
    }

    return Movie(
      id: detailData['id'].toString(),

      title: detailData['title'] ?? '',

      year: detailData['release_date'] != null
          ? detailData['release_date'].toString().substring(0, 4)
          : '',

      synopsis: detailData['overview'] ?? '',

      genre: detailData['genres'].isNotEmpty
          ? detailData['genres'][0]['name']
          : 'Movie',

      director: director,

      duration: '${detailData['runtime'] ?? 0} min',

      type: 'Movie',

      posterUrl: detailData['poster_path'] != null
          ? '$imageBaseUrl${detailData['poster_path']}'
          : '',

      trailerId: trailerId,

      imageUrls: gallery,

      backdropUrl: detailData['backdrop_path'] != null
          ? '$imageBaseUrl${detailData['backdrop_path']}'
          : '',

      imdbRating: (detailData['vote_average'] ?? 0).toDouble(),

      rottenTomatoes: 0,

      flickReviewRating: ((detailData['vote_average'] ?? 0) / 2).toDouble(),

      cast: cast,

      reviews: [],

      releaseDate: detailData['release_date'] ?? '',

      language: detailData['original_language'] ?? '',

      isFavorite: false,
    );
  }
}
