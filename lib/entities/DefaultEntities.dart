import 'package:mobi_reads/entities/books/AllBookFollowsResponse.dart';
import 'package:mobi_reads/entities/books/Book.dart';
import 'package:mobi_reads/entities/books/ToggleBookFollowResponse.dart';
import 'package:mobi_reads/entities/books/TrendingBooksResponse.dart';
import 'package:mobi_reads/entities/bool_response/bool_response.dart';
import 'package:mobi_reads/entities/login/LoginUserResponse.dart';
import 'package:mobi_reads/entities/preferences/PreferenceChip.dart';
import 'package:mobi_reads/entities/preferences/PreferencesResponse.dart';

class DefaultEntities {
  static const GenericErrorMessage = 'An error has occurred';

  static final ErrorLoginUserResponse = LoginUserResponse('', '', '', '', false, 'User not logged in', true);
  static final ErrorBoolResponse = BoolResponse(false, GenericErrorMessage);
  static final Preferences = PreferencesResponse(List<PreferenceChip>.empty(growable: false));
  static final ErrorTrendingBooksResponse = TrendingBooksResponse(List<Book>.empty(growable: false), 0);
  static final ErrorToggleFollowResponse = ToggleBookFollowResponse(false, false, 'An error has occurred.');
  static final EmptyBook = Book('','','', '', '', '', 0, '','','',0,'',0,'', []);
  static final EmptyAllBookFollowsResponse = AllBookFollowsResponse(List.empty(growable: false));
}