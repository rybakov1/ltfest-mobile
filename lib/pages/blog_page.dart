import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
// import '../models/post.dart';
// import '../providers/post_provider.dart';
import '../constants.dart';

class BlogPage extends ConsumerStatefulWidget {
  const BlogPage({super.key});

  @override
  ConsumerState<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends ConsumerState<BlogPage> {
  get postsAsync => null;


  @override
  Widget build(BuildContext context) {
    // final postsAsync = ref.watch(postsProvider(limit: 50));

    return Scaffold(
      backgroundColor: Palette.black,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Блог",
                      style: Styles.h3.copyWith(color: Palette.white),
                    ),
                  ],
                ),
              ),
            ),
            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 4.0),
            //     child: Container(
            //       decoration: Decor.base,
            //       child: postsAsync.when(
            //         data: (posts) {
            //           if (posts.isEmpty) {
            //             return Padding(
            //               padding: const EdgeInsets.all(16.0),
            //               child: Center(
            //                 child: Text(
            //                   'Посты не найдены',
            //                   style: TextStyle(color: Palette.black),
            //                 ),
            //               ),
            //             );
            //           }
            //           return ListView.builder(
            //             shrinkWrap: true,
            //             physics: const NeverScrollableScrollPhysics(),
            //             padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
            //             itemCount: posts.length,
            //             itemBuilder: (context, index) {
            //               final post = posts[index];
            //               return Column(
            //                 children: [
            //                   _buildPostCard(
            //                     context: context,
            //                     post: post,
            //                   ),
            //                   if (index < posts.length - 1) const SizedBox(height: 32),
            //                   if (index == posts.length - 1) const SizedBox(height: 20),
            //                 ],
            //               );
            //             },
            //           );
            //         },
            //         loading: () => const Padding(
            //           padding: EdgeInsets.all(16.0),
            //           child: Center(child: CircularProgressIndicator()),
            //         ),
            //         error: (error, stack) => Padding(
            //           padding: const EdgeInsets.all(16.0),
            //           child: Center(
            //             child: Column(
            //               children: [
            //                 Text(
            //                   'Ошибка: $error',
            //                   style: TextStyle(color: Palette.black),
            //                 ),
            //                 const SizedBox(height: 16),
            //                 ElevatedButton(
            //                   onPressed: () => null, //ref.refresh(postsProvider(limit: 50)),
            //                   child: const Text('Попробовать снова'),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // const SliverToBoxAdapter(child: SizedBox(height: 4)),
          ],
        ),
      ),
    );
  }

  // Widget _buildPostCard({
  //   required BuildContext context,
  //   required Post post,
  // }) {
  //   return GestureDetector(
  //     onTap: () async {
  //       final uri = Uri.parse(post.link);
  //       await launchUrl(uri, mode: LaunchMode.externalApplication);
  //     },
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         if (post.imageUrl != null)
  //           ClipRRect(
  //             borderRadius: BorderRadius.circular(12),
  //             child: Image.network(
  //               post.imageUrl!,
  //               height: 150,
  //               width: double.infinity,
  //               fit: BoxFit.cover,
  //             ),
  //           ),
  //         if (post.imageUrl != null) const SizedBox(height: 12),
  //         Text(
  //           post.title,
  //           style: Styles.h4,
  //         ),
  //         if (post.description != null) ...[
  //           const SizedBox(height: 8),
  //           Text(
  //             post.description!,
  //             style: Styles.b2.copyWith(color: Palette.gray),
  //             maxLines: 3,
  //             overflow: TextOverflow.ellipsis,
  //           ),
  //         ],
  //         const SizedBox(height: 8),
  //         Text(
  //           DateFormat('dd MMM yyyy, HH:mm').format(post.createdAt.toLocal()),
  //           style: Styles.b2.copyWith(color: Palette.gray),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}