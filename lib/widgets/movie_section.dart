import 'package:flutter/material.dart';

import '../models/movies.dart';
import '../screens/category_movies_screen.dart';
import 'item_card.dart';

class MovieSection extends StatelessWidget {
  final String title;
  final List<Movie> movies;

  const MovieSection({super.key, required this.title, required this.movies});

  @override
  Widget build(BuildContext context) {
    final displayMovies = movies.length > 8 ? movies.take(8).toList() : movies;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TITLE
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              if (movies.length > 8)
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            CategoryMoviesScreen(title: title, movies: movies),
                      ),
                    );
                  },
                  child: const Text('See More'),
                ),
            ],
          ),
        ),

        // HORIZONTAL LIST
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: displayMovies.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 125,
                child: ItemCard(movie: displayMovies[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
