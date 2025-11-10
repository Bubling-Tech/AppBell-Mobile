import '../../domain/models/user_profile.dart';

abstract class ProfileRepository {
  Future<UserProfile> getProfile();
}
