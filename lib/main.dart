import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mobi_reads/blocs/book_follows_bloc/book_follows_bloc.dart';
import 'package:mobi_reads/blocs/preferences_bloc/preferences_bloc.dart';
import 'package:mobi_reads/repositories/account_repository.dart';
import 'package:mobi_reads/repositories/book_repository.dart';
import 'package:mobi_reads/repositories/login_repository.dart';
import 'package:mobi_reads/repositories/peek_repository.dart';
import 'package:mobi_reads/views/configure_page.dart';
import 'package:mobi_reads/views/confirm_account/confirm_account_page.dart';
import 'package:mobi_reads/views/create_account/create_account_page.dart';
import 'package:mobi_reads/views/login/login_page.dart';
import 'package:mobi_reads/views/master_scaffold/master_scaffold_widget.dart';
import 'package:mobi_reads/views/password_reset_confirm/password_reset_confirm_page.dart';
import 'package:mobi_reads/views/password_reset_request/password_reset_request_page.dart';
import 'package:mobi_reads/views/user_home/user_home_widget.dart';
import 'blocs/app_bloc/app_bloc.dart';
import 'repositories/preferences_repository.dart';

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
        RepositoryProvider(create: (context) => PeekRepository()),
        RepositoryProvider(create: (context) => BookRepository())
      ],
      child: appUI(),
    );
  }

  Widget appUI(){

    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>(create: (context) => AppBloc(RepositoryProvider.of<LoginRepository>(context))),
//        BlocProvider<PeekBloc>(create: (context) => PeekBloc(RepositoryProvider.of<PeekRepository>(context))),
        BlocProvider<PreferencesBloc>(create: (context) => PreferencesBloc(RepositoryProvider.of<PreferencesRepository>(context))),
        BlocProvider<BookFollowsBloc>(create: (context) => BookFollowsBloc(RepositoryProvider.of<BookRepository>(context))),
//        BlocProvider<ConfirmAccountBloc>(create:(context) => ConfirmAccountBloc(RepositoryProvider.of<AccountRepository>(context), '')),
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
          }),
    );
  }
}

