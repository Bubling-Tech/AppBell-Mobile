import '../../domain/models/ranking_entry.dart';
import '../../domain/repositories/ranking_repository.dart';
import 'mock_data.dart';

class MockRankingRepository implements RankingRepository {
  const MockRankingRepository();

  @override
  Future<List<RankingEntry>> getRanking() async {
    await Future.delayed(const Duration(milliseconds: 220));
    return List<RankingEntry>.from(MockData.ranking);
  }
}
