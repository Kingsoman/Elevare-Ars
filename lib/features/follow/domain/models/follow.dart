class Follow {
  /// Unique ID of this follow relationship
  final String id;

  /// ID of the user who is following (the follower)
  final String followerId;

  /// ID of the user being followed
  final String followingId;

  /// When this follow relationship was created
  final DateTime createdAt;

  Follow({
    required this.id,
    required this.followerId,
    required this.followingId,
    required this.createdAt,
  });

  /// Create a Follow object from database JSON
  factory Follow.fromJson(Map<String, dynamic> json) {
    return Follow(
      id: json['id'],
      followerId: json['follower_id'],
      followingId: json['following_id'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  /// Convert to JSON for database storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'follower_id': followerId,
      'following_id': followingId,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
