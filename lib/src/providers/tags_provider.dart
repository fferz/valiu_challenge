import 'dart:convert';

import 'package:valiu_challenge/src/models/tag_model.dart';
import 'package:http/http.dart' as http;

class TagsProvider {
  final String _url = "http://127.0.0.1:3000/api";

  // Get all tags => GET /api/tags
  Future<List<TagModel>> getTags() async {
    final url = Uri.parse("$_url/tags");
    final response = await http.get(url);

    final decodedData = json.decode(response.body);
    print(decodedData);
    print('decodedData[data]: ${decodedData['data']}');

    final tagsList = fromJsonList(decodedData['data']);
    print('tags list: $tagsList');

    return tagsList;
  }

  // Create new tag => POST /api/tags
  Future<TagModel> newTag(TagModel tag) async {
    final url = Uri.parse("$_url/tags");
    final response = await http.post(url, body: tagModelToJson(tag));

    final decodedData = json.decode(response.body);
    print(decodedData);

    return decodedData;
  }

  // Edit tag => PUT /api/tags/:id
  Future<TagModel> editTag(TagModel tag) async {
    final url = Uri.parse("$_url/tags/:${tag.id}");
    final response = await http.put(url, body: tagModelToJson(tag));

    final decodedData = json.decode(response.body);
    print(decodedData);

    return decodedData;
  }

  // Delete tag => DELETE /api/:id
  Future<TagModel> deleteTag(String id) async {
    final url = Uri.parse("$_url/tags/:$id");
    final response = await http.delete(url);

    final decodedData = json.decode(response.body);
    print(decodedData);

    return decodedData;
  }
}
