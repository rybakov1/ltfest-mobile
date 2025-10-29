import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/providers/favorites_provider.dart';

class FavoriteButton extends ConsumerWidget {
  final int id;
  final EventType type;
  final double blur;
  final Color color;
  final double size;

  const FavoriteButton({
    super.key,
    required this.id,
    required this.type,
    required this.color,
    this.blur = 10,
    this.size = 32,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    final notifier = ref.read(favoritesProvider.notifier);

    final isFavorite = favorites.maybeWhen(
      data: (value) => value.any(
        (f) => f.type == type.name && f.id == id,
      ),
      orElse: () => false,
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Palette.white,
              size: 24,
            ),
            onPressed: () async {
              try {
                await notifier.toggleFavorite(type, id);
              } catch (e) {
                print(e);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Ошибка при изменении избранного')),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
