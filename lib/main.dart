import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mobi_reads/blocs/book_follows_bloc/book_follows_bloc.dart';
import 'package:mobi_reads/blocs/preferences_bloc/preferences_bloc.dart';
import 'package:mobi_reads/blocs/reader_bloc/reader_bloc.dart';
import 'package:mobi_reads/repositories/account_repository.dart';
import 'package:mobi_reads/repositories/book_note_repository.dart';
import 'package:mobi_reads/repositories/book_repository.dart';
import 'package:mobi_reads/repositories/outline_repository.dart';
import 'package:mobi_reads/repositories/login_repository.dart';
import 'package:mobi_reads/views/add_book_note/add_book_note_master.dart';
import 'package:mobi_reads/views/book_details/book_details_master.dart';
import 'package:mobi_reads/views/book_series_details/book_series_details_master.dart';
import 'package:mobi_reads/views/configure_page.dart';
import 'package:mobi_reads/views/confirm_account/confirm_account_page.dart';
import 'package:mobi_reads/views/create_account/create_account_page.dart';
import 'package:mobi_reads/views/login/login_page.dart';
import 'package:mobi_reads/views/master_scaffold/master_scaffold_widget.dart';
import 'package:mobi_reads/views/book_notes/book_notes_master.dart';
import 'package:mobi_reads/views/password_reset_confirm/password_reset_confirm_page.dart';
import 'package:mobi_reads/views/password_reset_request/password_reset_request_page.dart';
import 'blocs/app_bloc/app_bloc.dart';
import 'repositories/preferences_repository.dart';
import 'package:flutter/services.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  ThemeMode _themeMode = ThemeMode.system;

  void setLocale(Locale value) => setState(() => _locale = value);
  void setThemeMode(ThemeMode mode) => setState(() {
    _themeMode = mode;
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => LoginRepository()),
        RepositoryProvider(create: (context) => AccountRepository()),
        RepositoryProvider(create: (context) => PreferencesRepository()),
        RepositoryProvider(create: (context) => BookRepository()),
        RepositoryProvider(create: (context) => OutlineRepository()),
        RepositoryProvider(create: (context) => BookNoteRepository()),
      ],
      child: appUI(),
    );
  }

  Widget appUI(){

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>(create: (context) => AppBloc(RepositoryProvider.of<LoginRepository>(context))),
        BlocProvider<PreferencesBloc>(create: (context) => PreferencesBloc(RepositoryProvider.of<PreferencesRepository>(context))),
        BlocProvider<BookFollowsBloc>(create: (context) => BookFollowsBloc(RepositoryProvider.of<BookRepository>(context))),
        BlocProvider<ReaderBloc>(create: (context) => ReaderBloc(RepositoryProvider.of<OutlineRepository>(context), RepositoryProvider.of<BookRepository>(context))),
        ],
      child: MaterialApp(
          title: 'MobiReads',
          supportedLocales: const [Locale('en', '')],
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: _locale,
          theme: ThemeData(brightness: Brightness.light),
          darkTheme: ThemeData(brightness: Brightness.dark),
          routes: {
            '/': (context) => ConfigurePage(),
            '/login': (context) => LoginPageWidget(),
            '/userHome': (context) => MasterScaffoldWidget(),
            '/createAccount': (context) => CreateAccountPageWidget(),
            '/confirmAccount': (context) => ConfirmAccountPageWidget(),
            '/passwordResetRequest': (context) => PasswordResetRequestWidget(),
            '/passwordResetConfirm': (context) => PasswordResetConfirmWidget(),
            '/bookDetails': (context) => BookDetailsMasterWidget(),
            '/bookSeriesDetails': (context) => BookSeriesDetailsMasterWidget(),
            '/bookNotes': (context) => BookNotesMasterWidget(),
            '/addBookNote': (context) => AddBookNoteMasterWidget()
          }),
    );
  }
}

