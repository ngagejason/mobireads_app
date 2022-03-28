
class ServerPaths{

  /* Login */
  static const String IS_LOGGED_IN = "api/logins/isLoggedIn";
  static const String LOG_IN_USER = "api/logins/login";
  static const String LOG_IN_AS_GUEST = "api/logins/loginAsGuest";
  static const String LOGOUT_USER = "api/logins/logout";

  /* Account */
  static const String CREATE_ACCOUNT = "api/accounts/create";
  static const String CONFIRM_ACCOUNT = "api/accounts/confirm";
  static const String CHECK_AVAILABILITY = "api/accounts/checkAvailability";
  static const String PASSWORD_RESET_REQUEST = "api/accounts/passwordResetRequest";
  static const String PASSWORD_RESET_CONFIRM = "api/accounts/passwordResetConfirm";

  /* User */
  static const String USER_PREFERENCES = "api/preferences/getPreferences";
  static const String TOGGLE_PREFERENCE = "api/preferences/togglePreference";

  /* Book */
  static const String TOGGLE_BOOK_FOLLOW = "api/books/toggleBookFollow";
  static const String ALL_BOOK_FOLLOWS = "api/books/allBookFollows";
  static const String TRENDING_BOOKS = "api/books/trendingBooks";

}

class PubTypes {
  static const int Novel = 1;
  static const int Novella = 2;
}