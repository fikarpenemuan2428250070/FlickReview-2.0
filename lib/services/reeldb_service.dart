import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/external_rating.dart';

class ReelDbService {
  // GANTI DENGAN API KEY OMDB KAMU
  static const String apiKey =
      'c9e1cd99';

  static const String baseUrl =
      'https://www.omdbapi.com/';

  static Future<ExternalRating>
      fetchRatings(String movieTitle) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl?t=$movieTitle&apikey=$apiKey',
        ),
      );

      print(response.body);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // IMDb
        double imdb = double.tryParse(
              data['imdbRating'] ?? '0',
            ) ??
            0;

        // Rotten Tomatoes
        int rotten = 0;

        if (data['Ratings'] != null) {
          for (var rating
              in data['Ratings']) {
            if (rating['Source'] ==
                'Rotten Tomatoes') {
              rotten = int.parse(
                rating['Value']
                    .replaceAll('%', ''),
              );
            }
          }
        }

        return ExternalRating(
          imdbRating: imdb,
          rottenTomatoes: rotten,
        );
      } else {
        return ExternalRating(
          imdbRating: 0,
          rottenTomatoes: 0,
        );
      }
    } catch (e) {
      print(e);

      return ExternalRating(
        imdbRating: 0,
        rottenTomatoes: 0,
      );
    }
  }
}