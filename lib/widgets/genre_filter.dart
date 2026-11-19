import 'package:flutter/material.dart';
import '../models/models_genre.dart';

class GenreFilter extends StatelessWidget {
  final Genre? selectedGenre;
  final ValueChanged<Genre?> onSelected;

  const GenreFilter({
    super.key,
    required this.selectedGenre,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        children: [
          ChoiceChip(
            label: const Text('Բոլորը'),
            selected: selectedGenre == null,
            onSelected: (value) {
              onSelected(null);
            },
          ),

          const SizedBox(width: 8),

          ...Genre.values.map((genre) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(genre.label),
                selected: selectedGenre == genre,
                onSelected: (value) {
                  onSelected(genre);
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
