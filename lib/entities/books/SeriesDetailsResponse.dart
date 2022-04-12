// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';
import 'package:mobi_reads/entities/books/Book.dart';

part 'SeriesDetailsResponse.g.dart';

@JsonSerializable()
class SeriesDetailsResponse {

  @JsonKey(name: 'id')
  String Id;
  @JsonKey(name: 'title')
  String Title;
  @JsonKey(name: 'subtitle')
  String Subtitle;
  @JsonKey(name: 'bookCountInSeries')
  int BookCountInSeries;
  @JsonKey(name: 'genreId')
  String GenreId;
  @JsonKey(name: 'genreCode')
  int GenreCode;
  @JsonKey(name: 'genreName')
  String GenreName;
  @JsonKey(name: 'summary')
  String Summary;
  @JsonKey(name: 'books')
  List<Book> Books;

  SeriesDetailsResponse(this.Id, this.Title, this.Subtitle, this.BookCountInSeries, this.GenreId, this.GenreCode, this.GenreName, this.Summary, this.Books);

  factory SeriesDetailsResponse.fromJson(Map<String, dynamic> json) => _$SeriesDetailsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SeriesDetailsResponseToJson(this);
}