import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/mock_fooderlich_service.dart';
import '../models/tab_manager.dart';

class EmptyGroceryScreen extends StatelessWidget {
  final exploreService = MockFooderlichService();

  EmptyGroceryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/cart_background.dart.jpg',
          ),
          const SizedBox(height: 20),
          Text(
            'No Groceries',
            style: Theme.of(context).textTheme.displaySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            'Shopping for ingredients?\nTap the + button to write them down!',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Provider.of<TabManager>(context, listen: false).goToTab(1);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            child: Text('Browse Recipes'),
          ),
        ],
      ),
    );
  }
}
