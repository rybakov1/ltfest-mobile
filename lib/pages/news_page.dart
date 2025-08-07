import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../data/models/news.dart';
import '../providers/news_provider.dart';

class NewsPage extends ConsumerWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsAsync = ref.watch(newsProvider);

    return Scaffold(
      backgroundColor: Palette.black,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 24, horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Новости",
                      style: Styles.h3.copyWith(color: Palette.white),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Palette.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Поиск по новостям",
                        hintStyle: Styles.b2,
                        contentPadding: const EdgeInsets.only(
                            left: 16, top: 13, bottom: 13),
                      ),
                      onChanged: (value) {
                        // TODO: Реализовать поиск в будущем
                      },
                    ),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4),
                child: Container(
                  decoration: BoxDecoration(
                    color: Palette.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: newsAsync.when(
                    data: (newsList) {
                      if (newsList.isEmpty) {
                        return Center(
                          child: Text(
                            'Новости не найдены',
                            style: Styles.b1,
                          ),
                        );
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
                        itemCount: newsList.length,
                        itemBuilder: (context, index) {
                          final newsItem = newsList[index];
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: index == newsList.length - 1 ? 0 : 32,
                            ),
                            child: _buildNewsCard(
                              context: context,
                              news: newsItem,
                            ),
                          );
                        },
                      );
                    },
                    loading: () => Center(
                      child: CircularProgressIndicator(color: Palette.primaryLime),
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

                            // TODO: error handler
                            ElevatedButton(
                              onPressed: () => ref.refresh(newsProvider),
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
            const SliverToBoxAdapter(child: SizedBox(height: 4)),
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
      onTap: () async {
        if (news.url != null && await canLaunchUrl(Uri.parse(news.url!))) {
          await launchUrl(Uri.parse(news.url!), mode: LaunchMode.externalApplication);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (news.image != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'http://37.46.132.144:1337${news.image?.formats?.medium?.url ?? news.image?.url ?? ''}',
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/placeholder.png',
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          if (news.image != null) const SizedBox(height: 12),

          Text(
            news.title,
            style: Styles.h4,
          ),
          const SizedBox(height: 8),

          // Описание
          if (news.description != null) ...[
            Text(
              news.description!,
              style: Styles.b2.copyWith(color: Palette.gray),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
          ],

          // Дата
          Text(
            DateFormat('dd MMMM yyyy', 'ru_RU').format(news.date.toLocal()),
            style: Styles.b2.copyWith(color: Palette.gray),
          ),
        ],
      ),
    );
  }
}