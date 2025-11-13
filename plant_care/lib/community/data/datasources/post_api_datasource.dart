import 'dart:convert';
import 'package:http/http.dart' as http;

import '../dtos/post_dto.dart';

class PostApiDataSource {
  final String baseUrl;

  PostApiDataSource({required this.baseUrl});

  Future<List<PostDto>> getPosts() async {
    final url = Uri.parse("$baseUrl/api/community/posts");

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to load posts");
    }

    final List<dynamic> data = json.decode(response.body);

    return data.map((e) => PostDto.fromJson(e)).toList();
  }
}
