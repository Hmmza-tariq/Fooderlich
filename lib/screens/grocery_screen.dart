import 'package:flutter/material.dart';

import '../api/mock_fooderlich_service.dart';
import '../components/components.dart';

class GroceryScreen extends StatelessWidget {
  final exploreService = MockFooderlichService();

  GroceryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [EmptyGroceryScreen()],
      ),
    );
  }
}
