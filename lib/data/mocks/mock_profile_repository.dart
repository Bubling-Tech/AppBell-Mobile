import '../../domain/models/user_profile.dart';
import '../../domain/repositories/profile_repository.dart';
import 'mock_data.dart';

class MockProfileRepository implements ProfileRepository {
  const MockProfileRepository();

  @override
  Future<UserProfile> getProfile() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return MockData.profile;
  }
}
