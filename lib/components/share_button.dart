import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareButton extends StatelessWidget {
  final String link;

  const ShareButton({
    super.key,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
