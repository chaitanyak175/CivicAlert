import 'package:civicalert/constants/appbar_constants.dart';
import 'package:civicalert/constants/appwrite_constants.dart';
import 'package:civicalert/features/complain/controller/comment_controller.dart';
import 'package:civicalert/features/complain/widgets/commented_user_card.dart';
import 'package:civicalert/features/complain/widgets/complain_reply_view_card.dart';
import 'package:civicalert/models/comment_model.dart';
import 'package:civicalert/models/complain_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComplainReplyView extends ConsumerWidget {
  static route(ComplainModel complain) => MaterialPageRoute(
      builder: (context) => ComplainReplyView(
            complain: complain,
          ));
  final ComplainModel complain;
  const ComplainReplyView({
    super.key,
    required this.complain,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppbarConstants.complaintReplyViewAppbar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ComplainReplyViewCard(complain: complain),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  'Comments',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Gilroy',
                    fontSize: 22,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CommentList(complainId: complain.id),
            ],
          ),
        ),
      ),
    );
  }
}

class CommentList extends ConsumerWidget {
  final String complainId;

  const CommentList({super.key, required this.complainId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getCommentsForComplainProvider(complainId)).when(
          data: (initialComments) {
            return StreamBuilder(
              stream: ref.watch(getLatestCommentsProvider),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final realtimeData = snapshot.data!;
                  if (realtimeData.events.contains(
                    'databases.*.collections.${AppwriteConstants.commentsCollections}.documents.*.create',
                  )) {
                    final newComment =
                        CommentModel.fromMap(realtimeData.payload);
                    if (newComment.repliedTo == complainId) {
                      initialComments.insert(0, newComment);
                    }
                  } else if (realtimeData.events.contains(
                    'databases.*.collections.${AppwriteConstants.commentsCollections}.documents.*.update',
                  )) {
                    final startingPoint =
                        realtimeData.events[0].lastIndexOf('documents.');
                    final endPoint =
                        realtimeData.events[0].lastIndexOf('.update');
                    final commentId = realtimeData.events[0]
                        .substring(startingPoint + 10, endPoint);

                    final commentIndex = initialComments.indexWhere(
                        (comment) => comment.repliedTo == commentId);
                    if (commentIndex != -1) {
                      initialComments[commentIndex] =
                          CommentModel.fromMap(realtimeData.payload);
                    }
                  }
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: initialComments.length,
                  itemBuilder: (context, index) {
                    return CommentCard(comment: initialComments[index]);
                  },
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
        );
  }
}
