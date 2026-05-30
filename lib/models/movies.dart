import 'package:flickreview/models/review.dart';

class Movie {
  final String id;
  final String title;
  final String year;
  final String synopsis;
  final String genre;
  final String director;
  final String duration;
  final String type;
  final String posterUrl;
  final String trailerId;
  final List<String> imageUrls;

  String? backdropUrl;

  final double imdbRating;
  final int rottenTomatoes;
  final double flickReviewRating;

  final List<String> cast;
  final List<Review> reviews;
  final String releaseDate;
  final String language;

  bool isFavorite;

  Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.synopsis,
    required this.genre,
    required this.director,
    required this.duration,
    required this.type,
    required this.posterUrl,
    required this.trailerId,
    required this.imageUrls,
    this.backdropUrl,
    required this.imdbRating,
    required this.rottenTomatoes,
    required this.flickReviewRating,
    required this.cast,
    required this.reviews,
    required this.releaseDate,
    required this.language,
    this.isFavorite = false,
  });

  factory Movie.fromTmdb(Map<String, dynamic> json) {
    return Movie(
      id: json['id'].toString(),

      title: json['title'] ?? '',

      year: json['release_date'] != null
          ? json['release_date'].toString().substring(0, 4)
          : '',

      synopsis: json['overview'] ?? '',

      genre: 'Movie',

      director: 'Unknown',

      duration: 'Unknown',

      type: 'Movie',

      posterUrl: 'https://image.tmdb.org/t/p/w500${json['poster_path']}',

      trailerId: '',

      imageUrls: [],

      backdropUrl: 'https://image.tmdb.org/t/p/w500${json['backdrop_path']}',

      imdbRating: (json['vote_average'] ?? 0).toDouble(),

      rottenTomatoes: 0,

      flickReviewRating: (json['vote_average'] ?? 0).toDouble(),

      cast: [],

      reviews: [],

      releaseDate: json['release_date'] ?? '',

      language: json['original_language'] ?? '',

      isFavorite: false,
    );
  }
}
