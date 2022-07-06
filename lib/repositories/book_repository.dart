import 'dart:convert';
import 'package:mobi_reads/classes/IOFactory.dart';
import 'package:mobi_reads/constants.dart';
import 'package:mobi_reads/entities/DefaultEntities.dart';
import 'package:mobi_reads/entities/RequestResult.dart';
import 'package:mobi_reads/entities/books/AllBookFollowsResponse.dart';
import 'package:mobi_reads/entities/books/Book.dart';
import 'package:mobi_reads/entities/books/SeriesDetailsResponse.dart';
import 'package:mobi_reads/entities/books/ToggleBookFollowRequest.dart';
import 'package:mobi_reads/entities/books/ToggleBookFollowResponse.dart';
import 'package:mobi_reads/entities/books/TrendingBooksResponse.dart';
import 'package:mobi_reads/entities/bool_response/bool_response.dart';

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
      RequestResult<TrendingBooksResponse> result =  RequestResult<TrendingBooksResponse>.fromJson(jsonDecode(response.body), (data) => TrendingBooksResponse.fromJson(data as Map<String, dynamic>));
      if(result.Success)
        return result.Data ?? DefaultEntities.ErrorTrendingBooksResponse;
      else
        throw Exception(result.Message);
    }

    throw Exception('Failed to Load Data');
  }

  Future<TrendingBooksResponse> getMyBooks() async {
    var response = await IOFactory.doGetWithBearer(urlExtension: ServerPaths.MY_BOOKS);
    if (response.statusCode == 200) {
      RequestResult<TrendingBooksResponse> result =  RequestResult<TrendingBooksResponse>.fromJson(jsonDecode(response.body), (data) => TrendingBooksResponse.fromJson(data as Map<String, dynamic>));
      if(result.Success)
        return result.Data ?? DefaultEntities.ErrorTrendingBooksResponse;
      else
        throw Exception(result.Message);
    }

    throw Exception('Failed to Load Data');
  }

  Future<BoolResponse> canEditBook(String bookId) async {
    if(bookId.length == 0){
      return BoolResponse(false, '');
    }

    var response = await IOFactory.doGetWithBearer(urlExtension: ServerPaths.CAN_EDIT_BOOK, args: {'bookId': bookId.toString()});
    if (response.statusCode == 200) {
      try{
        RequestResult<BoolResponse> result =  RequestResult<BoolResponse>.fromJson(jsonDecode(response.body), (data) => BoolResponse.fromJson(data as Map<String, dynamic>));
        if(result.Success)
          return result.Data ?? DefaultEntities.ErrorBoolResponse;
        else
          throw Exception(result.Message);
      }
      on Exception catch (e) {
        print(e.toString());
        throw e;
      }
    }

    throw Exception('Failed to Load Data');
  }

  Future<SeriesDetailsResponse> getSeriesDetails(String? seriesId) async {
    var response = await IOFactory.doGetWithBearer(urlExtension: ServerPaths.SERIES_DETAILS, args: {'seriesId': seriesId.toString()});
    if (response.statusCode == 200) {
      RequestResult<SeriesDetailsResponse> result =  RequestResult<SeriesDetailsResponse>.fromJson(jsonDecode(response.body), (data) => SeriesDetailsResponse.fromJson(data as Map<String, dynamic>));
      if(result.Success)
        return result.Data ?? DefaultEntities.EmptySeriesDetailsResponse;
      else
        throw Exception(result.Message);
    }

    throw Exception('Failed to Load Series');
  }

  Future<Book> getBook(String bookId) async {
    var response = await IOFactory.doGetWithBearer(urlExtension: ServerPaths.GET_BOOK, args: {'bookId': bookId});
    if (response.statusCode == 200) {
      RequestResult<Book> result =  RequestResult<Book>.fromJson(jsonDecode(response.body), (data) => Book.fromJson(data as Map<String, dynamic>));
      if(result.Success)
        return result.Data ?? DefaultEntities.EmptyBook;
      else
        throw Exception(result.Message);
    }

    throw Exception('Failed to Load Series');
  }
}
