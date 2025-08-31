import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants.dart';
import '../../data/models/ltstory.dart';
import '../data/models/image_data.dart';

class StoryViewer extends StatefulWidget {
  final List<LTStory> stories;
  final int initialIndex;

  const StoryViewer({
    super.key,
    required this.stories,
    required this.initialIndex,
  });

  @override
  StoryViewerState createState() => StoryViewerState();
}

class StoryViewerState extends State<StoryViewer> {
  late PageController _pageController;
  late List<StoryController> _storyControllers;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
    // Initialize a StoryController for each story group
    _storyControllers = List.generate(
      widget.stories.length,
          (index) => StoryController(),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (var controller in _storyControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // Function to open a URL
  Future<void> _launchURL(String urlString) async {
    final Uri uri = Uri.parse(urlString);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Не удалось открыть ссылку: $urlString')),
      );
    }
  }

  // Build StoryView for a single story group
  Widget _buildStoryView(LTStory story, StoryController controller, int storyIndex) {
    final List<ImageData> mediaItems = story.media!;
    final List<StoryItem> storyItems = mediaItems.map((mediaItem) {
      final mediaUrl = 'http://37.46.132.144:1337${mediaItem.url}';
      final bool isVideo = mediaItem.mime.startsWith('video/');

      if (isVideo) {
        return StoryItem.pageVideo(
          mediaUrl,
          controller: controller,
          caption: const Text(
            "",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              backgroundColor: Colors.black54,
              fontFamily: 'Mulish',
            ),
          ),
        );
      } else {
        return StoryItem.pageImage(
          url: mediaUrl,
          controller: controller,
          caption: const Text(
            "",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              backgroundColor: Colors.black54,
              fontFamily: 'Mulish',
            ),
          ),
          duration: const Duration(seconds: 5),
        );
      }
    }).toList();

    final bool hasLink = story.url != null && story.url!.isNotEmpty;

    return Stack(
      children: [
        StoryView(
          storyItems: storyItems,
          controller: controller,
          onComplete: () {
            // Move to the next story group if available
            if (_currentIndex < widget.stories.length - 1) {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            } else {
              Navigator.pop(context);
            }
          },
          onStoryShow: (storyItem, index) {
            print("Показывается сторис №$index из группы '${story.title}'");
          },
          onVerticalSwipeComplete: (direction) {
            if (direction == Direction.down) {
              Navigator.pop(context);
            }
          },
          progressPosition: ProgressPosition.top,
          repeat: false,
          inline: false,
          indicatorColor: Palette.gray,
          indicatorForegroundColor: Palette.primaryLime,
        ),
        if (hasLink)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 20 + MediaQuery.of(context).padding.bottom,
              ),
              width: double.infinity,
              child: LTButtons.elevatedButton(
                onPressed: () {
                  controller.pause();
                  _launchURL(story.url!).then((_) {
                    controller.play();
                  });
                },
                child: Text('Подробнее', style: Styles.button1),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.stories.length,
        onPageChanged: (index) {
          // Pause the previous story controller and play the new one
          if (_currentIndex != index) {
            _storyControllers[_currentIndex].pause();
            _storyControllers[index].play();
            setState(() {
              _currentIndex = index;
            });
          }
        },
        itemBuilder: (context, index) {
          return _buildStoryView(
            widget.stories[index],
            _storyControllers[index],
            index,
          );
        },
      ),
    );
  }
}