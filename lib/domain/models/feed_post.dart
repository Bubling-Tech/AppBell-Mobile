class FeedPost {
  const FeedPost({
    required this.id,
    required this.userName,
    required this.eventName,
    required this.imageUrl,
    this.liked = false,
    this.avatarUrl,
  });

  final String id;
  final String userName;
  final String eventName;
  final String imageUrl;
  final bool liked;
  final String? avatarUrl;

  FeedPost copyWith({bool? liked}) {
    return FeedPost(
      id: id,
      userName: userName,
      eventName: eventName,
      imageUrl: imageUrl,
      liked: liked ?? this.liked,
      avatarUrl: avatarUrl,
    );
  }
}
