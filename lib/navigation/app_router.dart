import 'package:go_router/go_router.dart';

import '../models/models.dart';

class AppRouter {
  final AppStateManager appStateManager;
  final GroceryManager groceryManager;
  final ProfileManager profileManager;

  AppRouter({
    required this.appStateManager,
    required this.groceryManager,
    required this.profileManager,
  });

  late final router = GoRouter(
      debugLogDiagnostics: true,
      refreshListenable: appStateManager,
      initialLocation: '/login',
      routes: []);
}
