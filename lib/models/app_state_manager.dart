import 'dart:async';
import 'package:flutter/material.dart';
import 'models.dart';
import 'auth_service.dart';

class FooderlichTab {
  static const int explore = 0;
  static const int recipes = 1;
  static const int toBuy = 2;
}

// AppStateManager mocks the various app state such as app initialization,
// app login, and onboarding.
class AppStateManager extends ChangeNotifier {
  // Authentication state
  bool _loggedIn = false;
  bool _onboardingComplete = false;
  int _selectedTab = FooderlichTab.explore;
  User? _currentUser;

  // Services
  final _appCache = AppCache();
  final _authService = AuthService();

  // Property getters
  bool get isLoggedIn => _loggedIn;
  bool get isOnboardingComplete => _onboardingComplete;
  int get getSelectedTab => _selectedTab;
  User? get currentUser => _currentUser;
  // Initializes the app
  Future<void> initializeApp() async {
    // Initialize auth service
    await _authService.init();

    // Check if the user is logged in
    _loggedIn = await _authService.isLoggedIn();
    if (_loggedIn) {
      _currentUser = await _authService.getCurrentUser();
    }

    // Check if the user completed onboarding
    _onboardingComplete = await _appCache.didCompleteOnboarding();
  }

  // Login with email and password
  Future<bool> login(String email, String password) async {
    final user = await _authService.login(email, password);
    if (user != null) {
      _currentUser = user;
      _loggedIn = true;
      await _appCache.cacheUser();
      notifyListeners();
      return true;
    }
    return false;
  }

  // Register a new user
  Future<bool> register(
      String firstName, String lastName, String email, String password) async {
    final success =
        await _authService.register(firstName, lastName, email, password);
    if (success) {
      // Auto-login after successful registration
      return login(email, password);
    }
    return false;
  }

  void onboarded() async {
    _onboardingComplete = true;
    await _appCache.completeOnboarding();
    notifyListeners();
  }

  void goToTab(index) {
    _selectedTab = index;
    notifyListeners();
  }

  void goToRecipes() {
    _selectedTab = FooderlichTab.recipes;
    notifyListeners();
  }

  Future<bool> logout() async {
    final success = await _authService.logout();
    if (success) {
      // Reset all properties once user logs out
      _loggedIn = false;
      _currentUser = null;
      _selectedTab = FooderlichTab.explore;

      // Clear app cache but retain onboarding status
      await _appCache.invalidate();
      notifyListeners();
      return true;
    }
    return false;
  }
}
