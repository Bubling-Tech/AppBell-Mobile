import 'package:flutter/material.dart';
import 'package:to_com_bell_app/features/eventos/presentation/pages/evento_detalhe_page.dart';
import 'package:to_com_bell_app/features/eventos/presentation/pages/eventos_page.dart';
import 'package:to_com_bell_app/features/feed/presentation/pages/feed_page.dart';
import 'package:to_com_bell_app/features/perfil/presentation/pages/perfil_page.dart';
import 'package:to_com_bell_app/features/ranking/presentation/pages/ranking_page.dart';

class AppRoutes {
  static const String feed = '/';
  static const String ranking = '/ranking';
  static const String eventos = '/eventos';
  static const String perfil = '/perfil';

  static String eventoDetalhe(String id) => '/eventos/$id';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final name = settings.name ?? feed;
    if (name == feed) {
      return MaterialPageRoute(builder: (_) => const FeedPage());
    }
    if (name == ranking) {
      return MaterialPageRoute(builder: (_) => const RankingPage());
    }
    if (name == eventos) {
      return MaterialPageRoute(builder: (_) => const EventosPage());
    }
    if (name == perfil) {
      return MaterialPageRoute(builder: (_) => const PerfilPage());
    }
    if (name.startsWith('/eventos/')) {
      final id = name.substring('/eventos/'.length);
      return MaterialPageRoute(
        builder: (_) => EventoDetalhePage(id: id),
        settings: settings,
      );
    }
    return MaterialPageRoute(builder: (_) => const FeedPage());
  }
}
