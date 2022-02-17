
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ExceptionFormatter {

  static FormatException(Exception exception) {

    if((dotenv.env['SERVER_BASE'] ?? '') == 'dev'){
      return exception.toString();
    }

    return 'An error has occurred';
  }
}