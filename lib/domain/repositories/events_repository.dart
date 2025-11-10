import '../../domain/models/event.dart';

abstract class EventsRepository {
  Future<List<Event>> getFeatured();
  Future<List<Event>> getAll();
  Future<List<Event>> filter({String? state, String? month});
}
