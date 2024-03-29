// ignore_for_file: non_constant_identifier_names
import 'package:mobi_reads/entities/book_notes/BookNote.dart';
import 'package:mobi_reads/entities/books/AllBookFollowsResponse.dart';
import 'package:mobi_reads/entities/books/Book.dart';
import 'package:mobi_reads/entities/books/SeriesDetailsResponse.dart';
import 'package:mobi_reads/entities/books/ToggleBookFollowResponse.dart';
import 'package:mobi_reads/entities/books/TrendingBooksResponse.dart';
import 'package:mobi_reads/entities/bool_response/bool_response.dart';
import 'package:mobi_reads/entities/outline_chapters/OutlineChapter.dart';
import 'package:mobi_reads/entities/outline_chapters/OutlineChaptersResponse.dart';
import 'package:mobi_reads/entities/login/LoginUserResponse.dart';
import 'package:mobi_reads/entities/preferences/Preference.dart';
import 'package:mobi_reads/entities/preferences/PreferencesResponse.dart';

class DefaultEntities {
  static const GenericErrorMessage = 'An error has occurred';

  static final ErrorLoginUserResponse = LoginUserResponse('', '', '', '', false, 'User not logged in', true);
  static final ErrorBoolResponse = BoolResponse(false, GenericErrorMessage);
  static final Preferences = PreferencesResponse(List<Preference>.empty(growable: false));
  static final ErrorTrendingBooksResponse = TrendingBooksResponse(List<Book>.empty(growable: false), 0);
  static final ErrorToggleFollowResponse = ToggleBookFollowResponse(false, false, 'An error has occurred.');
  static final EmptyBook = Book('','','', '', '', '', '', '', '', '', '', 0, 0, 0, 0, 0, []);
  static final EmptyAllBookFollowsResponse = AllBookFollowsResponse(List.empty(growable: false));
  static final EmptySeriesDetailsResponse = SeriesDetailsResponse('', '', '', 0, '', 0, '', '', []);
  static final Chapters = OutlineChaptersResponse(List<OutlineChapter>.empty(growable: false));
  static final BookNotes = List<BookNote>.empty(growable: false);
}