import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../constants.dart';
import '../data/services/api_endpoints.dart';
import '../providers/news_provider.dart';
import '../router/app_routes.dart';

class NewsWidget extends ConsumerWidget {
  const NewsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ltNews = ref.watch(newsNotifierProvider);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Новости LT Fest", style: Styles.h3),
            GestureDetector(
              onTap: () => context.push(AppRoutes.news),
              child: Text(
                "Все",
                style: Styles.b2.copyWith(color: Palette.secondary),
              ),
            )
          ],
        ),
        const SizedBox(height: 16),
        ltNews.when(
          data: (news) {
            final first = news[0];
            final second = news[1];
            return Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => context.push("${AppRoutes.news}/${first.id}"),
                    child: _buildNewsCard(
                      title: first.title,
                      date: first.date,
                      imageUrl: first.image!.url,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () => context.push("${AppRoutes.news}/${second.id}"),
                    child: _buildNewsCard(
                      title: second.title,
                      date: second.date,
                      imageUrl: second.image!.url,
                    ),
                  ),
                ),
              ],
            );
          },
          loading: () => _buildNewsLoading(),
          error: (error, stack) => Center(child: Text('Ошибка: $error')),
        )
      ],
    );
  }

  Widget _buildNewsLoading() {
    return SizedBox(
      height: 230,
      child: Shimmer.fromColors(
        baseColor: Palette.shimmerBase,
        highlightColor: Palette.shimmerHighlight,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 2,
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
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
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
      ),
    );
  }

  Widget _buildNewsCard({
    required String title,
    required DateTime date,
    required String imageUrl,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: Image.network(
            "${ApiEndpoints.baseStrapiUrl}$imageUrl",
            height: 160,
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
    );
  }
}
