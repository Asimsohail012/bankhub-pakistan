class UserModel {
  final String uid;
  final String email;
  final String? displayName;
  final String? phoneNumber;
  final String? photoUrl;
  final List<String> favorites;
  final List<String> recentlyViewed;
  final DateTime createdAt;
  final DateTime? lastSignIn;

  const UserModel({
    required this.uid,
    required this.email,
    this.displayName,
    this.phoneNumber,
    this.photoUrl,
    this.favorites = const [],
    this.recentlyViewed = const [],
    required this.createdAt,
    this.lastSignIn,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      photoUrl: json['photoUrl'] as String?,
      favorites: List<String>.from((json['favorites'] as List?) ?? []),
      recentlyViewed: List<String>.from((json['recentlyViewed'] as List?) ?? []),
      createdAt: DateTime.parse(json['createdAt'] as String? ?? DateTime.now().toIso8601String()),
      lastSignIn: json['lastSignIn'] != null ? DateTime.parse(json['lastSignIn'] as String) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
      'favorites': favorites,
      'recentlyViewed': recentlyViewed,
      'createdAt': createdAt.toIso8601String(),
      'lastSignIn': lastSignIn?.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? phoneNumber,
    String? photoUrl,
    List<String>? favorites,
    List<String>? recentlyViewed,
    DateTime? createdAt,
    DateTime? lastSignIn,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoUrl: photoUrl ?? this.photoUrl,
      favorites: favorites ?? this.favorites,
      recentlyViewed: recentlyViewed ?? this.recentlyViewed,
      createdAt: createdAt ?? this.createdAt,
      lastSignIn: lastSignIn ?? this.lastSignIn,
    );
  }
}
