import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ltfest/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/news.dart';
import '../../data/models/upcoming_events.dart';

class AllItemsPage<T> extends ConsumerWidget {
  final String title;
  final AsyncValue<List<T>> itemsAsync;

  const AllItemsPage({
    super.key,
    required this.title,
    required this.itemsAsync,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Palette.black,
      appBar: AppBar(
        backgroundColor: Palette.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Palette.white),
          onPressed: () => context.pop(),
        ),
        title: Text(
          title,
          style: Styles.h3.copyWith(color: Palette.white),
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              decoration: Decor.base,
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    kToolbarHeight,
              ),
              child: itemsAsync.when(
                data: (items) => _buildListView(items, context),
                loading: () => const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (error, stack) =>
                    const Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListView(List<T> items, BuildContext context) {
    if (items.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            'Элементы не найдены',
            style: TextStyle(color: Palette.black),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Column(
          children: [
            _buildItem(item, context),
            if (index < items.length - 1) const SizedBox(height: 16),
            if (index == items.length - 1) const SizedBox(height: 40),
          ],
        );
      },
    );
  }

  Widget _buildItem(T item, BuildContext context) {
    if (item is News) {
      return buildNewsCard(news: item as News);
    } else if (item is UpcomingEvent) {
      return buildEventCard(event: item as UpcomingEvent, context: context);
    } else {
      return const SizedBox.shrink(); // Fallback for unsupported types
    }
  }
}

// Карточка для мероприятий
Widget buildEventCard({
  required UpcomingEvent event,
  required BuildContext context,
}) {
  final location =
      event.address != null && event.address!.toLowerCase().contains('онлайн')
          ? event.address!
          : event.address ?? 'Онлайн';

  return GestureDetector(
    onTap: () async {
      if (event.type == EventType.festival) {
        context.push('/fest/${event.id}');
      } else {
        context.push('/lab/${event.id}');
      }
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: event.image != null
                  ? Image.network(
                      "http://37.46.132.144:1337${event.image}",
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
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
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: event.direction.title == "Театр"
                            ? Palette.primaryLime
                            : Palette.primaryPink,
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 4),
                      child: Text(
                        event.direction.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: "Mulish",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {
                      // TODO: Реализовать добавление в избранное
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          event.title,
          style: Styles.h4,
        ),
        const SizedBox(height: 8),
        Text(
          location,
          style: Styles.b2.copyWith(color: Palette.gray),
        ),
        Text(
          event.date,
          style: Styles.b2.copyWith(color: Palette.gray),
        ),
      ],
    ),
  );
}

Widget buildNewsCard({required News news}) {
  bool isExpanded = false;

  return StatefulBuilder(
    builder: (context, setState) {
      return GestureDetector(
        onTap: news.url != null
            ? () async {
                final uri = Uri.parse(news.url!);
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            : null,
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  'http://37.46.132.144:1337${news.image?.formats?.medium?.url ?? news.image?.url ?? ''}',
                  height: 170,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                news.title,
                style: Styles.h4,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                DateFormat('dd MMMM yyyy').format(news.date),
                style: Styles.b3,
              ),
              if (news.description != null) ...[
                const SizedBox(height: 8),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: isExpanded ? double.infinity : 60.0,
                  ),
                  child: Text(
                    news.description!,
                    style: Styles.b2,
                    maxLines: isExpanded ? null : 3,
                    overflow: isExpanded ? null : TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: Text(
                    isExpanded ? 'Скрыть' : 'Подробнее',
                    style: Styles.button2.copyWith(
                      color: Palette.secondary,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    },
  );
}
