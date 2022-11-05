import 'dart:convert';
import 'package:mobi_reads/classes/IOFactory.dart';
import 'package:mobi_reads/constants.dart';
import 'package:mobi_reads/entities/DefaultEntities.dart';
import 'package:mobi_reads/entities/RequestResult.dart';
import 'package:mobi_reads/entities/bool_response/bool_response.dart';
import 'package:mobi_reads/entities/outline_chapters/OutlineChaptersResponse.dart';

class OutlineRepository {
  Future<OutlineChaptersResponse> getChapters(String bookId, int chapterOffset, int chapterCount) async {
    var response = await IOFactory.doGetWithBearer(urlExtension: ServerPaths.GET_CHAPTERS, args: {'chapterOffset': chapterOffset.toString(), 'chapterCount' : chapterCount.toString(), 'bookId': bookId });
    if (response.statusCode == 200) {
      RequestResult<OutlineChaptersResponse> result =  RequestResult<OutlineChaptersResponse>.fromJson(jsonDecode(response.body), (data) => OutlineChaptersResponse.fromJson(data as Map<String, dynamic>));
      if(result.Success)
        return result.Data ?? DefaultEntities.Chapters;
      else
        throw Exception(result.Message);
    }

    throw Exception('Failed to load chapters');
  }

  Future<BoolResponse> resetLastPoll(String bookId) async {
    var response = await IOFactory.doGetWithBearer(urlExtension: ServerPaths.RESET_LAST_POLL, args: { 'bookId': bookId });
    if (response.statusCode == 200) {
      RequestResult<BoolResponse> result =  RequestResult<BoolResponse>.fromJson(jsonDecode(response.body), (data) => BoolResponse.fromJson(data as Map<String, dynamic>));
      if(result.Success)
        return result.Data ?? DefaultEntities.ErrorBoolResponse;
      else
        throw Exception(result.Message);
    }

    throw Exception('Failed to reset last poll');
  }
}
