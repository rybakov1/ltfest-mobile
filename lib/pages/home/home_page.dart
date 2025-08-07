import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/data/models/image_data.dart';
import 'package:ltfest/providers/story_provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/banner_carousel.dart';
import '../../data/models/ltstory.dart';
import '../../data/models/news.dart';
import '../../data/models/upcoming_events.dart';
import '../../providers/auth_state.dart';
import '../../providers/banner_provider.dart';
import '../../providers/news_provider.dart';
import '../../providers/upcoming_provider.dart';
import '../../providers/user_provider.dart';
import 'more_items_page.dart';
import 'package:story_view/story_view.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final upcomingEvents = ref.watch(upcomingEventsProvider);
    final news = ref.watch(newsProvider);
    // final banner = ref.watch(bannerProvider);
    final storiesAsync = ref.watch(storyProvider);

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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- Сторисы ---
                        SizedBox(
                          height: 96,
                          child: storiesAsync.when(
                            data: (stories) => stories.isEmpty
                                ? Center(
                                    child: Text(
                                      'Нет доступных сторис',
                                      style: TextStyle(
                                        color: Palette.gray,
                                        fontFamily: 'Mulish',
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: stories.length,
                                    itemBuilder: (context, index) {
                                      final story = stories[index];
                                      return _buildStoryPreview(
                                        context: context,
                                        imageUrl:
                                            'http://37.46.132.144:1337${story.preview!.formats?.thumbnail?.url}',
                                        onTap: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .push(
                                            // <--- ИЗМЕНЕНИЕ ЗДЕСЬ
                                            MaterialPageRoute(
                                              builder: (context) => StoryViewer(
                                                story: stories[index],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                            loading: () => _buildStoriesLoading(), // Shimmer
                            error: (error, stack) => Center(
                              child: Text(
                                'Ошибка загрузки сторис: $error',
                                style: TextStyle(
                                  color: Palette.gray,
                                  fontFamily: 'Mulish',
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),

                        // --- Ближайшие мероприятия ---
                        _buildSectionHeader(
                            'Ближайшие мероприятия', context, ref),
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
                                        event: event, imageUrl: event.image!),
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
                        const SizedBox(height: 32),
                        const BannerCarousel(),
                        const SizedBox(height: 20),
                        // --- Последние новости ---
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
                                return Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: _buildNewsCard(
                                      title: article.title,
                                      date: article.date,
                                      imageUrl: article.image!.url,
                                    ),
                                  ),
                                );
                              },
                            ),
                            loading: () => _buildNewsLoading(), // Shimmer
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

  Widget _buildStoryPreview({
    required BuildContext context,
    required String imageUrl,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 1.5, color: Palette.primaryLime),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: imageUrl.startsWith('http')
                  ? Image.network(
                      imageUrl,
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        'assets/images/ex.png',
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Image.asset(
                      imageUrl,
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
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
                            horizontal: 8.0, vertical: 6),
                        child: Text(event.direction.title,
                            style: Styles.b3.copyWith(color: Palette.white)),
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

  Widget _buildStoriesLoading() {
    return Shimmer.fromColors(
      baseColor: Palette.shimmerBase,
      highlightColor: Palette.shimmerHighlight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5, // Отображаем 5 заглушек
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0),
          child: Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
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

  Widget _buildBannerLoading() {
    return Shimmer.fromColors(
      baseColor: Palette.shimmerBase,
      highlightColor: Palette.shimmerHighlight,
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildNewsLoading() {
    return Shimmer.fromColors(
      baseColor: Palette.shimmerBase,
      highlightColor: Palette.shimmerHighlight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.only(right: 12),
          child: SizedBox(
            width: 166,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 170,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(height: 12),
                Container(height: 14, width: 140, color: Colors.black),
                const SizedBox(height: 8),
                Container(height: 10, width: 100, color: Colors.black),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNewsCard({
    required String title,
    required DateTime date,
    required String imageUrl,
  }) {
    return SizedBox(
      width: 166,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              "http://37.46.132.144:1337$imageUrl",
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
            DateFormat("yMMMMd", "ru").format(date),
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
      loading: () => Shimmer.fromColors(
          baseColor: Palette.shimmerBase,
          highlightColor: Palette.shimmerHighlight,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16.0),
            child: Container(
              width: 200,
              height: 28,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black,
              ),
            ),
          )),
      error: (err, stack) => SizedBox(
          height: 57,
          child: Center(
              child: Text('Ошибка',
                  style: Styles.h3.copyWith(color: Palette.white)))),
      data: (data) {
        if (data is Authenticated) {
          final user = data.user;
          final displayName = user.lastname?.trim() ?? 'Пользователь';
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
                      overflow: TextOverflow.ellipsis,
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

class StoryViewer extends StatefulWidget {
  final LTStory story;

  const StoryViewer({
    super.key,
    required this.story,
  });

  @override
  StoryViewerState createState() => StoryViewerState();
}

class StoryViewerState extends State<StoryViewer> {
  final StoryController _storyController = StoryController();

  @override
  void dispose() {
    _storyController.dispose();
    super.dispose();
  }

  // Функция для открытия ссылки
  Future<void> _launchURL(String urlString) async {
    final Uri uri = Uri.parse(urlString);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // Показываем ошибку, если не удалось открыть ссылку
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Не удалось открыть ссылку: $urlString')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // 1. Получаем список медиа-элементов (без изменений)
    final List<ImageData> mediaItems = widget.story.media!;
    final List<StoryItem> storyItems = mediaItems.map((mediaItem) {
      final mediaUrl = 'http://37.46.132.144:1337${mediaItem.url}';
      final bool isVideo = mediaItem.mime.startsWith('video/');

      if (isVideo) {
        return StoryItem.pageVideo(
          mediaUrl,
          controller: _storyController,
          caption: const Text(
            "", //widget.story.title!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              backgroundColor: Colors.black54,
              fontFamily: 'Mulish',
            ),
          ),
        );
      } else {
        return StoryItem.pageImage(
          url: mediaUrl,
          controller: _storyController,
          caption: const Text(
            "", //widget.story.title!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              backgroundColor: Colors.black54,
              fontFamily: 'Mulish',
            ),
          ),
          duration: const Duration(seconds: 5),
        );
      }
    }).toList();

    // 2. Проверяем, есть ли ссылка для этой группы сторис
    final bool hasLink =
        widget.story.url != null && widget.story.url!.isNotEmpty;

    // 3. Оборачиваем все в Stack, чтобы разместить кнопку поверх сторис
    return Scaffold(
      body: Stack(
        children: [
          // Слой 1: Сам плеер сторис
          StoryView(
            storyItems: storyItems,
            controller: _storyController,
            onComplete: () {
              Navigator.pop(context);
            },
            onStoryShow: (storyItem, index) {
              print(
                  "Показывается сторис №$index из группы '${widget.story.title}'");
            },
            onVerticalSwipeComplete: (direction) {
              if (direction == Direction.down) {
                Navigator.pop(context);
              }
            },
            progressPosition: ProgressPosition.top,
            repeat: false,
            inline: false,
            indicatorColor: Palette.gray,
            indicatorForegroundColor: Palette.primaryLime,
          ),

          if (hasLink)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20 +
                        MediaQuery.of(context).padding.bottom), // Отступ снизу
                width: double.infinity,
                child: LTButtons.elevatedButton(
                  onPressed: () {
                    _storyController.pause();
                    _launchURL(widget.story.url!).then((_) {
                      _storyController.play();
                    });
                  },
                  child: Text('Подробнее', style: Styles.button1),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
