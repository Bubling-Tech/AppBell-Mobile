import 'package:flutter/material.dart';

import '../domain/models/event.dart';
import '../features/camera/camera_page.dart';
import '../features/event_details/event_details_page.dart';
import '../features/shell/app_shell.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const AppShell(), settings: settings);
    case '/camera':
      return MaterialPageRoute(builder: (_) => const CameraPage(), settings: settings);
    case '/event':
      final args = settings.arguments;
      if (args is Event) {
        return MaterialPageRoute(
          builder: (_) => EventDetailsPage(event: args),
          settings: settings,
        );
      }
      return _errorRoute('Evento não informado.');
    default:
      return _errorRoute('Rota desconhecida: ${settings.name}');
  }
}

Route<dynamic> _errorRoute(String message) {
  return MaterialPageRoute(
    builder: (_) => Scaffold(
      body: Center(child: Text(message)),
    ),
  );
}

Future<void> goToEvent(BuildContext context, Event event) {
  return Navigator.of(context).pushNamed('/event', arguments: event);
}

void goHome(BuildContext context) {
  Navigator.of(context).popUntil((route) => route.settings.name == '/' || route.isFirst);
  appShellController.select(0);
}
