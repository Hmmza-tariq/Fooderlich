import 'package:flutter/material.dart';

import '../api/mock_fooderlich_service.dart';
import '../components/components.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({super.key});
  final mockService = MockFooderlichService();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: mockService.getExploreData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final recipes = snapshot.data!.todayRecipes;

          return ListView(
            scrollDirection: Axis.vertical,
            children: List.generate(recipes.length, (index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card1(
                  recipe: recipes[index],
                ),
              );
            }),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
