import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobi_reads/blocs/app_bloc/app_bloc.dart';
import 'package:mobi_reads/blocs/app_bloc/app_event.dart';
import 'package:mobi_reads/blocs/app_bloc/app_state.dart';
import 'package:mobi_reads/repositories/login_repository.dart';
import 'package:mobi_reads/views/login/login_page.dart';
import 'package:mobi_reads/views/user_home/user_home_widget.dart';
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
        loginRepo.isLoggedIn()
            .then((authUser) {
                if (authUser.Success) {
                  appBloc.add(UserLoggedInEvent(authUser.Id, authUser.Email, authUser.Username, authUser.Bearer, true));
                }
                else {
                  appBloc.add(UserLoggedOutEvent());
                }

                appBloc.add(AppInitializedEvent());

                setState(() {
                  isInitialized = true;
                });
                },
            onError:(error, stackTrace) {
              print(error);
              print('here!!!!!!!!!!!!!!!');
              appBloc.add(AppInitializedEvent());
              setState(() {
                isInitialized = true;
              });
            });
      }
      else {
        setState(() {
          isInitialized = true;
        });
      }
    });
  }

  errorOccurred(){

  }

  @override
  Widget build(BuildContext context){
    if(!isInitialized){
      return LoadingPage();
    }

    AppBloc appBloc = context.read<AppBloc>();
    if(appBloc.state.IsLoggedIn){
      return UserHomeWidget();
    }

    return LoginPageWidget();
  }
}