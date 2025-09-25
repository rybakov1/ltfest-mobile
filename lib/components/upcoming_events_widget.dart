import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../constants.dart';
import '../data/models/upcoming_events.dart';
import '../pages/home/more_items_page.dart';
import '../providers/favorites_provider.dart';
import '../providers/upcoming_provider.dart';
import 'custom_chip.dart';
import 'favorite_button.dart';

class UpcomingEventsWidget extends ConsumerWidget {
  const UpcomingEventsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final upcomingEvents = ref.watch(upcomingEventsProvider);

    return Column(
      children: [
        _buildSectionHeader('Ближайшие мероприятия', context, ref),
        const SizedBox(height: 16),
        SizedBox(
          height: 260,
          child: upcomingEvents.when(
            data: (events) => ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: events.length > 4 ? 4 : events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: GestureDetector(
                    onTap: () {
                      if (event.type == EventType.festival) {
                        context.push('/fest/${event.id}');
                      } else {
                        context.push('/lab/${event.id}');
                      }
                    },
                    child: _buildEventCard(
                        event: event, imageUrl: event.image!, ref: ref),
                  ),
                );
              },
            ),
            loading: () => _buildEventsLoading(), // Shimmer
            error: (error, stack) => Center(
              child: Text('Ошибка: $error'),
            ),
          ),
        ),
      ],
    ); // --- Ближайшие мероприятия ---
  }

  Widget _buildSectionHeader(
      String title, BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Styles.h3),
        GestureDetector(
          onTap: () {
            if (title == 'Ближайшие мероприятия') {
              context.pushNamed('all-items', extra: {
                'title': 'Ближайшие мероприятия',
                'itemsAsync': ref.watch(upcomingEventsProvider),
                'itemBuilder': (UpcomingEvent event) =>
                    buildEventCard(event: event, context: context)
              });
            }
          },
          child: Text(
            'Все',
            style: Styles.button2.copyWith(color: Palette.secondary),
          ),
        ),
      ],
    );
  }

  Widget _buildEventCard({
    required UpcomingEvent event,
    required String imageUrl,
    required WidgetRef ref, // Требуется для доступа к провайдерам
  }) {
    final location =
        event.address != null && event.address!.toLowerCase().contains('онлайн')
            ? event.address!
            : event.address ?? 'Онлайн';

    return SizedBox(
      width: 270,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: imageUrl.isNotEmpty
                    ? Image.network(
                        "http://37.46.132.144:1337$imageUrl",
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                          'assets/images/ex.png',
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Image.asset(
                        'assets/images/ex.png',
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomChipWithName(
                      selectedDirection: event.direction.title,
                    ),
                    FavoriteButton(id: event.id, eventType: event.type)
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            event.title,
            style: Styles.h4,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(location, style: Styles.b2.copyWith(color: Palette.gray)),
          Text(event.date, style: Styles.b2.copyWith(color: Palette.gray)),
        ],
      ),
    );
  }

  Widget _buildEventsLoading() {
    return Shimmer.fromColors(
      baseColor: Palette.shimmerBase,
      highlightColor: Palette.shimmerHighlight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.only(right: 12),
          child: SizedBox(
            width: 270,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(height: 12),
                Container(height: 16, width: 220, color: Colors.black),
                const SizedBox(height: 8),
                Container(height: 12, width: 150, color: Colors.black),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
