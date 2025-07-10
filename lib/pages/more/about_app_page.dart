import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  // Хелпер для запуска URL
  Future<void> _launchUrl(String urlString) async {
    final uri = Uri.parse(urlString);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.black,
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
                    style: Styles.h3.copyWith(color: Palette.white),
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
                      icon: Icon(Icons.arrow_back, color: Palette.black),
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
              margin: EdgeInsets.fromLTRB(4, 16, 4, MediaQuery.of(context).padding.bottom),
              decoration: Decor.base,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 12),
                    Image.asset('assets/images/logo_black.png', height: 60),
                    const SizedBox(height: 16),
                    Text('Версия 0.0.1, сборка 1',
                        style: Styles.b3.copyWith(color: Palette.gray)),
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
          child: Text('Lt_fest@mail.ru', style: Styles.h3),
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
            // _SocialIcon(iconPath: 'assets/icons/vk.svg', url: 'https://vk.com'),
            // const SizedBox(width: 16),
            // _SocialIcon(
            //     iconPath: 'assets/icons/youtube.svg',
            //     url: 'https://youtube.com'),
            // const SizedBox(width: 16),
            _SocialIcon(
                iconPath: 'assets/icons/tg.svg', url: 'https://t.me'),
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
    return Column(
      children: [
        _InfoLinkTile(
          title: 'Политика обработки персональных данных',
          onTap: () {
            // TODO: Открыть ссылку или страницу
          },
        ),
        Divider(color: Palette.stroke),
        _InfoLinkTile(
          title: 'Оферта',
          onTap: () {
            // TODO: Открыть ссылку или страницу
          },
        ),
        Divider(color: Palette.stroke),
        _InfoLinkTile(
          title: 'Основы режиссуры',
          onTap: () {
            // TODO: Открыть ссылку или страницу
          },
        ),
        Divider(color: Palette.stroke),
        _InfoLinkTile(
          title: 'Сценическая речь',
          onTap: () {
            // TODO: Открыть ссылку или страницу
          },
        ),
      ],
    );
  }
}

// Переиспользуемый виджет для иконки соц. сети
class _SocialIcon extends StatelessWidget {
  final String iconPath;
  final String url;

  const _SocialIcon({required this.iconPath, required this.url});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      borderRadius: BorderRadius.circular(20),
      child: SvgPicture.asset(iconPath, width: 40, height: 40),
    );
  }
}

// Переиспользуемый виджет для ссылок внизу
class _InfoLinkTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _InfoLinkTile({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: Styles.b2),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Palette.gray),
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      onTap: onTap,
    );
  }
}
