class FiltroEvento {
  final String? uf;
  final int? mes;

  const FiltroEvento({this.uf, this.mes});

  FiltroEvento copyWith({String? uf, int? mes}) =>
      FiltroEvento(uf: uf ?? this.uf, mes: mes ?? this.mes);

  bool get isEmpty => uf == null && mes == null;
}
