
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/create_account_bloc/create_account_bloc.dart';
import 'package:mobi_reads/blocs/create_account_bloc/create_account_event.dart';
import 'package:mobi_reads/blocs/create_account_bloc/create_account_state.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_widgets.dart';
import 'package:mobi_reads/repositories/account_repository.dart';
import 'package:mobi_reads/views/widgets/error_snackbar.dart';
import 'package:mobi_reads/views/widgets/standard_inputs.dart';

class CreateAccountPageWidget extends StatefulWidget {

  const CreateAccountPageWidget({Key? key}) : super(key: key);

  @override
  _CreateAccountPageWidgetState createState() => _CreateAccountPageWidgetState();
}

class _CreateAccountPageWidgetState extends State<CreateAccountPageWidget> {
  bool passwordVisibility = false;
  final _formKeyLogin = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
    passwordVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryColor,
      body: BlocProvider(
        create: (context) => CreateAccountBloc(RepositoryProvider.of<AccountRepository>(context)),
        child: BlocListener<CreateAccountBloc, CreateAccountState>(
          listener: (listenerContext, state){
            if (state.Status == CreateAccountStatus.CreateRequested) {
              _autoValidate = AutovalidateMode.always;
              if (_formKeyLogin.currentState!.validate()) {
                listenerContext.read<CreateAccountBloc>().add(CreateAccount());
              }
            }
            else if(state.Status == CreateAccountStatus.Error){
              ScaffoldMessenger.of(listenerContext).showSnackBar(
                  SnackBar(
                    content: ErrorSnackbar(message: state.ErrorMessage)),
                  );
            }
            else if(state.Status == CreateAccountStatus.Created){
              Navigator.pushNamedAndRemoveUntil(listenerContext, "/confirmAccount", (r) => false, arguments: state.Email);
            }
            else{
              _autoValidate = AutovalidateMode.disabled;
              _formKeyLogin.currentState!.validate();
            }
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryColor,
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: Image.asset(
                            'assets/images/mobireads_logo_4.png',
                          ).image,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryColor,
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Text(
                        'mobireads',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          color: FlutterFlowTheme.of(context).secondaryColor,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ),
                  Form(
                    key: _formKeyLogin,
                    autovalidateMode: _autoValidate,
                    child: BlocBuilder<CreateAccountBloc, CreateAccountState>(builder: (context, state) {
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          emailInput(context),
                          usernameInput(context),
                          passwordInput(context),
                          createAccountButton(context),
                          Divider(
                            height: 2,
                            thickness: 2,
                            indent: 20,
                            endIndent: 20,
                            color: FlutterFlowTheme.of(context).secondaryColor,
                          ),
                          cancelButton(),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }

  Widget emailInput(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: StandardInputs.getStandardTextInput(
                buildContext: context,
                hintText: 'Enter your email here...',
                onChanged: (value) => { context.read<CreateAccountBloc>().add(EmailChanged(value ?? ''))},
                validator: (value) => context.read<CreateAccountBloc>().state.IsEmailValid ? null : 'Invalid Email'
              )
          ),
        ],
      ),
    );
  }

  Widget passwordInput(BuildContext context){
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: StandardInputs.getStandardPasswordInput(
                buildContext: context,
                hintText: 'Enter your password here...',
                passwordVisibility: passwordVisibility,
                onChanged: (value) => context.read<CreateAccountBloc>().add(PasswordChanged(value ?? '')),
                onPasswordVisibilityTapped: () => setState( () => passwordVisibility = !passwordVisibility ),
                validator: (value) => context.read<CreateAccountBloc>().state.IsPasswordValid ? null : 'Invalid Password',
              )
          ),
        ],
      ),
    );
  }

  Widget usernameInput(BuildContext context){
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: StandardInputs.getStandardUsernameInput(
                buildContext: context,
                hintText: 'Enter your username here...',
                onChanged: (value) => { context.read<CreateAccountBloc>().add(UsernameChanged(value ?? ''))},
                validator: (value) => context.read<CreateAccountBloc>().state.IsUsernameValid ? null : 'Username Unavailable',
                isLoading: context.read<CreateAccountBloc>().state.Status == CreateAccountStatus.CheckingUserName,
                usernameNotAvailable: context.read<CreateAccountBloc>().state.UsernameNotAvailable,
                usernameConfirmed: context.read<CreateAccountBloc>().state.UsernameConfirmed,
              )
          ),
        ],
      ),
    );
  }

  Widget createAccountButton(BuildContext context) {
    if (context.read<CreateAccountBloc>().state.Status == CreateAccountStatus.Creating) {
      return Container(
          width: double.infinity,
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 25, 70, 28),
              child: SizedBox(
                child: CircularProgressIndicator(color: FlutterFlowTheme.of(context).secondaryColor),
                height: 25.0,
                width: 25.0,
              )
          )
      );
    }

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 16),
      child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FFButtonWidget(
          onPressed: () {
            context.read<CreateAccountBloc>().add(CreateAccountRequested());
          },
          text: 'Create',
          options: FFButtonOptions(
            width: 130,
            height: 50,
            color: FlutterFlowTheme.of(context).primaryColor,
            textStyle: FlutterFlowTheme.of(context).subtitle2.override(
              fontFamily: 'Poppins',
              color: FlutterFlowTheme.of(context).secondaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            elevation: 2,
            borderSide: BorderSide(
              color: FlutterFlowTheme.of(context).secondaryColor,
              width: 1,
            ),
            borderRadius: 8,
          ),
        ),
      ]),
    );
  }

  Widget cancelButton(){
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 12),
      child: FFButtonWidget(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false);
        },
        text: 'Cancel',
        options: FFButtonOptions(
          width: 170,
          height: 40,
          color: Color(0xD3FFFFFF),
          textStyle: FlutterFlowTheme.of(context).subtitle2.override(
            fontFamily: 'Poppins',
            color: Color(0xFF3C3925),
          ),
          elevation: 0,
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 1,
          ),
          borderRadius: 12,
        ),
      ),
    );
  }
}


