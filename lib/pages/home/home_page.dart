import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/pages/more/more_page.dart';
import 'package:ltfest/pages/shop/presenter/shop_widget.dart';
import 'package:ltfest/router/app_routes.dart';
import '../../components/banner_carousel.dart';
import '../../components/news_widget.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Palette.background,
      drawer: Drawer(
        width: MediaQuery.of(context).size.width,
        child: const MorePage(),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 100.0,
              floating: true,
              pinned: false,
              snap: true,
              backgroundColor: Palette.background,
              automaticallyImplyLeading: false,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Builder(builder: (innerContext) {
                  return Container(
                    color: Palette.background,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () => Scaffold.of(innerContext).openDrawer(),
                            child: const Icon(Icons.menu, size: 24),
                          ),
                          const Spacer(),
                          Column(
                            children: [
                              Image.asset(
                                'assets/images/logo_black.png',
                                height: 24,
                              ),
                              Text(
                                "Всероссийское фестивальное движение",
                                style: Styles.b3,
                              )
                            ],
                          ),
                          const Spacer(),
                          const SizedBox(width: 24)
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Container(
                  decoration: Decor.base,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: _buildCategoryButton(
                                color: Palette.primaryLime,
                                imagePath: 'assets/images/teatr.png',
                                label: 'Театр',
                                size: 90,
                                offset: 30,
                                onTap: () => context
                                    .push("${AppRoutes.festivals}/Театр"),
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: _buildCategoryButton(
                                color: Palette.primaryPink,
                                imagePath: 'assets/images/dance.png',
                                label: 'Танцы',
                                size: 80,
                                offset: 20,
                                onTap: () => context
                                    .push("${AppRoutes.festivals}/Танцы"),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          height: 194,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: _buildCategoryButton(
                                        imagePath: 'assets/images/lab_logo.png',
                                        color: Palette.gray,
                                        size: 90,
                                        offset: 20,
                                        label: 'Лаборатории',
                                        isGradient: true,
                                        onTap: () => context
                                            .push(AppRoutes.laboratories),
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    Expanded(
                                      child: _buildCategoryButton(
                                        imagePath:
                                            'assets/images/concierge.png',
                                        color: Palette.gray,
                                        size: 75,
                                        offset: 15,
                                        label: 'LT Консьерж',
                                        isGradient: true,
                                        onTap: () =>
                                            context.push(AppRoutes.ltConcierge),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 24),
                              Expanded(
                                child: _buildServiceCard(
                                  imagePath: 'assets/images/lt_coin.png',
                                  label: 'LT Coin',
                                  onTap: () => context.push(AppRoutes.ltCoin),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          height: 89,
                          child: GridView.count(
                            scrollDirection: Axis.horizontal,
                            crossAxisCount: 1,
                            children: [
                              _buildServiceCard(
                                imagePath: 'assets/images/lt_winner.png',
                                label: 'LT Winner',
                                isSmall: true,
                                onTap: () => context.push(AppRoutes.ltWinner),
                              ),
                              _buildServiceCard(
                                imagePath: 'assets/images/lt_pay.png',
                                label: 'LT Pay',
                                isSmall: true,
                                onTap: () => context.push(AppRoutes.ltPay),
                              ),
                              // TODO: lttravel waiting
                              _buildServiceCard(
                                imagePath: 'assets/images/lt_travel.png',
                                label: 'LT Travel',
                                isSmall: true,
                                onTap: () => context.push(AppRoutes.ltTravel),
                              ),
                              _buildServiceCard(
                                imagePath: 'assets/images/lt_priority.png',
                                label: 'LT Priority',
                                isSmall: true,
                                onTap: () => context.push(AppRoutes.ltPriority),
                              ),
                              // TODO: ltcamp waiting
                              // _buildServiceCard(
                              //   imagePath: 'assets/images/lt_camp.png',
                              //   label: 'LT Camp',
                              //   isSmall: true,
                              //   onTap: () => context.push(AppRoutes.ltPriority),
                              // ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        const BannerCarousel(),
                        const SizedBox(height: 24),
                        const NewsWidget(),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("LT Shop", style: Styles.h3),
                            GestureDetector(
                              onTap: () => context.push(AppRoutes.shop),
                              child: Text(
                                "Все",
                                style: Styles.b2
                                    .copyWith(color: Palette.secondary),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 24),
                        const ShopWidget(),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard({
    required String imagePath,
    required String label,
    required VoidCallback onTap,
    bool isSmall = false,
  }) {
    if (isSmall) {
      return GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 68,
              width: 67,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromRGBO(240, 242, 245, 1),
                    Color.fromRGBO(231, 234, 237, 1),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.asset(imagePath, fit: BoxFit.cover),
              ),
            ),
            Text(label, style: Styles.h5),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromRGBO(240, 242, 245, 1),
                    Color.fromRGBO(231, 234, 237, 1),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Styles.h5,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton({
    required Color color,
    required String imagePath,
    required String label,
    required double size,
    required double offset,
    required VoidCallback onTap,
    bool isGradient = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: isGradient ? null : color,
                  gradient: isGradient
                      ? const LinearGradient(
                          colors: [
                            Color.fromRGBO(240, 242, 245, 1),
                            Color.fromRGBO(231, 234, 237, 1),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )
                      : null,
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              Positioned(
                top: -offset,
                child: Image.asset(
                  imagePath,
                  height: size,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Text(label, style: Styles.h5)
        ],
      ),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.menu, size: 24),
          const Spacer(),
          Column(
            children: [
              Image.asset(
                'assets/images/logo_black.png',
                height: 24,
              ),
              Text(
                "Всероссийское фестивальное движение",
                style: Styles.b3,
              )
            ],
          ),
          const Spacer(),
          const SizedBox(width: 24)
        ],
      ),
    );
  }
}