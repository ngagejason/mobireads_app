// ignore_for_file: non_constant_identifier_names
import 'package:mobi_reads/entities/DefaultEntities.dart';
import 'package:mobi_reads/entities/books/Book.dart';
import 'package:mobi_reads/entities/books/SeriesDetailsResponse.dart';

enum BookSeriesDetailsStatus {
  Constructed,
  BookSeriesDetailsLoading,
  BookSeriesDetailsLoaded,
  Loaded,
  Error
}

class BookSeriesDetailsState {

  String Id;
  String Title;
  String Subtitle;
  int BookCountInSeries;
  int GenreCode;
  String GenreName;
  String Summary;
  List<Book> Books;
  final BookSeriesDetailsStatus Status;

  BookSeriesDetailsState ({
    this.Id = '',
    this.Title = '',
    this.Subtitle = '',
    this.BookCountInSeries = 0,
    this.GenreCode = 0,
    this.GenreName = '',
    this.Summary = '',
    this.Books = const[],
    this.Status = BookSeriesDetailsStatus.Constructed });

  BookSeriesDetailsState CopyWith({
    String? id,
    String? title,
    String? subtitle,
    int? bookCountInSeries,
    int? genreCode,
    String? genreName,
    String? summary,
    List<Book>? books,
    BookSeriesDetailsStatus? status }) {
    return BookSeriesDetailsState(
      Id: id ?? this.Id,
      Title: title ?? this.Title,
      Subtitle : subtitle ?? this.Subtitle,
      BookCountInSeries : bookCountInSeries ?? this.BookCountInSeries,
      GenreCode : genreCode ?? this.GenreCode,
      GenreName : genreName ?? this.GenreName,
      Summary : summary ?? this.Summary,
      Books: books ?? this.Books,
      Status: status ?? this.Status
    );
  }
}