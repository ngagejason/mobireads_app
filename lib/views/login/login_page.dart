import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/app_bloc/app_bloc.dart';
import 'package:mobi_reads/blocs/app_bloc/app_event.dart';
import 'package:mobi_reads/blocs/login_bloc/login_bloc.dart';
import 'package:mobi_reads/blocs/login_bloc/login_event.dart';
import 'package:mobi_reads/blocs/login_bloc/login_state.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_widgets.dart';
import 'package:mobi_reads/repositories/login_repository.dart';
import 'package:mobi_reads/views/widgets/error_snackbar.dart';
import 'package:mobi_reads/views/widgets/standard_inputs.dart';


class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({Key? key}) : super(key: key);

  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
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
          create: (context) => LoginBloc(RepositoryProvider.of<LoginRepository>(context)),
          child:  BlocListener<LoginBloc, LoginState>(
            listener: (listenerContext, state){
              if (state.Status == LoginStatus.LoginRequested) {
                _autoValidate = AutovalidateMode.always;
                if (_formKeyLogin.currentState!.validate()) {
                  listenerContext.read<LoginBloc>().add(Login());
                }
              }
              else if(state.Status == LoginStatus.Error){
                ScaffoldMessenger.of(listenerContext).showSnackBar(
                  SnackBar(
                      content: ErrorSnackbar(header: "Oops", message: state.ErrorMessage)),
                );
              }
              else if(state.Status == LoginStatus.LoggedIn && state.Login != null){
                listenerContext.read<AppBloc>().add(UserLoggedInEvent(state.Login!.Id, state.Login!.Email, state.Login!.Username, state.Login!.Bearer, state.Login!.IsGuest));
                listenerContext.read<LoginBloc>().add(RedirectToHome(state.Login!.Id));
              }
              else if(state.Status == LoginStatus.RedirectToHome){
                Navigator.pushNamedAndRemoveUntil(context, "/userHome", (r) => false);
              }
              else{
                _autoValidate = AutovalidateMode.disabled;
                _formKeyLogin.currentState!.validate();
              }
            },
            child: SafeArea(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
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
                          child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                emailInput(context),
                                passwordInput(context),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 16),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      forgotPasswordButton(context),
                                      loginButton(context),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 2,
                                  thickness: 2,
                                  indent: 20,
                                  endIndent: 20,
                                  color: FlutterFlowTheme.of(context).secondaryColor,
                                ),
                                createAccountButton(context),
                                confirmAccountButton(context),
                                /*Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 12),
                                  child: createContinueAsGuestButton(context),
                                ),*/
                              ],
                            );
                          })
                      ),
                    ],
                  ),
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
                  onChanged: (value) => { context.read<LoginBloc>().add(EmailChanged(value ?? ''))},
                  validator: (value) => context.read<LoginBloc>().state.IsEmailValid ? null : 'Invalid Email'
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
                onChanged: (value) => context.read<LoginBloc>().add(PasswordChanged(value ?? '')),
                onPasswordVisibilityTapped: () => setState( () => passwordVisibility = !passwordVisibility ),
                validator: (value) => context.read<LoginBloc>().state.IsPasswordValid ? null : 'Invalid Password',
              )
          ),
        ],
      ),
    );
  }

  Widget loginButton(BuildContext context) {

    if (context.read<LoginBloc>().state.Status == LoginStatus.LoggingIn) {
      return Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 70, 28),
          child: Container(
            child: CircularProgressIndicator(color: FlutterFlowTheme.of(context).secondaryColor),
            height: 15.0,
            width: 15.0,
          )
      );
    }

    return FFButtonWidget(
      onPressed: () {
        context.read<LoginBloc>().add(LoginRequested());
      },
      text: 'Login',
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
    );
  }

  Widget forgotPasswordButton(BuildContext context) {
    return FFButtonWidget(
      onPressed: () {
        Navigator.pushNamedAndRemoveUntil(context, "/passwordResetRequest", (r) => false, arguments: context.read<LoginBloc>().state.Email);
      },
      text: 'Forgot Password?',
      options: FFButtonOptions(
        width: 140,
        height: 40,
        color: Color(0xD3FFFFFF),
        textStyle: FlutterFlowTheme.of(context).subtitle2.override(
          fontFamily: 'Poppins',
          color: Color(0xFF090F13),
          fontSize: 12,
        ),
        elevation: 0,
        borderSide: BorderSide(
          color: Colors.transparent,
          width: 1,
        ),
        borderRadius: 12,
      ),
    );
  }

  Widget continueAsGuestButton(BuildContext context) {
    return FFButtonWidget(
      onPressed: () {
        context.read<LoginBloc>().add(ContinueAsGuest());
      },
      text: 'Continue as Guest',
      icon: Icon(
        Icons.person_outline,
        size: 15,
      ),
      options: FFButtonOptions(
        width: 220,
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
    );
  }

  Widget createAccountButton(BuildContext context){
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 12),
      child: FFButtonWidget(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(context, "/createAccount", (r) => false);
        },
        text: 'Create Account',
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

  Widget confirmAccountButton(BuildContext context){
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 12),
      child: FFButtonWidget(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(context, "/confirmAccount", (r) => false);
        },
        text: 'Confirmation Code',
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


