import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobi_reads/blocs/app_bloc/app_bloc.dart';
import 'package:mobi_reads/blocs/app_bloc/app_event.dart';
import 'package:mobi_reads/blocs/app_bloc/app_state.dart';
import 'package:mobi_reads/classes/UserSecureStorage.dart';
import 'package:mobi_reads/constants.dart';
import 'package:mobi_reads/entities/login/LoginUserResponse.dart';
import 'package:mobi_reads/repositories/event_log_repository.dart';
import 'package:mobi_reads/repositories/login_repository.dart';
import 'package:mobi_reads/views/login/login_page.dart';
import 'package:mobi_reads/views/master_scaffold/master_scaffold_widget.dart';
import '../entities/events/EventLogRequest.dart';
import 'loading_page.dart';

class ConfigurePage extends StatefulWidget {
  ConfigurePage() : super();

  @override
  ConfigurePageState createState() => ConfigurePageState();
}

class ConfigurePageState extends State<ConfigurePage> {
  bool isInitialized = false;

  @override
  initState() {
    super.initState();
    AppBloc appBloc = context.read<AppBloc>();
    LoginRepository authRepo = RepositoryProvider.of<LoginRepository>(context);
    _initializeApp(appBloc, authRepo);
  }

  _initializeApp(AppBloc appBloc, LoginRepository loginRepo) {
    dotenv.load(fileName: ".env").then((value) {
      if (appBloc.state.Status == AppStatus.Initializing) {
        setIsLoggedIn(appBloc, loginRepo);
      }
      else {
        setInitialized();
      }
    },
    onError:(error, stackTrace) {
      print(error);
      EventLogRepository.shared.logEvent(new EventLogRequest(EventTypes.ERROR, "configure_page", "_initializeApp", error.toString())).then((value) {
        appBloc.add(UserLoggedOutEvent());
        setInitialized();
      });
    });
  }

  @override
  Widget build(BuildContext context){
    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      if(!isInitialized){
        return LoadingPage();
      }

      AppBloc appBloc = context.read<AppBloc>();
      if(appBloc.state.Status == AppStatus.LoggedIn){
        return MasterScaffoldWidget();
      }
      else if(appBloc.state.Status == AppStatus.LoggedOut){
        return LoginPageWidget();
      }

      return
        LoadingPage();
    });
  }

  void setIsLoggedIn(AppBloc appBloc, LoginRepository loginRepo){
    loginRepo.isLoggedIn().then((authUser) {
      if (authUser.Success) {
        setBearerToken(appBloc, authUser);
      }
      else {
        appBloc.add(UserLoggedOutEvent());
        setInitialized();
      }
    },
    onError:(error, stackTrace) {
      print(error);
      EventLogRepository.shared.logEvent(new EventLogRequest(EventTypes.ERROR, "configure_page", "_initializeApp", error.toString())).then((value) {
        appBloc.add(UserLoggedOutEvent());
        setInitialized();
      });
    });
  }

  void setBearerToken(AppBloc appBloc, LoginUserResponse authUser){
    UserSecureStorage.setBearerToken(authUser.Bearer).then((value) {
      appBloc.add(UserLoggedInEvent(authUser.Id, authUser.Email, authUser.Username));
      setInitialized();
    },
    onError:(error, stackTrace) {
      print(error);
      EventLogRepository.shared.logEvent(new EventLogRequest(EventTypes.ERROR, "configure_page", "_initializeApp", error.toString())).then((value) {
        appBloc.add(UserLoggedOutEvent());
        setInitialized();
      });
    });
  }

  void setInitialized(){
    setState(() {
      isInitialized = true;
    });
  }
}