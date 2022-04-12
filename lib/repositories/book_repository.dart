import 'dart:convert';
import 'package:mobi_reads/classes/IOFactory.dart';
import 'package:mobi_reads/constants.dart';
import 'package:mobi_reads/entities/DefaultEntities.dart';
import 'package:mobi_reads/entities/RequestResult.dart';
import 'package:mobi_reads/entities/books/AllBookFollowsResponse.dart';
import 'package:mobi_reads/entities/books/SeriesDetailsResponse.dart';
import 'package:mobi_reads/entities/books/ToggleBookFollowRequest.dart';
import 'package:mobi_reads/entities/books/ToggleBookFollowResponse.dart';
import 'package:mobi_reads/entities/books/TrendingBooksResponse.dart';

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

  Future<TrendingBooksResponse> getTrendingBooks(int code) async {
    var response = await IOFactory.doGetWithBearer(urlExtension: ServerPaths.TRENDING_BOOKS, args: {'code': code.toString()});
    if (response.statusCode == 200) {
      try{
        RequestResult<TrendingBooksResponse> result =  RequestResult<TrendingBooksResponse>.fromJson(jsonDecode(response.body), (data) => TrendingBooksResponse.fromJson(data as Map<String, dynamic>));
        if(result.Success)
          return result.Data ?? DefaultEntities.ErrorTrendingBooksResponse;
        else
          throw Exception(result.Message);
      }
      on Exception catch (e) {
        print(e.toString());
      }
    }

    throw Exception('Failed to Load Data');
  }

  Future<SeriesDetailsResponse> getSeriesDetails(String? seriesId) async {
    var response = await IOFactory.doGetWithBearer(urlExtension: ServerPaths.SERIES_DETAILS, args: {'seriesId': seriesId.toString()});
    if (response.statusCode == 200) {
      try{
        RequestResult<SeriesDetailsResponse> result =  RequestResult<SeriesDetailsResponse>.fromJson(jsonDecode(response.body), (data) => SeriesDetailsResponse.fromJson(data as Map<String, dynamic>));
        if(result.Success)
          return result.Data ?? DefaultEntities.EmptySeriesDetailsResponse;
        else
          throw Exception(result.Message);
      }
      on Exception catch (e) {
        print(e.toString());
      }
    }

    throw Exception('Failed to Load Series');
  }
}
