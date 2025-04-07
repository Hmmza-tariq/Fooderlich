import 'package:go_router/go_router.dart';
import '../models/models.dart';
import '../screens/screens.dart';

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
          path: '/home',
          builder: (context, state) {
            final tab = state.uri.queryParameters['tab'] != null
                ? int.parse(state.uri.queryParameters['tab']!)
                : 0;
            return Home(
              key: state.pageKey,
              currentTab: tab,
            );
          },
        ),
      ],
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
          return '/{$FooderlichTab.explore}';
        }
        return null;
      });
}
