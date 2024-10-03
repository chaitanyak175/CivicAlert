class CommentModel {
  final String commentText;
  final String uid;
  final DateTime commentedAt;
  final String repliedTo;
  CommentModel({
    required this.commentText,
    required this.uid,
    required this.commentedAt,
    required this.repliedTo,
  });

  CommentModel copyWith({
    String? commentText,
    String? uid,
    DateTime? commentedAt,
    String? repliedTo,
  }) {
    return CommentModel(
      commentText: commentText ?? this.commentText,
      uid: uid ?? this.uid,
      commentedAt: commentedAt ?? this.commentedAt,
      repliedTo: repliedTo ?? this.repliedTo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'commentText': commentText,
      'uid': uid,
      'commentedAt':
          commentedAt.millisecondsSinceEpoch ~/ 1000, // Convert to seconds,
      'repliedTo': repliedTo,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      commentText: map['commentText'] ?? '',
      uid: map['uid'] ?? '',
      commentedAt: DateTime.fromMillisecondsSinceEpoch(map['commentedAt'] *
          1000), // Convert from seconds back to milliseconds
      repliedTo: map['repliedTo'] ?? '',
    );
  }

  @override
  String toString() =>
      'CommentModel(commentText:$commentText, uid: $uid, commentedAt: $commentedAt, repliedTo: $repliedTo)';

  @override
  bool operator ==(covariant CommentModel other) {
    if (identical(this, other)) return true;

    return other.commentText == commentText &&
        other.uid == uid &&
        other.commentedAt == commentedAt &&
        other.repliedTo == repliedTo;
  }

  @override
  int get hashCode =>
      commentText.hashCode ^
      uid.hashCode ^
      commentedAt.hashCode ^
      repliedTo.hashCode;
}
