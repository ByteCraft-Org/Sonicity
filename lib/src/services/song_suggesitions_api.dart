import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sonicity/src/models/models.dart';

class SongSuggestionsApi {
  static Future<Map> _apiCall(String id, int limit) async {
    final uri = "https://saavn.dev/api/songs/$id/suggestions?limit=$limit";
    final response = await http.get(Uri.parse(uri));
    if(response.statusCode != 200) {
      "Search Playlist Api\nStatus Code : ${response.statusCode}\nMessage : ${jsonDecode(response.body)['message']}".printError();
      return {};
    }
    final data = jsonDecode(response.body);
    return data;
  }

  static Future<List<Song>> fetchData(String id, {required int limit}) async {
    Map result = await _apiCall(id, 10);
    if(result['data'] == null) {
      return [];
    }
    List<Song> songs = [];
    for (var element in result['data']['results']) {
      songs.add(Song.forPlay(element));
    }
    return songs;
  }
}