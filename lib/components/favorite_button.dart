import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/constants.dart';

import '../providers/favorites_provider.dart';

enum EventType { festival, laboratory }

mixin Favoritable {
  int get favoriteId;

  EventType get favoriteType;
}

class FavoriteButton extends ConsumerWidget {
  final Favoritable item;

  const FavoriteButton({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref
        .watch(favoriteProvider)
        .contains('${item.favoriteType.name}-${item.favoriteId}');

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10.0,
          sigmaY: 10.0,
        ),
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
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Palette.white,
            ),
            onPressed: () {
              ref.read(favoriteProvider.notifier).toggle(item, context);
            },
          ),
        ),
      ),
    );
  }
}


class FavoriteButtonDetails extends ConsumerWidget {
  final Favoritable item;

  const FavoriteButtonDetails({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref
        .watch(favoriteProvider)
        .contains('${item.favoriteType.name}-${item.favoriteId}');

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10.0,
          sigmaY: 10.0,
        ),
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
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Palette.white,
            ),
            onPressed: () {
              ref.read(favoriteProvider.notifier).toggle(item, context);
            },
          ),
        ),
      ),
    );
  }
}
