import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareButton extends StatelessWidget {
  final String link;
  final Color color;

  const ShareButton({
    super.key,
    required this.link,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(
              Icons.share_outlined,
              size: 24,
              color: Colors.white,
            ),
            onPressed: () {
              SharePlus.instance.share(
                ShareParams(uri: Uri.parse(link)),
              );
            },
          ),
        ),
      ),
    );
  }
}
