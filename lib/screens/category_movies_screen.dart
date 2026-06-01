import 'package:flutter/material.dart';

import '../models/movies.dart';
import '../widgets/item_card.dart';

class CategoryMoviesScreen extends StatelessWidget {
  final String title;
  final List<Movie> movies;

  const CategoryMoviesScreen({
    super.key,
    required this.title,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: movies.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 16,
          childAspectRatio: 0.62,
        ),
        itemBuilder: (context, index) {
          return ItemCard(movie: movies[index]);
        },
      ),
    );
  }
}
