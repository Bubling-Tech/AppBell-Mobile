class Formatters {
  const Formatters._();

  static String monthFromDate(String date) {
    final months = <String>[
      'Janeiro',
      'Fevereiro',
      'Março',
      'Abril',
      'Maio',
      'Junho',
      'Julho',
      'Agosto',
      'Setembro',
      'Outubro',
      'Novembro',
      'Dezembro',
    ];

    final lower = date.toLowerCase();
    for (final month in months) {
      if (lower.contains(month.toLowerCase())) {
        return month;
      }
    }
    return date;
  }

  static String extractState(String cityState) {
    final parts = cityState.split(',');
    if (parts.length < 2) return cityState;
    var state = parts[1].trim();
    if (state.endsWith(' - Brasil')) {
      state = state.substring(0, state.length - ' - Brasil'.length);
    }
    return state;
  }
}
