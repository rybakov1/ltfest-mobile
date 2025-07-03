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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.black,
        appBar: AppBar(
          backgroundColor: Palette.black,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Palette.black),
            style: IconButton.styleFrom(backgroundColor: Palette.primaryLime),
            onPressed: () => context.pop(),
          ),
          title: Text('Настройки приложения',
              style: Styles.h3.copyWith(color: Palette.white)),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(4, 16, 4, 0),
                decoration: Decor.base,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
            const SizedBox(height: 1), // TODO:
            // Кнопка сохранения "прилипает" к низу
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      topLeft: Radius.circular(8)),
                  color: Colors.white),
              child: SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveSettings,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Palette.primaryLime,
                    foregroundColor: Palette.black,
                    disabledBackgroundColor:
                        Palette.primaryLime.withValues(alpha: 0.5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isLoading
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child:
                              CircularProgressIndicator(color: Palette.black))
                      : Text('Сохранить', style: Styles.button1),
                ),
              ),
            ),
          ],
        ),
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
