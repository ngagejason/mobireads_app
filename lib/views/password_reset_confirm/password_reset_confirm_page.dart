
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/app_bloc/app_bloc.dart';
import 'package:mobi_reads/blocs/app_bloc/app_event.dart';
import 'package:mobi_reads/blocs/password_reset_confirm_bloc/password_reset_confirm_bloc.dart';
import 'package:mobi_reads/blocs/password_reset_confirm_bloc/password_reset_confirm_event.dart';
import 'package:mobi_reads/blocs/password_reset_confirm_bloc/password_reset_confirm_state.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_widgets.dart';
import 'package:mobi_reads/repositories/account_repository.dart';
import 'package:mobi_reads/views/widgets/error_snackbar.dart';
import 'package:mobi_reads/views/widgets/standard_inputs.dart';

class PasswordResetConfirmWidget extends StatefulWidget {
  const PasswordResetConfirmWidget({Key? key}) : super(key: key);

  @override
  _PasswordResetConfirmWidgetState createState() => _PasswordResetConfirmWidgetState();
}

class _PasswordResetConfirmWidgetState extends State<PasswordResetConfirmWidget> {

  bool passwordVisibility = false;
  final _formKeyLogin = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  String email = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    email = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryColor,
      body: BlocProvider(
          create: (context) => PasswordResetConfirmBloc(RepositoryProvider.of<AccountRepository>(context), email),
          child:  BlocListener<PasswordResetConfirmBloc, PasswordResetConfirmState>(
            listener: (listenerContext, state){
              if (state.Status == PasswordResetConfirmStatus.ConfirmRequested) {
                _autoValidate = AutovalidateMode.always;
                if (_formKeyLogin.currentState!.validate()) {
                  listenerContext.read<PasswordResetConfirmBloc>().add(Confirm());
                }
              }
              else if(state.Status == PasswordResetConfirmStatus.Error){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: ErrorSnackbar(header: "Oops", message: state.ErrorMessage)),
                );
              }
              else if(state.Status == PasswordResetConfirmStatus.Confirmed && state.Login != null){
                context.read<AppBloc>().add(UserLoggedInEvent(state.Login!.Id, state.Login!.Email, state.Login!.Username, state.Login!.Bearer, state.Login!.IsGuest));
                listenerContext.read<PasswordResetConfirmBloc>().add(RedirectToHome());
              }
              else if(state.Status == PasswordResetConfirmStatus.RedirectToHome){
                Navigator.pushNamedAndRemoveUntil(listenerContext, "/userHome", (r) => false);
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
                      child: BlocBuilder<PasswordResetConfirmBloc, PasswordResetConfirmState>(builder: (context, state) {
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                              child: Text(
                                "Please enter the confirmation code sent to your email.",
                                style: TextStyle(color: FlutterFlowTheme.of(context).secondaryColor, fontSize: 14),
                              ),

                            ),
                            confirmationCodeInput(context),
                            passwordInput(context),
                            confirmAccountButton(context),
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
                hintText: 'Enter your new password here...',
                passwordVisibility: passwordVisibility,
                onChanged: (value) => context.read<PasswordResetConfirmBloc>().add(PasswordChanged(value ?? '')),
                onPasswordVisibilityTapped: () => setState( () => passwordVisibility = !passwordVisibility ),
                validator: (value) => context.read<PasswordResetConfirmBloc>().state.IsPasswordValid ? null : 'Invalid Password',
              )
          ),
        ],
      ),
    );
  }

  Widget confirmationCodeInput(BuildContext context){
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: StandardInputs.getStandardTextInput(
                buildContext: context,
                hintText: 'Enter confirmation code  here...',
                onChanged: (value) => { context.read<PasswordResetConfirmBloc>().add(ConfirmationCodeChanged(value ?? ''))},
                validator: (value) => context.read<PasswordResetConfirmBloc>().state.IsConfirmationCodeValid ? null : 'Invalid Confirmatino Code',
              )
          ),
        ],
      ),
    );
  }


  Widget confirmAccountButton(BuildContext context){
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FFButtonWidget(
            onPressed: () {
              context.read<PasswordResetConfirmBloc>().add(ConfirmRequested());
            },
            text: 'Send',
            options: FFButtonOptions(
              width: 130,
              height: 50,
              isPrimaryActionButton: true,
            ),
          ),
        ],
      ),
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
          isPrimaryActionButton: false
        ),
      ),
    );
  }
}


