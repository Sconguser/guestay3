import 'package:flutter/material.dart';
import 'package:guestay/auth/auth_credentials.dart';
import 'package:guestay/auth/auth_repository.dart';
import 'package:guestay/auth/form_submission_status.dart';
import 'package:guestay/auth/login/login_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/auth/sign_up/sign_up_event.dart';
import 'package:guestay/home/home_list_repository.dart';
import 'package:guestay/shared/constants/background.dart';
import 'package:guestay/shared/constants/colours.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../shared/divider.dart';
import '../../../shared/spinner.dart';
import '../../auth_cubit.dart';
import '../../sign_up/sign_up_bloc.dart';
import '../login_bloc.dart';
import '../login_state.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final int passwordLength = 6;
  final String incorrectEmail = 'Please enter valid email';
  final String incorrectPassword = 'Please enter valid password';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(
          authRepository: context.read<AuthRepository>(),
          authCubit: context.read<AuthCubit>(),
          homeListRepository: context.read<HomeListRepository>(),
        ),
        child: Container(
          padding: EdgeInsets.all(30),
          decoration: loginBackGroundDecoration,
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    logoImage(context),
                    SizedBox(height: 30),
                    _loginForm(),
                    SizedBox(height: 20),
                    _loginButton(),
                    _signUpButton(context),
                    SizedBox(
                      height: 20,
                    ),
                    Text('or sign in with'),
                    SizedBox(height: 10),
                    _googleLogin(),
                    SizedBox(height: 5),
                    Text(
                        'By signing in, I agree with Terms of Use and Privacy Policy',
                        style: TextStyle(fontSize: 9))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget logoImage(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset('assets/images/logo.png'),
    );
  }

  Widget _loginForm() {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          final formStatus = state.formSubmissionStatus;
          if (formStatus is SubmissionFailed) {
            _showSnackBar(context, formStatus.exception.toString());
          }
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: whiteBackground,
            child: Form(
              key: _formKey,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _userEmailField(),
                      textFieldDivider,
                      _passwordField(),
                      SizedBox(height: 12)
                    ],
                  )),
            ),
          ),
        ));
  }

  Widget _userEmailField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Email',
            hintStyle: TextStyle(fontWeight: FontWeight.bold)),
        validator: (value) => state.isValidUserEmail ? null : incorrectEmail,
        onChanged: (value) => context
            .read<LoginBloc>()
            .add(LoginUserEmailChanged(userEmail: value)),
      );
    });
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Password',
          hintStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
        obscureText: true,
        validator: (value) => state.isValidPassword ? null : incorrectPassword,
        onChanged: (value) => context
            .read<LoginBloc>()
            .add(LoginPasswordChanged(password: value)),
      );
    });
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return state.formSubmissionStatus is FormSubmitting
          ? defaultGuestaySpinner()
          : ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                width: 400,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: primaryColor, elevation: 0),
                    onPressed: () {
                      _loginButtonPressed(context);
                    },
                    child: Text('Sign In')),
              ),
            );
    });
  }

  Future<void> _handleSignIn(BuildContext context) async {
    try {
      AuthRepository authRepository = context.read<AuthRepository>();
      await _googleSignIn.signIn();
      print(_googleSignIn.currentUser);
      GoogleSignInAccount? user = _googleSignIn.currentUser;
      if (user != null) {
        context
            .read<LoginBloc>()
            .add(GoogleLoginSubmitted(email: user.email, password: user.id));
      }
    } catch (error) {
      print(error);
    }
  }

  Widget _googleLogin() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return state.formSubmissionStatus is FormSubmitting
          ? defaultGuestaySpinner()
          : ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                width: 400,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: whiteBackground, elevation: 0),
                    onPressed: () {
                      _handleSignIn(context);
                    },
                    child: Text(
                      'Google',
                      style: TextStyle(color: Colors.black),
                    )),
              ),
            );
    });
  }

  void _loginButtonPressed(BuildContext context) {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      context.read<LoginBloc>().add(LoginSubmitted());
    }
  }

  Widget _signUpButton(BuildContext context) {
    return TextButton(
      child: Text(
        'Create your account',
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () => context
          .read<AuthCubit>()
          .showSignUp(user: context.read<AuthRepository>().user),

      /// smelly
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
