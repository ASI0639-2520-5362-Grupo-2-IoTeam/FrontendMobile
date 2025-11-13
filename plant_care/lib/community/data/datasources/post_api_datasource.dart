import 'dart:convert';
import 'package:http/http.dart' as http;
import '../dtos/post_dto.dart';

class PostApiDataSource {
  final String baseUrl;

  PostApiDataSource(this.baseUrl);

  // GET POSTS
  Future<void> createPost({
    required String token,
    required String userId,
    required String title,
    required String content,
    required String species,
    required String tag,
  }) async {
    final url = Uri.parse("$baseUrl/api/community/posts").replace(
      queryParameters: {
        "userId": userId,
        "title": title,
        "content": content,
        "species": species,
        "tag": tag,
      },
    );

    final resp = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    print("Create POST status => ${resp.statusCode}");
    print("Create POST body => ${resp.body}");

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      throw Exception("Error creating post: ${resp.statusCode}");
    }
  }

  Future<bool> registerMember(String userId, String token) async {
    final url = Uri.parse(
        "$baseUrl/api/community/members/register?userId=$userId");

    final resp = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    print("Register status => ${resp.statusCode}");
    print("Register body => ${resp.body}");

    return resp.statusCode == 200;
  }

  Future<List<PostDto>> getPosts(String token) async {
    final url = Uri.parse("$baseUrl/api/community/posts");

    final resp = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (resp.statusCode != 200) {
      throw Exception("Error GET posts: ${resp.statusCode}");
    }

    final List jsonList = jsonDecode(resp.body);
    return jsonList.map((e) => PostDto.fromJson(e)).toList();
  }
}
