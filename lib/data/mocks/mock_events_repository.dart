import 'dart:async';

import '../../core/utils/formatters.dart';
import '../../domain/models/event.dart';
import '../../domain/repositories/events_repository.dart';
import 'mock_data.dart';

class MockEventsRepository implements EventsRepository {
  const MockEventsRepository();

  @override
  Future<List<Event>> getAll() async {
    await Future.delayed(const Duration(milliseconds: 240));
    return List<Event>.from(MockData.allEvents);
  }

  @override
  Future<List<Event>> getFeatured() async {
    await Future.delayed(const Duration(milliseconds: 180));
    return List<Event>.from(MockData.featuredEvents);
  }

  @override
  Future<List<Event>> filter({String? state, String? month}) async {
    final all = await getAll();
    return all.where((event) {
      final stateOk = state == null || Formatters.extractState(event.cityState) == state;
      final monthOk = month == null || Formatters.monthFromDate(event.dateLong) == month;
      return stateOk && monthOk;
    }).toList();
  }
}
