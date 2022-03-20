// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
part 'Book.g.dart';

@JsonSerializable()
class Book {

  @JsonKey(name: 'id')
  String Id;
  @JsonKey(name: 'genreId')
  String GenreId;
  @JsonKey(name: 'title')
  String Title;
  @JsonKey(name: 'subtitle')
  String? Subtitle;
  @JsonKey(name: 'frontCoverImageUrl')
  String FrontCoverImageUrl;
  @JsonKey(name: 'backCoverImageUrl')
  String? BackCoverImageUrl;
  @JsonKey(name: 'wordCount')
  int WordCount;
  @JsonKey(name: 'authorFirstName')
  String AuthorFirstName;
  @JsonKey(name: 'authorLastName')
  String AuthorLastName;
  @JsonKey(name: 'authorMiddleName')
  String? AuthorMiddleName;
  @JsonKey(name: 'genreCode')
  int GenreCode;
  @JsonKey(name: 'genreName')
  String GenreName;
  @JsonKey(name: 'followCount')
  int FollowCount;
  @JsonKey(name: 'summary')
  String Summary;
  @JsonKey(name: 'additionalImages')
  List<String>? AdditionalImages;

  Book(this.Id,
      this.GenreId,
      this.Title,
      this.Subtitle,
      this.FrontCoverImageUrl,
      this.BackCoverImageUrl,
      this.WordCount,
      this.AuthorFirstName,
      this.AuthorLastName,
      this.AuthorMiddleName,
      this.GenreCode,
      this.GenreName,
      this.FollowCount,
      this.Summary,
      this.AdditionalImages);

  String AuthorName() {
    if(AuthorMiddleName == null || AuthorMiddleName!.isEmpty){
      return AuthorFirstName + ' ' + AuthorLastName;
    }

    return AuthorFirstName + ' ' + AuthorMiddleName! + ' ' + AuthorLastName;
  }

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
  Map<String, dynamic> toJson() => _$BookToJson(this);

}