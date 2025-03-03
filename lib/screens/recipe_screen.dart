import 'package:flutter/material.dart';

import '../models/models.dart';
import '../components/components.dart';
import '../api/mock_fooderlich_service.dart';

class RecipeScreen extends StatelessWidget {
  final exploreService = MockFooderlichService();

  RecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: exploreService.getRecipes(),
        builder: (context, AsyncSnapshot<List<SimpleRecipe>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: RecipeGridView(recipes: snapshot.data ?? []),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
