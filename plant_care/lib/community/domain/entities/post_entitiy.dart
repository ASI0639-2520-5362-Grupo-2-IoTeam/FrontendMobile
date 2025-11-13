class PostEntity {
  final int id;
  final String title;
  final String content;
  final String authorId;
  final DateTime createdAt;
  final bool highlighted;

  const PostEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.authorId,
    required this.createdAt,
    required this.highlighted,
  });
}
