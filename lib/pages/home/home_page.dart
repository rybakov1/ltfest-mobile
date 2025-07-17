import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/router/app_routes.dart';
import '../../data/models/news.dart';
import '../../data/models/upcoming_events.dart';
import '../../providers/auth_state.dart';
import '../../providers/news_provider.dart';
import '../../providers/upcoming_provider.dart';
import '../../providers/user_provider.dart';
import 'more_items_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final upcomingEvents = ref.watch(upcomingEventsProvider);
    final news = ref.watch(newsProvider);

    return Scaffold(
      backgroundColor: Palette.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _HomeHeader(),
              Padding(
                padding: const EdgeInsets.all(4),
                child: Container(
                  decoration: Decor.base,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 16),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 96,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              _buildCarouselItem('assets/images/ex.png'),
                              _buildCarouselItem('assets/images/ex.png'),
                              _buildCarouselItem('assets/images/ex.png'),
                              _buildCarouselItem('assets/images/ex.png'),
                              _buildCarouselItem('assets/images/ex.png'),
                              _buildCarouselItem('assets/images/ex.png'),
                              _buildCarouselItem('assets/images/ex.png'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        _buildSectionHeader(
                            'Ближайшие мероприятия', context, ref),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 250,
                          child: upcomingEvents.when(
                            data: (events) => ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: events.length,
                              itemBuilder: (context, index) {
                                final event = events[index];
                                return Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (event.type == EventType.festival) {
                                          context.push('/fest/${event.id}');
                                        } else {
                                          context.push('/lab/${event.id}');
                                        }
                                      },
                                      child: _buildEventCard(
                                          event: event,
                                          imageUrl: 'assets/images/ex.png'),
                                    ),
                                    const SizedBox(width: 12),
                                  ],
                                );
                              },
                            ),
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            error: (error, stack) => Center(
                              child: Text('Ошибка: $error'),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Container(
                          height: 100,
                          color: Palette.white,
                          alignment: Alignment.center,
                          child: const Text('Баннеры'),
                        ),
                        const SizedBox(height: 20),
                        _buildSectionHeader('Последние новости', context, ref),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 250,
                          child: news.when(
                            data: (news) => ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: news.length,
                              itemBuilder: (context, index) {
                                final article = news[index];
                                return Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: _buildNewsCard(
                                        title: article.title,
                                        date: article.date,
                                        image: 'assets/images/ex.png',
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                  ],
                                );
                              },
                            ),
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            error: (error, stack) => Center(
                              child: Text('Ошибка: $error'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarouselItem(String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 1.5, color: Palette.primaryLime)),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Image.asset(
              imagePath,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEventCard({
    required UpcomingEvent event,
    required String imageUrl,
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
                        imageUrl,
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
                          style: TextStyle(
                            color: event.direction.title == "Театр"
                                ? Colors.black
                                : Colors.white,
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
          const SizedBox(height: 8),
          Text(
            event.title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: "Mulish"),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            location,
            style: TextStyle(
                color: Palette.gray,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontFamily: "Mulish"),
          ),
          Text(
            event.date,
            style: TextStyle(
                color: Palette.gray,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontFamily: "Mulish"),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsCard({
    required String title,
    required DateTime date,
    required String image,
  }) {
    return SizedBox(
      width: 166,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              image,
              height: 170,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: Styles.b2,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            DateFormat().add_yMMMd().format(date),
            style: Styles.b3.copyWith(color: Palette.gray),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
      String title, BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: "Mulish",
          ),
        ),
        GestureDetector(
          onTap: () {
            if (title == 'Ближайшие мероприятия') {
              context.pushNamed('all-items', extra: {
                'title': 'Ближайшие мероприятия',
                'itemsAsync': ref.watch(upcomingEventsProvider),
                'itemBuilder': (UpcomingEvent event) =>
                    buildEventCard(event: event, context: context)
              });
            } else if (title == 'Последние новости') {
              context.pushNamed('all-items', extra: {
                'title': 'Ближайшие мероприятия',
                'itemsAsync': ref.watch(newsProvider),
                'itemBuilder': (News news) => buildNewsCard(news: news)
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
}

class _HomeHeader extends ConsumerWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);

    return authState.when(
      loading: () => const SizedBox(
          height: 57, child: Center(child: CircularProgressIndicator())),
      error: (err, stack) => SizedBox(
          height: 57,
          child: Center(
              child: Text('Ошибка',
                  style: Styles.h3.copyWith(color: Palette.white)))),
      data: (data) {
        if (data is Authenticated) {
          final user = data.user;
          final displayName = user.lastname.trim();
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16.0),
            child: SizedBox(
              height: 57,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      displayName,
                      style: Styles.h3.copyWith(color: Palette.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox(height: 57);
      },
    );
  }
}
