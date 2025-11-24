import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/components/story_viewer.dart';
import 'package:shimmer/shimmer.dart';
import '../constants.dart';
import '../providers/story_provider.dart';

class StoryWidget extends ConsumerWidget {
  final String category;

  const StoryWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storiesAsync = ref.watch(storyProvider(category));

    return SizedBox(
      height: 96,
      child: storiesAsync.when(
        data: (stories) => stories.isEmpty
            ? Center(
                child: Text(
                  'Нет доступных сторис',
                  style: TextStyle(
                    color: Palette.gray,
                    fontFamily: 'Mulish',
                  ),
                ),
              )
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: stories.length,
                itemBuilder: (context, index) {
                  final story = stories[index];
                  return _buildStoryPreview(
                    imageUrl:
                        'http://37.46.132.144:1337${story.preview!.formats?.thumbnail?.url}',
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                          builder: (context) => StoryViewer(
                            stories: stories, // Pass the full list of stories
                            initialIndex:
                                index, // Pass the index of the tapped story
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
        loading: () => _buildStoriesLoading(), // Shimmer
        error: (error, stack) => Center(
          child: Text(
            'Ошибка загрузки сторис: $error',
            style: TextStyle(
              color: Palette.gray,
              fontFamily: 'Mulish',
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStoryPreview({
    required String imageUrl,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(width: 1.5, color: Palette.primaryLime),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: imageUrl.startsWith('http')
                  ? Image.network(
                      imageUrl,
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        'assets/images/ex.png',
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Image.asset(
                      imageUrl,
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStoriesLoading() {
    return Shimmer.fromColors(
      baseColor: Palette.shimmerBase,
      highlightColor: Palette.shimmerHighlight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0),
          child: Container(
            width: 96,
            height: 96,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
        ),
      ),
    );
  }
}
