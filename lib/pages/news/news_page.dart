import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ltfest/components/lt_appbar.dart';
import 'package:ltfest/router/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';
import '../../data/models/news.dart';
import '../../providers/news_provider.dart';

class NewsPage extends ConsumerWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsAsync = ref.watch(newsNotifierProvider);

    return Scaffold(
      backgroundColor: Palette.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: LTAppBar(title: "Новости LT Fest"),
            ),
            SliverFillRemaining(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  decoration: Decor.base,
                  child: newsAsync.when(
                    data: (newsList) {
                      if (newsList.isEmpty) {
                        return Container(
                          decoration: Decor.base,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/icons/states/nothing.png',
                                  width: 192,
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'Скоро здесь появятся новости',
                                  style: Styles.b3,
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 4,
                          mainAxisExtent: 232,
                        ),
                        itemCount: newsList.length,
                        itemBuilder: (context, index) {
                          final newsItem = newsList[index];
                          return _buildNewsCard(
                            context: context,
                            news: newsItem,
                          );
                        },
                      );
                    },
                    loading: () => Center(
                      child:
                          CircularProgressIndicator(color: Palette.primaryLime),
                    ),
                    error: (error, stack) => Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Ошибка загрузки новостей: $error',
                              textAlign: TextAlign.center,
                              style: Styles.b1.copyWith(color: Palette.gray),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () =>
                                  ref.refresh(newsNotifierProvider),
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsCard({
    required BuildContext context,
    required News news,
  }) {
    return GestureDetector(
      onTap: () => context.push("${AppRoutes.news}/${news.id}"),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              'http://37.46.132.144:1337${news.image?.formats?.medium?.url ?? news.image?.url ?? ''}',
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            news.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: Styles.h5,
          ),
          const SizedBox(height: 4),
          Text(
            DateFormat('dd MMMM yyyy', 'ru').format(news.date),
            style: Styles.b3.copyWith(color: Palette.gray),
          ),
        ],
      ),
    );
  }
}
