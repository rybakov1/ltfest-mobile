import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/constants.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> _launchUrl(String urlString) async {
  final uri = Uri.parse(urlString);
  await launchUrl(uri, mode: LaunchMode.externalApplication);
}

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 24 + MediaQuery.of(context).padding.top,
                bottom: 16),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "О приложении",
                    style: Styles.h4,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 43,
                    width: 43,
                    decoration: Decor.base.copyWith(color: Palette.primaryLime),
                    child: IconButton(
                      onPressed: () => context.pop(),
                      icon: Icon(Icons.arrow_back, color: Palette.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              margin: EdgeInsets.fromLTRB(
                  4, 16, 4, MediaQuery.of(context).padding.bottom),
              decoration: Decor.base,
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 24),
                    Image.asset('assets/images/logo_black.png', height: 60),
                    const SizedBox(height: 16),
                    Text('Версия 0.2.0, сборка 25',
                        style: Styles.b2.copyWith(color: Palette.gray)),
                    const SizedBox(height: 24),
                    _buildContactInfo(),
                    const SizedBox(height: 24),
                    _buildDescription(),
                    const SizedBox(height: 24),
                    _buildLinkSection(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => _launchUrl('mailto:lt_fest@mail.ru'),
          child: Text('lt_fest@mail.ru', style: Styles.h3),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _launchUrl('tel:8-800-201-5741'),
          child: Text('8-800-201-5741', style: Styles.h3),
        ),
        const SizedBox(height: 4),
        Text('Звонок по России бесплатный',
            style: Styles.b3.copyWith(color: Palette.gray)),
        const SizedBox(height: 16),
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _SocialIcon(
                iconPath: 'assets/icons/social/vk.svg',
                url: 'https://vk.com/lt_fest'),
            SizedBox(width: 8),
            // _SocialIcon(
            //     iconPath: 'assets/icons/social/yt.svg',
            //     url: 'https://youtube.com'),
            // SizedBox(width: 8),
            _SocialIcon(
                iconPath: 'assets/icons/social/tg.svg',
                url: 'https://t.me/ltfest'),
          ],
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Организатор театральных фестивалей и хореографических конкурсов, а так же детского лагеря и творческих лабораторий в вашем городе. Помогаем многим талантливым детям и подросткам раскрыть свой творческий потенциал.',
          style: Styles.b3.copyWith(color: Palette.gray),
        ),
        const SizedBox(height: 16),
        Text(
          'Министерство образования, науки и молодежной политики\nРегистрационный номер лицензии: No Л035-01218-23/01109631',
          style: Styles.b3.copyWith(color: Palette.gray),
        ),
        const SizedBox(height: 16),
        InkWell(
          onTap: () => _launchUrl('https://ltfest.ru/'),
          child: Text('https://ltfest.ru/',
              style: Styles.b2.copyWith(color: Palette.secondary)),
        ),
      ],
    );
  }

  Widget _buildLinkSection() {
    return const Column(
      children: [
        _InfoLinkTile(
            title: 'Политика обработки персональных данных ООО «МФД ЛТ»',
            url: 'https://lt-world.ru/policy'),
        SizedBox(height: 8),
        _InfoLinkTile(
            title: 'Политика обработки персональных данных ООО «ЛТ Фест»',
            url: 'https://ltfest.ru/privacy'),
        SizedBox(height: 8),
        _InfoLinkTile(
            title: 'Основы режиссуры',
            url:
                'https://drive.google.com/file/d/186cxovf8pIoNBP2-jQk7pE_hBB8cK12U/view'),
        SizedBox(height: 8),
        _InfoLinkTile(
            title: 'Сценическая речь',
            url:
                'https://drive.google.com/file/d/1aH7Pxm-mCRl0GzoxvhE_fpIhduvHLlY1/view'),
        SizedBox(height: 8),
        _InfoLinkTile(
            title: 'Публичный договор-оферта',
            url: 'https://ltfest.ru/offerdoc'),
        SizedBox(height: 8),
        _InfoLinkTile(
            title: 'Дополнение к публичному договору-оферте',
            url: 'https://ltfest.ru/offerdoc/add'),
        SizedBox(height: 8),
        _InfoLinkTile(
            title: 'Публичный договор-оферта «LT Счастливчик»',
            url: 'https://ltfest.ru/winner'),
        SizedBox(height: 8),
        _InfoLinkTile(
            title: 'Пользовательское соглашение «LT Консьерж»',
            url: 'https://ltfest.ru/concierge'),
        SizedBox(height: 8),
        _InfoLinkTile(
          title: 'Публичный договор-оферта (международные фестивали)',
          url: 'https://ltfest.ru/offerglobal',
        ),
      ],
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final String iconPath;
  final String url;

  const _SocialIcon({required this.iconPath, required this.url});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _launchUrl(url),
      borderRadius: BorderRadius.circular(20),
      child: SvgPicture.asset(iconPath, width: 40, height: 40),
    );
  }
}

class _InfoLinkTile extends StatelessWidget {
  final String title;
  final String url;

  const _InfoLinkTile({required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _launchUrl(url),
      child: Container(
        decoration: BoxDecoration(
          color: Palette.background,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: Styles.b2,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 4),
            Icon(Icons.arrow_forward_ios, size: 16, color: Palette.gray)
          ],
        ),
      ),
    );
  }
}
