// lib/pages/reference_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/components/lt_appbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ltfest/components/share_button.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/router/app_routes.dart';

class ReferencePage extends ConsumerStatefulWidget {
  final String title;

  final String imageAsset;
  final String shareLink;
  final List<Widget> contentBlocks;
  final String? ctaLabel;
  final VoidCallback? onCtaPressed;
  final String? telegramLink;

  const ReferencePage({
    super.key,
    required this.title,
    required this.imageAsset,
    required this.shareLink,
    required this.contentBlocks,
    this.ctaLabel,
    this.onCtaPressed,
    this.telegramLink,
  });

  @override
  ConsumerState<ReferencePage> createState() => _ReferencePageState();
}

class _ReferencePageState extends ConsumerState<ReferencePage> {
  final ScrollController _scrollController = ScrollController();
  bool _showHeader = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 320 && !_showHeader) {
        setState(() => _showHeader = true);
      } else if (_scrollController.offset <= 320 && _showHeader) {
        setState(() => _showHeader = false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _openTelegram() async {
    if (widget.telegramLink != null) {
      final uri = Uri.parse(widget.telegramLink!);
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(12),
                  ),
                  child: Image.asset(
                    widget.imageAsset,
                    height: 360,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SafeArea(
                  child: Column(
                    children: [
                      LTAppBar(
                        title: widget.title,
                        postfixWidget: ShareButton(
                            link: widget.shareLink, color: Palette.primaryLime),
                      ),
                      SizedBox(
                          height: 270 - MediaQuery.of(context).padding.top),
                      ...widget.contentBlocks,
                      SizedBox(height: widget.ctaLabel != null ? 82 : 8),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: AnimatedOpacity(
              opacity: _showHeader ? 1 : 0,
              duration: const Duration(milliseconds: 200),
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                  bottom: 16,
                ),
                decoration: BoxDecoration(
                  color: Palette.background,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                child: LTAppBar(
                  title: widget.title,
                  postfixWidget: Row(
                    children: [
                      ShareButton(
                        link: "https://ltfest.ru",
                        color: Palette.primaryLime,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (widget.ctaLabel != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.fromLTRB(
                  16,
                  16,
                  16,
                  MediaQuery.of(context).padding.bottom + 16,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: LTButtons.elevatedButton(
                  onPressed: widget.telegramLink != null
                      ? _openTelegram
                      : widget.onCtaPressed ??
                          () => context.push(AppRoutes.more),
                  child: Text(widget.ctaLabel!, style: Styles.button1),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

Widget buildTextBlock({required String title, required String text}) {
  return Container(
    decoration: Decor.base,
    margin: const EdgeInsets.symmetric(horizontal: 4),
    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Styles.h2),
        const SizedBox(height: 24),
        Text(text, style: Styles.b1),
      ],
    ),
  );
}

Widget buildStepsBlock(
    {required List<Map<String, String>> steps, required String stepsTitle}) {
  return Container(
    decoration: Decor.base,
    margin: const EdgeInsets.symmetric(horizontal: 4),
    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(stepsTitle, style: Styles.h3),
        const SizedBox(height: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < steps.length; i++)
              Column(
                children: [
                  _StepTile(
                    title: steps[i]['title']!,
                    subtitle: steps[i]['subtitle']!,
                  ),
                  if (i < steps.length - 1) const SizedBox(height: 8),
                ],
              ),
          ],
        ),
      ],
    ),
  );
}

class _StepTile extends StatelessWidget {
  final String title;
  final String subtitle;

  const _StepTile({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.background,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Styles.h4),
          const SizedBox(height: 8),
          Text(subtitle, style: Styles.b1),
        ],
      ),
    );
  }
}

class FaqItem extends StatefulWidget {
  final String question;
  final String answer;

  const FaqItem({super.key, required this.question, required this.answer});

  @override
  State<FaqItem> createState() => _FaqItemState();
}

class _FaqItemState extends State<FaqItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: Decor.base,
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        childrenPadding: EdgeInsets.zero,
        backgroundColor: Colors.white,
        collapsedBackgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        collapsedShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Text(widget.question, style: Styles.h4),
        trailing: Icon(
          _expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
          color: Palette.black,
        ),
        onExpansionChanged: (v) => setState(() => _expanded = v),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(widget.answer, style: Styles.b2),
          ),
        ],
      ),
    );
  }
}
