import 'package:mobi_reads/entities/bool_response/bool_response.dart';
import 'package:mobi_reads/entities/login/LoginUserResponse.dart';

class DefaultEntities {
  static const GenericErrorMessage = 'An error has occurred';

  static final ErrorLoginUserResponse = LoginUserResponse('', '', '', '', false, 'User not logged in', true);
  static final ErrorBoolResponse = BoolResponse(false, GenericErrorMessage);
}