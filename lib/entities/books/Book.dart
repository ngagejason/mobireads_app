// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison

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
  String Subtitle;
  @JsonKey(name: 'frontCoverImageUrl')
  String FrontCoverImageUrl;
  @JsonKey(name: 'backCoverImageUrl')
  String? BackCoverImageUrl;
  @JsonKey(name: 'wordCount')
  int WordCount = 0;
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
  int FollowCount = 0;
  @JsonKey(name: 'summary')
  String Summary = '';
  @JsonKey(name: 'additionalImages')
  List<String>? AdditionalImages = [];
  @JsonKey(name: 'pubType')
  int PubType = 1;
  @JsonKey(name: 'seriesId')
  String? SeriesId = '';
  @JsonKey(name: 'seriesTitle')
  String SeriesTitle = '';
  @JsonKey(name: 'seriesSubtitle')
  String SeriesSubtitle = '';
  @JsonKey(name: 'bookNumberInSeries')
  int BookNumberInSeries = 0;
  @JsonKey(name: 'bookCountInSeries')
  int BookCountInSeries = 0;
  @JsonKey(name: 'seriesFrontCoverUrls')
  List<String> SeriesFrontCoverUrls = [];
  @JsonKey(name: 'version')
  int Version = 1;
  @JsonKey(name: 'status')
  int Status = 0;

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
      this.AdditionalImages,
      this.PubType,
      this.SeriesId,
      this.SeriesTitle,
      this.SeriesSubtitle,
      this.BookNumberInSeries,
      this.BookCountInSeries,
      this.SeriesFrontCoverUrls,
      this.Version,
      this.Status);

  String AuthorName() {
    if(AuthorMiddleName == null || AuthorMiddleName!.isEmpty){
      return AuthorFirstName + ' ' + AuthorLastName;
    }

    return AuthorFirstName + ' ' + AuthorMiddleName! + ' ' + AuthorLastName;
  }

  bool ContainsText(String text){
    if(text.trim().length == 0){
      return true;
    }
    return
      Title.toUpperCase().contains(text) ||
          (Subtitle != null && Subtitle.toUpperCase().contains(text)) ||
          (SeriesTitle != null && SeriesTitle.toUpperCase().contains(text)) ||
          (SeriesSubtitle != null && SeriesSubtitle.toUpperCase().contains(text));
  }

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
  Map<String, dynamic> toJson() => _$BookToJson(this);

}