import 'package:flutter/material.dart';

import '../../core/palette.dart';
import '../../core/utils/formatters.dart';
import '../../data/mocks/service_locator.dart';
import '../../domain/models/event.dart';
import '../../shared_widgets/section_header.dart';
import '../../routes/app_router.dart';
import 'widgets/event_pill.dart';
import 'widgets/featured_card.dart';
import 'widgets/filter_bottom_sheet.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage>
    with AutomaticKeepAliveClientMixin<EventsPage> {
  List<Event> _featured = const [];
  List<Event> _all = const [];
  List<Event> _filtered = const [];
  bool _loading = true;
  String? _selectedState;
  String? _selectedMonth;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final featured = await SL.events.getFeatured();
    final all = await SL.events.getAll();
    setState(() {
      _featured = featured;
      _all = all;
      _filtered = all;
      _loading = false;
    });
  }

  Future<void> _applyFilters({String? state, String? month}) async {
    setState(() {
      _loading = true;
      _selectedState = state;
      _selectedMonth = month;
    });
    final filtered = await SL.events.filter(state: state, month: month);
    if (mounted) {
      setState(() {
        _filtered = filtered;
        _loading = false;
      });
    }
  }

  List<String> get _states {
    final values = {
      for (final event in _all) Formatters.extractState(event.cityState)
    }..removeWhere((element) => element.isEmpty);
    final list = values.toList()..sort();
    return list;
  }

  List<String> get _months {
    final values = {
      for (final event in _all) Formatters.monthFromDate(event.dateLong)
    }..removeWhere((element) => element.isEmpty);
    final list = values.toList()..sort((a, b) => a.compareTo(b));
    return list;
  }

  void _openFilters() async {
    final result = await showFilterBottomSheet(
      context: context,
      states: _states,
      months: _months,
      selectedState: _selectedState,
      selectedMonth: _selectedMonth,
    );
    if (result != null) {
      if (result.state == null && result.month == null) {
        await _applyFilters(state: null, month: null);
      } else {
        await _applyFilters(state: result.state, month: result.month);
      }
    }
  }

  void _openDetails(Event event) {
    goToEvent(context, event);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Palette.backgroundLight,
      body: SafeArea(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                      child: Row(
                        children: [
                          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SectionHeader(
                      title: 'Próximos shows',
                      actionText: 'Veja mais',
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 210,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        scrollDirection: Axis.horizontal,
                        itemCount: _featured.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (_, index) {
                          final event = _featured[index];
                          return FeaturedCard(
                            event: event,
                            heroTag: event.imageUrl,
                            onTap: () => _openDetails(event),
                          );
                        },
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 18, 16, 8),
                      child: Row(
                        children: [
                          const Text(
                            'Todos os eventos',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: _openFilters,
                            icon: const Icon(Icons.filter_list_rounded),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    sliver: SliverList.separated(
                      itemCount: _filtered.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (_, index) {
                        final event = _filtered[index];
                        return EventPill(
                          event: event,
                          heroTag: event.imageUrl,
                          onTap: () => _openDetails(event),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
