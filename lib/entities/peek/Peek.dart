import 'package:json_annotation/json_annotation.dart';

part 'Peek.g.dart';

@JsonSerializable()
class Peek {

  @JsonKey(name: 'title')
  String Title;
  @JsonKey(name: 'author')
  String Author;
  @JsonKey(name: 'genre')
  String Genre;
  @JsonKey(name: 'frontCoverImageUrl')
  String FrontCoverImageUrl;
  @JsonKey(name: 'followCount')
  int FollowCount;
  @JsonKey(name: 'summary')
  String Summary;
  @JsonKey(name: 'bookId')
  String BookId;
  @JsonKey(name: 'doesFollow')
  bool DoesFollow;

  Peek(this.Title, this.Author, this.Genre, this.FrontCoverImageUrl, this.FollowCount, this.Summary, this.BookId, this.DoesFollow);

  factory Peek.fromJson(Map<String, dynamic> json) => _$PeekFromJson(json);
  Map<String, dynamic> toJson() => _$PeekToJson(this);
}