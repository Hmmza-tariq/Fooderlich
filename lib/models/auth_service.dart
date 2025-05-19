import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'models.dart';

class AuthService {
  // For securely storing sensitive data
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  // For storing non-sensitive user data
  late SharedPreferences _prefs;

  // Storage keys
  static const String _userListKey = 'user_list';
  static const String _currentUserKey = 'current_user';
  static const String _currentUserIdKey = 'current_user_id';

  // Singleton pattern
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;

  AuthService._internal();

  // Initialize the service
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    // Initialize user list if it doesn't exist
    if (!_prefs.containsKey(_userListKey)) {
      await _prefs.setString(_userListKey, jsonEncode([]));
    }
  }

  // Hash password with SHA-256 + salt
  String _hashPassword(String password, String salt) {
    final bytes = utf8.encode(password + salt);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  // Generate a random salt for password hashing
  String _generateSalt() {
    return const Uuid().v4();
  }

  // Register a new user
  Future<bool> register(
      String firstName, String lastName, String email, String password) async {
    try {
      // Check if email is already registered
      final users = await _getUsers();
      final existingUser =
          users.where((user) => user['email'] == email).toList();

      if (existingUser.isNotEmpty) {
        return false; // Email already exists
      }

      // Generate salt and hash password
      final salt = _generateSalt();
      final hashedPassword = _hashPassword(password, salt);

      // Create new user
      final userId = const Uuid().v4();
      final newUser = {
        'id': userId,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'role': 'user',
        'profileImageUrl': 'assets/profile_pics/person_stef.jpeg',
        'points': 0,
        'darkMode': false,
      };

      // Store user credentials securely
      await _secureStorage.write(
          key: 'password_$userId', value: hashedPassword);
      await _secureStorage.write(key: 'salt_$userId', value: salt);

      // Add user to user list
      users.add(newUser);
      await _prefs.setString(_userListKey, jsonEncode(users));

      return true;
    } catch (e) {
      print('Registration error: $e');
      return false;
    }
  }

  // Login user
  Future<User?> login(String email, String password) async {
    try {
      // Get all users
      final users = await _getUsers();

      // Find the user with the given email
      final userList = users.where((user) => user['email'] == email).toList();

      if (userList.isEmpty) {
        return null; // User not found
      }

      final userData = userList.first;
      final userId = userData['id'];

      // Retrieve salt and stored password
      final salt = await _secureStorage.read(key: 'salt_$userId');
      final storedPassword = await _secureStorage.read(key: 'password_$userId');

      if (salt == null || storedPassword == null) {
        return null; // Missing authentication data
      }

      // Hash the provided password with the same salt
      final hashedPassword = _hashPassword(password, salt);

      // Check if passwords match
      if (hashedPassword == storedPassword) {
        // Store current user ID
        await _secureStorage.write(key: _currentUserIdKey, value: userId);
        await _prefs.setString(_currentUserKey, jsonEncode(userData));

        // Return the user object
        return User.fromJson(userData);
      } else {
        return null; // Password doesn't match
      }
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }

  // Get current logged-in user
  Future<User?> getCurrentUser() async {
    try {
      final userJson = _prefs.getString(_currentUserKey);
      if (userJson != null) {
        return User.fromJson(jsonDecode(userJson));
      }
      return null;
    } catch (e) {
      print('Get current user error: $e');
      return null;
    }
  }

  // Logout user
  Future<bool> logout() async {
    try {
      await _secureStorage.delete(key: _currentUserIdKey);
      await _prefs.remove(_currentUserKey);
      return true;
    } catch (e) {
      print('Logout error: $e');
      return false;
    }
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    try {
      final userId = await _secureStorage.read(key: _currentUserIdKey);
      return userId != null;
    } catch (e) {
      print('Is logged in check error: $e');
      return false;
    }
  }

  // Get all users (helper method)
  Future<List<Map<String, dynamic>>> _getUsers() async {
    final usersJson = _prefs.getString(_userListKey);
    if (usersJson != null) {
      final List<dynamic> decodedList = jsonDecode(usersJson);
      return decodedList.cast<Map<String, dynamic>>();
    }
    return [];
  }
}
