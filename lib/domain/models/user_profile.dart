class UserProfile {
  const UserProfile({
    required this.name,
    required this.bio,
    required this.cityState,
    required this.avatarUrl,
    required this.spotifySong,
    required this.stats,
    required this.posts,
    required this.bannerUrl,
  });

  final String name;
  final String bio;
  final String cityState;
  final String avatarUrl;
  final String spotifySong;
  final UserStats stats;
  final List<UserPost> posts;
  final String bannerUrl;
}

class UserStats {
  const UserStats({required this.rankPosition, required this.checkins});

  final String rankPosition;
  final String checkins;
}

class UserPost {
  const UserPost({required this.title, required this.city, required this.imageUrl});

  final String title;
  final String city;
  final String imageUrl;
}
