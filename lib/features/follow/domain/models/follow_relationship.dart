// lib/features/follow/domain/models/follow_relationship.dart

/// Simple immutable model describing follow relationship between
/// current user and another user.
class FollowRelationship {
  final bool isFollowing;
  final bool isFollowingMe;

  const FollowRelationship({
    required this.isFollowing,
    required this.isFollowingMe,
  });

  /// Return a new instance with updated fields.
  FollowRelationship copyWith({bool? isFollowing, bool? isFollowingMe}) {
    return FollowRelationship(
      isFollowing: isFollowing ?? this.isFollowing,
      isFollowingMe: isFollowingMe ?? this.isFollowingMe,
    );
  }

  /// Optional: helpful for debugging / logging
  @override
  String toString() =>
      'FollowRelationship(isFollowing: $isFollowing, isFollowingMe: $isFollowingMe)';

  /// Optional: JSON helpers if you need them for caching or tests
  Map<String, dynamic> toJson() => {
    'isFollowing': isFollowing,
    'isFollowingMe': isFollowingMe,
  };

  factory FollowRelationship.fromJson(Map<String, dynamic> json) =>
      FollowRelationship(
        isFollowing: json['isFollowing'] as bool? ?? false,
        isFollowingMe: json['isFollowingMe'] as bool? ?? false,
      );
}
