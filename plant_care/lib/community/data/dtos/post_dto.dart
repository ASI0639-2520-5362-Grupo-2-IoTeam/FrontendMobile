import '../../domain/entities/post_entity.dart';

class PostDto {
  final int id;
  final String title;
  final String content;
  final String authorId;
  final DateTime createdAt;
  final bool highlighted;

  PostDto({
    required this.id,
    required this.title,
    required this.content,
    required this.authorId,
    required this.createdAt,
    required this.highlighted,
  });

  factory PostDto.fromJson(Map<String, dynamic> json) => PostDto(
    id: json['id'],
    title: json['title'],
    content: json['content'],
    authorId: json['authorId'],
    createdAt: DateTime.parse(json['createdAt']),
    highlighted: json['highlighted'],
  );

  /// 👇 ESTE MÉTODO ES NECESARIO
  PostEntity toEntity() => PostEntity(
    id: id,
    title: title,
    content: content,
    authorId: authorId,
    createdAt: createdAt,
    highlighted: highlighted,
  );
}
