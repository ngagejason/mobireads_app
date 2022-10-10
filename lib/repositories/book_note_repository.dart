import 'dart:convert';
import 'package:mobi_reads/classes/IOFactory.dart';
import 'package:mobi_reads/constants.dart';
import 'package:mobi_reads/entities/DefaultEntities.dart';
import 'package:mobi_reads/entities/RequestResult.dart';
import 'package:mobi_reads/entities/RequestResults.dart';
import 'package:mobi_reads/entities/book_notes/AddBookNoteRequest.dart';
import 'package:mobi_reads/entities/book_notes/BookNote.dart';
import 'package:mobi_reads/entities/book_notes/DeleteBookNoteRequest.dart';
import 'package:mobi_reads/entities/bool_response/bool_response.dart';

class BookNoteRepository {
  Future<List<BookNote>> getBookNotes(String bookId) async {
    var response = await IOFactory.doGetWithBearer(urlExtension: ServerPaths.GET_BOOK_NOTES, args: {'bookId': bookId});
    if (response.statusCode == 200) {
      RequestResults<BookNote> result =  RequestResults<BookNote>.fromJson(jsonDecode(response.body), (data) => BookNote.fromJson(data as Map<String, dynamic>));
      if(result.Success)
        return result.Data ?? DefaultEntities.BookNotes;
      else
        throw Exception(result.Message);
    }
    throw Exception('Failed to Load Series');
  }

  Future<BoolResponse> addBookNote(AddBookNoteRequest req) async {
    var response = await IOFactory.doPostWithBearer(urlExtension: ServerPaths.ADD_BOOK_NOTE, data: req);
    if (response.statusCode == 200) {
      RequestResult<BoolResponse> result =  RequestResult<BoolResponse>.fromJson(jsonDecode(response.body), (data) => BoolResponse.fromJson(data as Map<String, dynamic>));
      if(result.Success)
        return result.Data ?? DefaultEntities.ErrorBoolResponse;
    }

    throw Exception('Error while adding note');
  }

  Future<List<BookNote>> deleteBookNote(DeleteBookNoteRequest req) async {
    var response = await IOFactory.doPostWithBearer(urlExtension: ServerPaths.DELETE_BOOK_NOTE, data: req);
    if (response.statusCode == 200) {
      RequestResults<BookNote> result =  RequestResults<BookNote>.fromJson(jsonDecode(response.body), (data) => BookNote.fromJson(data as Map<String, dynamic>));
      if(result.Success)
        return result.Data ?? DefaultEntities.BookNotes;
      else
        throw Exception(result.Message);
    }
    throw Exception('Failed to Load Series');
  }
}
