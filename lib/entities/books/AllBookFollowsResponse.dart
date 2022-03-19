// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
import 'package:mobi_reads/entities/books/Book.dart';

part 'AllBookFollowsResponse.g.dart';

@JsonSerializable()
class AllBookFollowsResponse {

  @JsonKey(name: 'followedBooks')
  List<Book>? FollowedBooks;

  AllBookFollowsResponse(this.FollowedBooks);

  factory AllBookFollowsResponse.fromJson(Map<String, dynamic> json) => _$AllBookFollowsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AllBookFollowsResponseToJson(this);
}