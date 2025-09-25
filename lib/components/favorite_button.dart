import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/data/models/favorite.dart';
import 'package:ltfest/providers/favorites_provider.dart';

class FavoriteButton extends ConsumerWidget {
  final int id;
  final EventType eventType;

  const FavoriteButton({super.key, required this.id, required this.eventType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesState = ref.watch(favoritesProvider);

    switch (favoritesState) {
      case AsyncData<List<Favorite>>(:final value):
        final isFavorite = value.any(
              (event) => event.type == eventType.name && event.id == id,
        );

        print("$isFavorite / $id / ${eventType.name}");

        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                color: const Color(0x8E8A8A80),
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                icon: Icon(
                  size: 24,
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Palette.white,
                ),
                onPressed: () async {
                  final notifier = ref.read(favoritesProvider.notifier);
                  try {
                    if (isFavorite) {
                      await notifier.removeFavorite(eventType, id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Удалено из избранного')),
                      );
                    } else {
                      await notifier.addFavorite(eventType, id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Добавлено в избранное')),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Ошибка: $e')),
                    );
                  }
                },
              ),
            ),
          ),
        );

      case AsyncLoading():
        return SizedBox(
          height: 32,
          width: 32,
          child: CircularProgressIndicator(strokeWidth: 2, color: Palette.white),
        );

      case AsyncError(:final error):
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                color: const Color(0x8E8A8A80),
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(
                  size: 24,
                  Icons.error_outline,
                  color: Palette.white,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Ошибка загрузки: $error')),
                  );
                },
              ),
            ),
          ),
        );

      default:
        throw UnimplementedError('Unexpected favorites state: $favoritesState');
    }
  }
}

class FavoriteButtonDetails extends ConsumerWidget {
  final int id;
  final EventType eventType;
  final Color color;

  const FavoriteButtonDetails({super.key, required this.id, required this.eventType, required this.color});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesState = ref.watch(favoritesProvider);

    switch (favoritesState) {
      case AsyncData<List<Favorite>>(:final value):
        final isFavorite = value.any(
              (event) => event.type == eventType.name && event.id == id,
        );
        print("$isFavorite / $id / ${eventType.name}");

        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              height: 43,
              width: 43,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(
                  size: 24,
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Palette.white,
                ),
                onPressed: () async {
                  final notifier = ref.read(favoritesProvider.notifier);
                  try {
                    if (isFavorite) {
                      await notifier.removeFavorite(eventType, id);
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(content: Text('Удалено из избранного')),
                      // );
                    } else {
                      await notifier.addFavorite(eventType, id);
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(content: Text('Добавлено в избранное')),
                      // );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Ошибка: $e')),
                    );
                  }
                },
              ),
            ),
          ),
        );

      case AsyncLoading():
        return SizedBox(
          height: 43,
          width: 43,
          child: CircularProgressIndicator(strokeWidth: 2, color: Palette.white),
        );

      case AsyncError(:final error):
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              height: 43,
              width: 43,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(
                  size: 24,
                  Icons.error_outline,
                  color: Palette.white,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Ошибка загрузки: $error')),
                  );
                },
              ),
            ),
          ),
        );

      default:
        throw UnimplementedError('Unexpected favorites state: $favoritesState');
    }
  }
}