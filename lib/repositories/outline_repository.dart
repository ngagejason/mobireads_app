import 'dart:convert';
import 'package:mobi_reads/classes/IOFactory.dart';
import 'package:mobi_reads/constants.dart';
import 'package:mobi_reads/entities/DefaultEntities.dart';
import 'package:mobi_reads/entities/RequestResult.dart';
import 'package:mobi_reads/entities/bool_response/bool_response.dart';
import 'package:mobi_reads/entities/outline_chapters/OutlineChapter.dart';
import 'package:mobi_reads/entities/outline_chapters/OutlineChaptersResponse.dart';
import 'package:mobi_reads/entities/outline_chapters/OutlineHash.dart';
import 'package:mobi_reads/entities/outline_chapters/OutlineHashResponse.dart';

class OutlineRepository {
  Future<OutlineChaptersResponse> getChapters(String bookId) async {
    var response = await IOFactory.doGetWithBearer(urlExtension: ServerPaths.GET_READER_CHAPTERS, args: { 'bookId': bookId });
    if (response.statusCode == 200) {
      RequestResult<OutlineChaptersResponse> result =  RequestResult<OutlineChaptersResponse>.fromJson(jsonDecode(response.body), (data) => OutlineChaptersResponse.fromJson(data as Map<String, dynamic>));
      if(result.Success)
        return result.Data ?? DefaultEntities.Chapters;
      else
        throw Exception(result.Message);
    }

    throw Exception('Failed to load chapters');
  }

  Future<OutlineChapter> getChapter(String chapterId) async {
    var response = await IOFactory.doGetWithBearer(urlExtension: ServerPaths.GET_READER_CHAPTER, args: { 'chapterId': chapterId });
    if (response.statusCode == 200) {
      RequestResult<OutlineChapter> result =  RequestResult<OutlineChapter>.fromJson(jsonDecode(response.body), (data) => OutlineChapter.fromJson(data as Map<String, dynamic>));
      if(result.Success)
        return result.Data ?? new OutlineChapter(chapterId, 'Error', 'Error', 0, null, '');
      else
        throw Exception(result.Message);
    }

    throw Exception('Failed to load chapters');
  }

  Future<OutlineHashResponse> getOutlineHash(String bookId) async {
    var response = await IOFactory.doGetWithBearer(urlExtension: ServerPaths.GET_OUTLINE_HASH, args: { 'bookId': bookId });
    if (response.statusCode == 200) {
      RequestResult<OutlineHashResponse> result =  RequestResult<OutlineHashResponse>.fromJson(jsonDecode(response.body), (data) => OutlineHashResponse.fromJson(data as Map<String, dynamic>));
      if(result.Success)
        return result.Data ?? new OutlineHashResponse([]);
      else
        throw Exception(result.Message);
    }

    throw Exception('Failed to load chapters');
  }
}
