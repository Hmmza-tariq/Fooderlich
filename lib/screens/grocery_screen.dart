import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/mock_fooderlich_service.dart';
import '../components/components.dart';
import '../models/models.dart';

class GroceryScreen extends StatelessWidget {
  final exploreService = MockFooderlichService();

  GroceryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildGroceryScreen(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          buildGroceryScreen();
        },
      ),
    );
  }

  Widget buildGroceryScreen() {
    return Consumer<GroceryManager>(builder: (context, manager, child) {
      if (manager.groceryItems.isNotEmpty) {
        return ListView.builder(
          itemCount: manager.groceryItems.length,
          itemBuilder: (context, index) {
            return Container();
          },
        );
      } else {
        return EmptyGroceryScreen();
      }
    });
  }
}
