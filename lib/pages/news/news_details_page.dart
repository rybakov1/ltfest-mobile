import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:ltfest/components/lt_appbar.dart';
import 'package:ltfest/providers/news_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/components/share_button.dart';
import '../../data/models/news.dart';

class NewsDetailsPage extends ConsumerStatefulWidget {
  final String id;

  const NewsDetailsPage({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<NewsDetailsPage> createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends ConsumerState<NewsDetailsPage> {
  final ScrollController _scrollController = ScrollController();
  bool _showHeader = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      debugPrint('Scroll offset: ${_scrollController.offset}');
      if (_scrollController.offset > 56 && !_showHeader) {
        setState(() => _showHeader = true);
      } else if (_scrollController.offset <= 56 && _showHeader) {
        setState(() => _showHeader = false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final newsAsync = ref.watch(newsByIdProvider(widget.id));

    return Scaffold(
      backgroundColor: Palette.background,
      body: Stack(
        children: [
          newsAsync.when(
            data: (news) {
              return SingleChildScrollView(
                controller: _scrollController,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(12),
                      ),
                      child: Image.network(
                        'http://37.46.132.144:1337${news.image?.formats?.medium?.url ?? news.image?.url ?? ''}',
                        height: 360,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SafeArea(
                      child: content(context, news), // Вынесли в метод
                    ),
                  ],
                ),
              );
            },
            loading: () => Center(
                child: CircularProgressIndicator(color: Palette.primaryLime)),
            error: (error, stack) => SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Ошибка загрузки новости: $error',
                        textAlign: TextAlign.center,
                        style: Styles.b1.copyWith(color: Palette.gray),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () =>
                            ref.invalidate(newsByIdProvider(widget.id)),
                        // Invalidate провайдера
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Palette.primaryLime,
                          foregroundColor: Palette.white,
                        ),
                        child: const Text('Попробовать снова'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Floating header
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: newsAsync.when(
              data: (news) => AnimatedOpacity(
                opacity: _showHeader ? 1 : 0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top, // Без +16
                    bottom: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Palette.background,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LtAppbar(
                        title: "",
                        postfixIcon: ShareButton(
                          link: news.url ?? 'https://ltfest.ru',
                          color: Palette.primaryLime,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          news.title,
                          style: Styles.h3.copyWith(color: Palette.black),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              loading: () => const SizedBox.shrink(),
              error: (error, stack) => const SizedBox.shrink(),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: newsAsync.when(
              data: (news) => Container(
                padding: EdgeInsets.fromLTRB(
                  16,
                  16,
                  16,
                  MediaQuery.of(context).padding.bottom + 16,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    final uri = Uri.parse(news.url ?? 'https://ltfest.ru');
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri,
                          mode: LaunchMode.externalApplication);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Palette.primaryLime,
                    foregroundColor: Palette.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                  ),
                  child: const Text(
                    'Перейти',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              loading: () => const SizedBox.shrink(),
              error: (error, stack) => const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }

  Widget content(BuildContext context, News news) {
    final formattedDate = DateFormat('dd MMMM yyyy', 'ru').format(news.date);
    final url = news.url ?? 'https://ltfest.ru';

    return Column(
      children: [
        LtAppbar(
          title: "",
          suffixIconColor: Palette.stroke,
          postfixIcon: ShareButton(
            link: url,
            color: Palette.stroke,
          ),
        ),
        SizedBox(height: 270 - MediaQuery.of(context).padding.top),
        Container(
          decoration: Decor.base,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(news.title, style: Styles.h3),
              const SizedBox(height: 8),
              Row(
                children: [
                  SvgPicture.asset("assets/icons/calendar.svg"),
                  const SizedBox(width: 12),
                  Text(formattedDate, style: Styles.b2),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                news.description ?? '',
                style: Styles.b2,
              ),
            ],
          ),
        ),
        SizedBox(height: 36 + MediaQuery.of(context).padding.bottom),
      ],
    );
  }
}
