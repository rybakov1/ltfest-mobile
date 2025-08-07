import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppSettingsPage extends ConsumerStatefulWidget {
  const AppSettingsPage({super.key});

  @override
  ConsumerState<AppSettingsPage> createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends ConsumerState<AppSettingsPage> {
  // Состояния для переключателей
  bool _newsNotifications = true;
  bool _eventNotifications = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // TODO: Здесь нужно будет загрузить сохраненные настройки пользователя
    // например, из SharedPreferences или провайдера.
  }

  Future<void> _saveSettings() async {
    setState(() => _isLoading = true);

    // Имитация сохранения
    await Future.delayed(const Duration(seconds: 1));

    // TODO: Здесь будет логика сохранения настроек
    // ref.read(settingsProvider.notifier).updateSettings(
    //   news: _newsNotifications,
    //   events: _eventNotifications,
    // );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Настройки сохранены'),
          backgroundColor: Colors.green,
        ),
      );
      setState(() => _isLoading = false);
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
                    "Настройки приложения",
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
              margin: const EdgeInsets.fromLTRB(4, 16, 4, 2),
              decoration: Decor.base,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Уведомления',
                      style: Styles.h5.copyWith(color: Palette.gray)),
                  const SizedBox(height: 16),
                  _SettingsSwitchTile(
                    iconPath: 'assets/icons/news.svg',
                    // Укажите правильные пути к иконкам
                    title: 'Получать уведомления о новостях',
                    value: _newsNotifications,
                    onChanged: (value) {
                      setState(() {
                        _newsNotifications = value;
                      });
                    },
                  ),
                  Divider(color: Palette.stroke),
                  _SettingsSwitchTile(
                    iconPath: 'assets/icons/favourite.svg',
                    // Укажите правильные пути к иконкам
                    title: 'Новые события',
                    value: _eventNotifications,
                    onChanged: (value) {
                      setState(() {
                        _eventNotifications = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          // Кнопка сохранения "прилипает" к низу
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom,
                top: 24,
                left: 20,
                right: 20,
              ),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12),
                  ),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: LTButtons.elevatedButton(
                  onPressed: _isLoading ? null : _saveSettings,
                  child: _isLoading
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Palette.black,
                          ),
                        )
                      : Text(
                          'Сохранить',
                          style: Styles.button1,
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Переиспользуемый виджет для строки с переключателем
class _SettingsSwitchTile extends StatelessWidget {
  final String iconPath;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingsSwitchTile({
    required this.iconPath,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SvgPicture.asset(iconPath,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(Palette.black, BlendMode.srcIn)),
          const SizedBox(width: 12),
          Expanded(child: Text(title, style: Styles.b2)),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Palette.white,
            activeTrackColor: Palette.primaryLime,
            inactiveThumbColor: Palette.white,
            inactiveTrackColor: Palette.stroke,
          ),
        ],
      ),
    );
  }
}
