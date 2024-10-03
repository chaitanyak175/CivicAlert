import 'package:civicalert/apis/comment_api.dart';
import 'package:civicalert/core/utils.dart';
import 'package:civicalert/features/auth/controller/auth_controller.dart';
import 'package:civicalert/models/comment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commentControllerProvider =
    StateNotifierProvider<CommentController, bool>((ref) {
  return CommentController(
    ref: ref,
    commentAPI: ref.watch(commentAPIProvider),
  );
});

final fetchReplyCountProvider =
    FutureProvider.family<int, String>((ref, repliedToId) async {
  final replyCount = await ref
      .watch(commentControllerProvider.notifier)
      .fetchReplyCount(repliedToId);
  return replyCount;
});

final getCommentsProvider = Provider((ref) {
  final commentController =
      ref.watch(commentControllerProvider.notifier).getComments();
  return commentController;
});

final getCommentsForComplainProvider =
    FutureProvider.family((ref, String complainId) {
  final commentController = ref.watch(commentControllerProvider.notifier);
  return commentController.getCommentsForComplain(complainId);
});

final getLatestCommentsProvider = Provider((ref) {
  final commentAPI = ref.watch(commentAPIProvider);
  return commentAPI.getLatestComments();
});

class CommentController extends StateNotifier<bool> {
  final Ref _ref;
  final CommentAPI _commentAPI;

  CommentController({required Ref ref, required CommentAPI commentAPI})
      : _ref = ref,
        _commentAPI = commentAPI,
        super(false);

  Future<List<CommentModel>> getComments() async {
    final commentList = await _commentAPI.getComments();
    return commentList
        .map((commentModel) => CommentModel.fromMap(commentModel.data))
        .toList();
  }

  Future<List<CommentModel>> getCommentsForComplain(String complainId) async {
    final commentList = await _commentAPI.getComments();
    return commentList
        .map((commentModel) => CommentModel.fromMap(commentModel.data))
        .where((comment) => comment.repliedTo == complainId)
        .toList();
  }

  void uploadComment({
    required String commentText,
    required BuildContext context,
    required String repliedTo,
  }) {
    if (commentText.isEmpty) {
      showSnackBar(context, 'Please Enter the Comment');
    } else {
      _uploadComment(
        commentText: commentText,
        context: context,
        repliedTo: repliedTo,
      );
    }
  }

  void _uploadComment({
    required String commentText,
    required BuildContext context,
    required String repliedTo,
  }) async {
    state = true;
    final user = _ref.watch(currentUserDetailsProvider).value!;
    CommentModel comment = CommentModel(
      commentText: commentText,
      uid: user.uid,
      commentedAt: DateTime.now(),
      repliedTo: repliedTo,
    );
    final res = await _commentAPI.uploadComments(comment);
    state = false;
    res.fold(
      (l) => showSnackBar(context, l.message),
      // (r) => null,
      (r) => Navigator.pop(context),
    );
  }

  Future<int> fetchReplyCount(String repliedTo) async {
    final replyCount = await _commentAPI.getReplyCount(repliedTo);
    return replyCount;
  }
}
