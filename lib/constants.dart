
class ServerPaths{

  /* Login */
  static const String IS_LOGGED_IN = "api/v1/logins/isLoggedIn";
  static const String LOG_IN_USER = "api/v1/logins/login";
  static const String LOG_IN_AS_GUEST = "api/v1/logins/loginAsGuest";
  static const String LOGOUT_USER = "api/v1/logins/logout";

  /* Account */
  static const String CREATE_ACCOUNT = "api/v1/accounts/create";
  static const String CONFIRM_ACCOUNT = "api/v1/accounts/confirm";
  static const String CHECK_AVAILABILITY = "api/v1/accounts/checkAvailability";
  static const String PASSWORD_RESET_REQUEST = "api/v1/accounts/passwordResetRequest";
  static const String PASSWORD_RESET_CONFIRM = "api/v1/accounts/passwordResetConfirm";
  static const String RESEND_CONFIRMATION_CODE = "api/v1/accounts/resendConfirmationCode";

  /* Preferences */
  static const String USER_PREFERENCES = "api/v1/preferences/getAccountPreferences";
  static const String TOGGLE_PREFERENCE = "api/v1/preferences/toggleAccountPreference";

  /* Book */
  static const String TOGGLE_BOOK_FOLLOW = "api/v1/books/toggleBookFollow";
  static const String ALL_BOOK_FOLLOWS = "api/v1/books/allBookFollows";
  static const String TRENDING_BOOKS = "api/v1/books/trendingBooks";
  static const String MY_BOOKS = "api/v1/books/getMyBooks";
  static const String CAN_EDIT_BOOK = "api/v1/books/canEditBook";
  static const String GET_BOOK = "api/v1/books/getBook";

  /* Chapters */
  static const String GET_READER_CHAPTERS = "api/v1/outlines/getReaderChapters";
  static const String GET_READER_CHAPTER = "api/v1/outlines/getReaderChapter";
  static const String GET_OUTLINE_HASH = "api/v1/outlines/getOutlineHash";

  /* Series */
  static const String SERIES_DETAILS = "api/v1/books/seriesDetails";

  /* Notes */
  static const String GET_BOOK_NOTES = "api/v1/book_notes/getBookNotes";
  static const String ADD_BOOK_NOTE = "api/v1/book_notes/addBookNote";
  static const String DELETE_BOOK_NOTE = "api/v1/book_notes/deleteBookNote";

  /* Log */
  static const String LOG_EVENT = "api/v1/events/logEvent";

}

class PubTypes {
  static const int Novel = 1;
  static const int Novella = 2;
}

class FontSizes {
  static const double DEFAULT_FONT_SIZE = 14;
  static const double DEFAULT_TITLE_SIZE = 18;
  static const double MIN_FONT_SIZE = 8;
  static const double MAX_FONT_SIZE = 40;
}

class EventTypes {
  static const int MESSAGE = 300;
  static const int USER_ACTION = 100;
  static const int ERROR = 200;
}