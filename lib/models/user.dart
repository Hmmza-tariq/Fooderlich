class User {
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final String profileImageUrl;
  final int points;
  final bool darkMode;
  final String? id;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.profileImageUrl,
    required this.points,
    required this.darkMode,
    this.id,
  });

  User copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? role,
    String? profileImageUrl,
    int? points,
    bool? darkMode,
    String? id,
  }) {
    return User(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      role: role ?? this.role,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      points: points ?? this.points,
      darkMode: darkMode ?? this.darkMode,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'role': role,
      'profileImageUrl': profileImageUrl,
      'points': points,
      'darkMode': darkMode,
      'id': id,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? 'user',
      profileImageUrl:
          json['profileImageUrl'] ?? 'assets/profile_pics/person_stef.jpeg',
      points: json['points'] ?? 0,
      darkMode: json['darkMode'] ?? false,
      id: json['id'],
    );
  }
}
