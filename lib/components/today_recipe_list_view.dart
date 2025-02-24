import 'package:flutter/material.dart';

import '../models/models.dart';
import 'components.dart';

class TodayRecipeListView extends StatelessWidget {
  const TodayRecipeListView({super.key, required this.recipes});
  final List<ExploreRecipe> recipes;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450.0,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16.0,
          bottom: 12.0,
          left: 16.0,
        ),
        child: ListView(
          children: [
            Container(
              height: 400.0,
              color: Colors.transparent,
              child: ListView.separated(
                primary: true,
                scrollDirection: Axis.horizontal,
                itemCount: recipes.length,
                separatorBuilder: (context, index) {
                  return SizedBox(width: 16.0);
                },
                itemBuilder: (context, index) {
                  final recipe = recipes[index];
                  return Card1(recipe: recipe);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(ExploreRecipe recipe) {
    if (recipe.cardType == RecipeCardType.card1) {
      return Card1(recipe: recipe);
    } else if (recipe.cardType == RecipeCardType.card2) {
      return Card2(recipe: recipe);
    } else if (recipe.cardType == RecipeCardType.card3) {
      return Card3(recipe: recipe);
    } else {
      SnackBar(content: Text('Unknown Card Type'));
      return SizedBox();
    }
  }
}
