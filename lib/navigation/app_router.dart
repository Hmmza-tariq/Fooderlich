import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/grocery_item_screen.dart';
import '../screens/login_screen.dart';
import '../models/models.dart';
import '../screens/onboarding_screen.dart';
import '../screens/home.dart';

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
      routes: [
        GoRoute(
            name: 'login',
            path: '/login',
            builder: (context, state) {
              return const LoginScreen();
            }),
        GoRoute(
            name: 'onboarding',
            path: '/onboarding',
            builder: (context, state) {
              return const OnboardingScreen();
            }),
        GoRoute(
            name: 'home',
            path: '/:tab',
            builder: (context, state) {
              final currentTab =
                  int.tryParse(state.pathParameters['tab'] ?? '') ?? 0;
              // const currentTab = 0;
              return Home(
                key: state.pageKey,
                currentTab: currentTab,
              );
            },
            routes: [
              GoRoute(
                name: 'item',
                path: 'item/:id',
                builder: (context, state) {
                  final itemId = state.pathParameters['id'];
                  final item = itemId == 'new'
                      ? null
                      : groceryManager.getGroceryItem(itemId!);
                  return GroceryItemScreen(
                    originalItem: item,
                    onCreate: (item) => groceryManager.addItem(item),
                    onUpdate: (item) => groceryManager.updateItem(item),
                  );
                },
              ),
            ]),
      ],
      errorPageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: Scaffold(
            backgroundColor: const Color(0xFFF9F9F9),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 72,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Oops! Something went wrong.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    state.error.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      redirect: (context, state) {
        final loggedIn = appStateManager.isLoggedIn;
        final isLoggingIn = state.matchedLocation == '/login';
        if (!loggedIn) return isLoggingIn ? null : '/login';
        // if (!loggedIn && !isLoggingIn) {
        //   return '/login';
        // }
        final isOnboardingComplete = appStateManager.isOnboardingComplete;
        final isOnboarding = state.matchedLocation == '/onboarding';
        if (!isOnboardingComplete) {
          return isOnboarding ? null : '/onboarding';
        }

        if (isLoggingIn || isOnboarding) {
          return '/${FooderlichTab.explore}';
        }
        return null;
      });
}
