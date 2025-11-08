import 'package:flutter/foundation.dart';
import 'package:to_com_bell_app/core/mock/mock_data.dart';
import 'package:to_com_bell_app/core/utils/result.dart';
import 'package:to_com_bell_app/features/ranking/models/ranking_entry.dart';

class RankingController extends ChangeNotifier {
  Result<List<RankingEntry>> ranking = Result.idle(data: const []);

  Future<void> carregarRanking() async {
    ranking = Result.loading();
    notifyListeners();
    try {
      final dados = await _rankingGeral();
      if (dados.isEmpty) {
        ranking = Result.empty(message: 'Nenhum participante encontrado.');
      } else {
        ranking = Result.success(dados);
      }
    } catch (error) {
      ranking = Result.error('Não foi possível carregar o ranking.');
    }
    notifyListeners();
  }

  Future<List<RankingEntry>> _rankingGeral() async {
    await Future.delayed(const Duration(milliseconds: 220));
    return List<RankingEntry>.generate(
      mockRanking.length,
      (index) => mockRanking[index].copyWith(posicao: index + 1),
    );
  }
}
