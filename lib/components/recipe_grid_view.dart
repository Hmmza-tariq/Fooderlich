import 'package:flutter/material.dart';

import '../models/models.dart';
import 'components.dart';

class RecipeGridView extends StatelessWidget {
  const RecipeGridView({super.key, required this.recipes});
  final List<SimpleRecipe> recipes;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return RecipeThumbnail(recipe: recipes[index]);
        },
      ),
    );
  }
}
