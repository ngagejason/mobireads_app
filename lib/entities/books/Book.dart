// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison

import 'package:json_annotation/json_annotation.dart';

import '../preferences/Preference.dart';
part 'Book.g.dart';

@JsonSerializable()
class Book {

  @JsonKey(name: 'id')
  String Id;
  @JsonKey(name: 'title')
  String Title;
  @JsonKey(name: 'subtitle')
  String Subtitle;
  @JsonKey(name: 'frontCoverImageUrl')
  String FrontCoverImageUrl;
  @JsonKey(name: 'frontCoverImageMimeType')
  String FrontCoverImageMimeType;
  @JsonKey(name: 'backCoverImageUrl')
  String? BackCoverImageUrl;
  @JsonKey(name: 'backCoverImageMimeType')
  String BackCoverImageMimeType;
  @JsonKey(name: 'authorFirstName')
  String AuthorFirstName = '';
  @JsonKey(name: 'authorMiddleName')
  String? AuthorMiddleName;
  @JsonKey(name: 'authorLastName')
  String AuthorLastName = '';
  @JsonKey(name: 'summary')
  String Summary = '';
  @JsonKey(name: 'status')
  int Status = 0;
  @JsonKey(name: 'version')
  int Version = 0;
  @JsonKey(name: 'wordCount')
  int WordCount = 0;
  @JsonKey(name: 'chapterCount')
  int ChapterCount = 0;
  @JsonKey(name: 'followCount')
  int FollowCount = 0;
  @JsonKey(name: 'seriesId')
  String? SeriesId = '';
  @JsonKey(name: 'seriesTitle')
  String SeriesTitle = '';
  @JsonKey(name: 'seriesSubtitle')
  String SeriesSubtitle = '';
  @JsonKey(name: 'bookCountInSeries')
  int BookCountInSeries = 0;
  @JsonKey(name: 'bookNumberInSeries')
  int BookNumberInSeries = 0;
  @JsonKey(name: 'seriesFrontCoverUrls')
  List<String> SeriesFrontCoverUrls = [];
  @JsonKey(name: 'preferences')
  List<Preference> Preferences = [];

  Book(this.Id,
      this.Title,
      this.Subtitle,
      this.FrontCoverImageUrl,
      this.FrontCoverImageMimeType,
      this.BackCoverImageUrl,
      this.BackCoverImageMimeType,
      String? authorFirstName,
      String? authorMiddleName,
      String? authorLastName,
      String? summary,
      this.Status,
      this.Version,
      this.WordCount,
      this.ChapterCount,
      this.FollowCount,
      this.SeriesId,
      this.SeriesTitle,
      this.SeriesSubtitle,
      this.BookCountInSeries,
      this.BookNumberInSeries,
      this.SeriesFrontCoverUrls,
      this.Preferences)
  {
    this.AuthorFirstName = authorFirstName ?? '';
    this.AuthorMiddleName = authorMiddleName ?? '';
    this.AuthorLastName = authorLastName ?? '';
    this.Summary = summary ?? '';
  }

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