
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/app_bloc/app_bloc.dart';
import 'package:mobi_reads/blocs/app_bloc/app_event.dart';
import 'package:mobi_reads/blocs/confirm_account_bloc/confirm_account_bloc.dart';
import 'package:mobi_reads/blocs/confirm_account_bloc/confirm_account_event.dart';
import 'package:mobi_reads/blocs/confirm_account_bloc/confirm_account_state.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_widgets.dart';
import 'package:mobi_reads/repositories/account_repository.dart';
import 'package:mobi_reads/views/widgets/error_snackbar.dart';
import 'package:mobi_reads/views/widgets/standard_inputs.dart';


class ConfirmAccountPageWidget extends StatefulWidget {

  const ConfirmAccountPageWidget({Key? key}) : super(key: key);

  @override
  _ConfirmAccountPageWidgetState createState() => _ConfirmAccountPageWidgetState();
}

class _ConfirmAccountPageWidgetState extends State<ConfirmAccountPageWidget> {

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
          create: (context) => ConfirmAccountBloc(RepositoryProvider.of<AccountRepository>(context), email),
          child:  BlocListener<ConfirmAccountBloc, ConfirmAccountState>(
            listener: (context, state){
              if (state.Status == ConfirmAccountStatus.ConfirmRequested) {
                _autoValidate = AutovalidateMode.always;
                if (_formKeyLogin.currentState!.validate()) {
                  context.read<ConfirmAccountBloc>().add(ConfirmAccount());
                }
              }
              else if(state.Status == ConfirmAccountStatus.Error){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: ErrorSnackbar(message: state.ErrorMessage)),
                );
              }
              else if(state.Status == ConfirmAccountStatus.Confirmed && state.Login != null){
                context.read<AppBloc>().add(UserLoggedInEvent(state.Login!.Id, state.Login!.Email, state.Login!.Username, state.Login!.Bearer, state.Login!.IsGuest));
                context.read<ConfirmAccountBloc>().add(RedirectToHome());
              }
              else if(state.Status == ConfirmAccountStatus.RedirectToHome){
                Navigator.pushNamedAndRemoveUntil(context, "/userHome", (r) => false);
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
                      child: BlocBuilder<ConfirmAccountBloc, ConfirmAccountState>(builder: (context, state) {
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Text(
                                'Please check your email for a confirmation code.',
                                style: TextStyle(color: FlutterFlowTheme.of(context).secondaryColor, fontSize: 14),
                              ),
                            ),
                            emailInput(context),
                            confirmationCodeInput(context),
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

  Widget emailInput(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: StandardInputs.getStandardTextInput(
                initialValue: email,
                buildContext: context,
                hintText: 'Enter your email here...',
                onChanged: (value) => { context.read<ConfirmAccountBloc>().add(EmailChanged(value ?? ''))},
                validator: (value) => context.read<ConfirmAccountBloc>().state.IsEmailValid ? null : 'Invalid Email'
              )
          ),
        ],
      ),
    );
  }

  Widget confirmationCodeInput(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: StandardInputs.getStandardTextInput(
                  buildContext: context,
                  hintText: 'Enter the confirmation code here...',
                  onChanged: (value) => { context.read<ConfirmAccountBloc>().add(ConfirmationCodeChanged(value ?? ''))},
                  validator: (value) => context.read<ConfirmAccountBloc>().state.IsConfirmationCodeValid ? null : 'Invalid Confirmation Code'
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
              context.read<ConfirmAccountBloc>().add(ConfirmAccountRequested());
            },
            text: 'Confirm',
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


