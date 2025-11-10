class Event {
  const Event({
    required this.id,
    required this.title,
    required this.place,
    required this.cityState,
    required this.dateShort,
    required this.dateLong,
    required this.imageUrl,
    required this.lat,
    required this.lon,
    this.checkins = 0,
    this.publications = 0,
    this.stage = 'Palco',
    this.description = '',
  });

  final String id;
  final String title;
  final String place;
  final String cityState;
  final String dateShort;
  final String dateLong;
  final String imageUrl;
  final double lat;
  final double lon;
  final int checkins;
  final int publications;
  final String stage;
  final String description;
}
