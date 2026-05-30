import 'package:flutter/material.dart';

import '../models/movies.dart';
import 'item_card.dart';

class MovieSection extends StatelessWidget {
  final String title;
  final List<Movie> movies;

  const MovieSection({super.key, required this.title, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TITLE
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),

        // HORIZONTAL LIST
        SizedBox(
          height: 320,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 140,
                child: ItemCard(movie: movies[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
