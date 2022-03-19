// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
import 'package:mobi_reads/entities/books/Book.dart';

part 'TrendingBooksResponse.g.dart';

@JsonSerializable()
class TrendingBooksResponse {

  @JsonKey(name: 'displayType')
  int DisplayType;
  @JsonKey(name: 'books')
  List<Book>? Books;

  TrendingBooksResponse(this.Books, this.DisplayType);

  factory TrendingBooksResponse.fromJson(Map<String, dynamic> json) => _$TrendingBooksResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TrendingBooksResponseToJson(this);
}