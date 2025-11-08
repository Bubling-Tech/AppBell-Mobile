import '../../domain/models/feed_post.dart';

abstract class FeedRepository {
  Stream<List<FeedPost>> getFeed();
}
