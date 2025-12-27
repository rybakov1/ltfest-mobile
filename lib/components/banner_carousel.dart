import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ltfest/data/services/api_service.dart';
import 'package:shimmer/shimmer.dart';
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
        loading: () => _buildBannerShimmer(),
        error: (error, stack) => _buildErrorState(),
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
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        fadeInDuration: const Duration(milliseconds: 300),
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Palette.shimmerBase,
                          highlightColor: Palette.shimmerHighlight,
                          child: Container(
                            color: Colors.white,
                            height: 180,
                            width: double.infinity,
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Palette.gray.withValues(alpha: 0.2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.broken_image_outlined,
                                  color: Palette.gray),
                              const SizedBox(height: 4),
                              Text(
                                "Проблемы с соединением",
                                style: Styles.b2.copyWith(color: Palette.gray),
                              )
                            ],
                          ),
                        ),
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

  Widget _buildBannerShimmer() {
    return Shimmer.fromColors(
      baseColor: Palette.shimmerBase,
      highlightColor: Palette.shimmerHighlight,
      child: Container(
        height: 180,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Palette.gray.withValues(alpha: 0.2),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Не удалось загрузить'),
          TextButton(
            onPressed: () => ref.refresh(bannerProvider),
            child: const Text('Обновить'),
          )
        ],
      ),
    );
  }
}
