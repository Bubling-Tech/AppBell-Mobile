import '../../domain/repositories/events_repository.dart';
import '../../domain/repositories/feed_repository.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/repositories/ranking_repository.dart';
import '../../domain/services/camera_service.dart';
import '../../domain/services/location_service.dart';
import 'mock_camera_service.dart';
import 'mock_events_repository.dart';
import 'mock_feed_repository.dart';
import 'mock_location_service.dart';
import 'mock_profile_repository.dart';
import 'mock_ranking_repository.dart';

class SL {
  static final EventsRepository events = const MockEventsRepository();
  static final FeedRepository feed = const MockFeedRepository();
  static final RankingRepository ranking = const MockRankingRepository();
  static final ProfileRepository profile = const MockProfileRepository();
  static final LocationService location = MockLocationService(forceInsideRadius: true);
  static final CameraService camera = const MockCameraService();
}
