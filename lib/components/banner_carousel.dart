import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ltfest/data/services/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../providers/banner_provider.dart';

class BannerCarousel extends ConsumerStatefulWidget {
  const BannerCarousel({super.key});

  @override
  ConsumerState<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends ConsumerState<BannerCarousel> {
  @override
  Widget build(BuildContext context) {
    final apiService = ref.read(apiServiceProvider);

    final bannerAsyncValue = ref.watch(bannerProvider);

    return SizedBox(
      height: 180,
      child: bannerAsyncValue.when(
        loading: () => _buildBannerLoading(),
        error: (error, stack) => Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Palette.gray.withValues(alpha: 0.2),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Не удалось загрузить баннеры'),
              const SizedBox(height: 8),
              // TODO: error handler
              ElevatedButton(
                onPressed: () => ref.refresh(bannerProvider),
                // Кнопка для повторной загрузки
                child: const Text('Попробовать снова'),
              )
            ],
          ),
        ),
        data: (bannerList) {
          if (bannerList.isEmpty) {
            return const SizedBox(
              height: 180,
              child: Center(child: Text('Нет доступных баннеров')),
            );
          }

          return Column(
            children: [
              CarouselSlider.builder(
                itemCount: bannerList.length,
                itemBuilder: (context, index, realIndex) {
                  final banner = bannerList[index];
                  final imageUrl = apiService.getImageUrl(banner.image?.url);

                  return InkWell(
                    onTap: () {
                      if (banner.url != null && banner.url!.isNotEmpty) {
                        launchUrl(Uri.parse(banner.url!));
                      }
                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: Image.network(
                        imageUrl,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.error, color: Palette.error),
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 180,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 6),
                  enlargeCenterPage: true,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {});
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBannerLoading() {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Palette.gray.withValues(alpha: 0.3),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
