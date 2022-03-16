
class ServerPaths{

  /* Login */
  static String IS_LOGGED_IN = "api/logins/isLoggedIn";
  static String LOG_IN_USER = "api/logins/login";
  static String LOG_IN_AS_GUEST = "api/logins/loginAsGuest";
  static String LOGOUT_USER = "api/logins/logout";

  /* Account */
  static String CREATE_ACCOUNT = "api/accounts/create";
  static String CONFIRM_ACCOUNT = "api/accounts/confirm";
  static String CHECK_AVAILABILITY = "api/accounts/checkAvailability";
  static String PASSWORD_RESET_REQUEST = "api/accounts/passwordResetRequest";
  static String PASSWORD_RESET_CONFIRM = "api/accounts/passwordResetConfirm";

  /* User */
  static String USER_PREFERENCES = "api/preferences/getPreferences";
  static String TOGGLE_PREFERENCE = "api/preferences/togglePreference";

  /* Peek */
  static String GET_PEEKS = "api/peeks/getPeeks";

  /* Book */
  static String TOGGLE_BOOK_FOLLOW = "api/books/toggleBookFollow";
  static String ALL_BOOK_FOLLOWS = "api/books/allBookFollows";

}