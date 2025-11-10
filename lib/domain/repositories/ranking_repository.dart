import '../../domain/models/ranking_entry.dart';

abstract class RankingRepository {
  Future<List<RankingEntry>> getRanking();
}
