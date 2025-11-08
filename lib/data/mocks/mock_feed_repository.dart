import '../../domain/models/feed_post.dart';
import '../../domain/repositories/feed_repository.dart';
import 'mock_data.dart';

class MockFeedRepository implements FeedRepository {
  const MockFeedRepository();

  @override
  Stream<List<FeedPost>> getFeed() async* {
    await Future.delayed(const Duration(milliseconds: 200));
    yield List<FeedPost>.from(MockData.feedPosts);
  }
}
