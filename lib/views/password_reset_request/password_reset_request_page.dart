
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/password_reset_request_bloc/password_reset_request_bloc.dart';
import 'package:mobi_reads/blocs/password_reset_request_bloc/password_reset_request_state.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_widgets.dart';
import 'package:mobi_reads/repositories/account_repository.dart';
import 'package:mobi_reads/views/widgets/error_snackbar.dart';
import 'package:mobi_reads/views/widgets/standard_inputs.dart';

import '../../blocs/password_reset_request_bloc/password_reset_request_event.dart';


class PasswordResetRequestWidget extends StatefulWidget {
  const PasswordResetRequestWidget({Key? key}) : super(key: key);

  @override
  _PasswordResetRequestWidgetState createState() => _PasswordResetRequestWidgetState();
}

class _PasswordResetRequestWidgetState extends State<PasswordResetRequestWidget> {

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
          create: (context) => PasswordResetRequestBloc(RepositoryProvider.of<AccountRepository>(context)),
          child:  BlocListener<PasswordResetRequestBloc, PasswordResetRequestState>(
            listener: (listenerContext, state){
              if (state.Status == PasswordResetRequestStatus.EmailRequested) {
                _autoValidate = AutovalidateMode.always;
                if (_formKeyLogin.currentState!.validate()) {
                  listenerContext.read<PasswordResetRequestBloc>().add(SendEmail());
                }
              }
              else if(state.Status == PasswordResetRequestStatus.Error){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: ErrorSnackbar(header: "Oops", message: state.ErrorMessage)),
                );
              }
              else if(state.Status == PasswordResetRequestStatus.EmailSent){
                listenerContext.read<PasswordResetRequestBloc>().add(RedirectToConfirm());
              }
              else if(state.Status == PasswordResetRequestStatus.RedirectToConfirm){
                Navigator.pushNamedAndRemoveUntil(listenerContext, "/passwordResetConfirm", (r) => false, arguments: state.Email);
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
                      child: BlocBuilder<PasswordResetRequestBloc, PasswordResetRequestState>(builder: (context, state) {
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                              child: Text(
                                "Please enter your email. We'll send a confirmation code.",
                                style: TextStyle(color: FlutterFlowTheme.of(context).secondaryColor, fontSize: 14),
                              ),

                            ),
                            emailInput(context),
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
                  onChanged: (value) => { context.read<PasswordResetRequestBloc>().add(EmailChanged(value ?? ''))},
                  validator: (value) => context.read<PasswordResetRequestBloc>().state.IsEmailValid ? null : 'Invalid Email'
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
              context.read<PasswordResetRequestBloc>().add(EmailRequested());
            },
            text: 'Send',
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


