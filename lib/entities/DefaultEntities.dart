import 'package:mobi_reads/entities/books/AllBookFollowsResponse.dart';
import 'package:mobi_reads/entities/books/ToggleBookFollowRequest.dart';
import 'package:mobi_reads/entities/books/ToggleBookFollowResponse.dart';
import 'package:mobi_reads/entities/bool_response/bool_response.dart';
import 'package:mobi_reads/entities/login/LoginUserResponse.dart';
import 'package:mobi_reads/entities/peek/Peek.dart';
import 'package:mobi_reads/entities/peek/PeekResponse.dart';
import 'package:mobi_reads/entities/preferences/PreferenceChip.dart';
import 'package:mobi_reads/entities/preferences/PreferencesResponse.dart';

class DefaultEntities {
  static const GenericErrorMessage = 'An error has occurred';

  static final ErrorLoginUserResponse = LoginUserResponse('', '', '', '', false, 'User not logged in', true);
  static final ErrorBoolResponse = BoolResponse(false, GenericErrorMessage);
  static final Preferences = PreferencesResponse(List<PreferenceChip>.empty(growable: false));
  static final ErrorPeekResponse = PeekResponse(List<Peek>.empty(growable: false), 0);
  static final ErrorToggleFollowResponse = ToggleBookFollowResponse(false, false, 'An error has occurred.');
  static final EmptyPeek = Peek('', '', '', '', 0, '', '', false);
  static final EmptyAllBookFollowsResponse = AllBookFollowsResponse(List.empty(growable: false));
}