import 'dart:convert';
import 'package:mobi_reads/classes/IOFactory.dart';
import 'package:mobi_reads/entities/DefaultEntities.dart';
import 'package:mobi_reads/entities/RequestResult.dart';
import 'package:mobi_reads/entities/books/AllBookFollowsResponse.dart';
import 'package:mobi_reads/entities/books/ToggleBookFollowRequest.dart';
import 'package:mobi_reads/entities/books/ToggleBookFollowResponse.dart';
import '../server_paths.dart';

class BookRepository {

  Future<ToggleBookFollowResponse> toggleFollow(ToggleBookFollowRequest req) async {
    var response = await IOFactory.doPostWithBearer(urlExtension: ServerPaths.TOGGLE_BOOK_FOLLOW, data: req);
    if (response.statusCode == 200) {
      RequestResult<ToggleBookFollowResponse> result =  RequestResult<ToggleBookFollowResponse>.fromJson(jsonDecode(response.body), (data) => ToggleBookFollowResponse.fromJson(data as Map<String, dynamic>));
      if(result.Success)
        return result.Data ?? DefaultEntities.ErrorToggleFollowResponse;
      else
        throw Exception(result.Message);
    }

    throw Exception('Failed to Load Data');
  }

  Future<AllBookFollowsResponse> getAllBookFollows() async {
    var response = await IOFactory.doGetWithBearer(urlExtension: ServerPaths.ALL_BOOK_FOLLOWS);
    if (response.statusCode == 200) {
      RequestResult<AllBookFollowsResponse> result =  RequestResult<AllBookFollowsResponse>.fromJson(jsonDecode(response.body), (data) => AllBookFollowsResponse.fromJson(data as Map<String, dynamic>));
      if(result.Success)
        return result.Data ?? DefaultEntities.EmptyAllBookFollowsResponse;
      else
        throw Exception(result.Message);
    }

    throw Exception('Failed to Load Data');
  }

}
