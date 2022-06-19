import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:guestay/auth/auth_credentials.dart';
import 'package:guestay/auth/auth_repository.dart';
import 'package:guestay/auth/form_submission_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/shared/constants/background.dart';
import 'package:guestay/shared/constants/colours.dart';
import 'package:guestay/shared/divider.dart';
import 'package:guestay/shared/spinner.dart';

import '../../auth_cubit.dart';
import '../sign_up_bloc.dart';
import '../sign_up_event.dart';
import '../sign_up_state.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final int passwordLength = 6;
  final String incorrectEmail = 'Please enter valid email';
  final String incorrectPassword = 'Password has to be 6 characters or longer';
  final String incorrectPasswordConfirmation = 'Passwords do not match';
  final String incorrectUsername = 'Username has to be 6 characters or longer';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SignUpBloc(
            authRepository: context.read<AuthRepository>(),
            authCubit: context.read<AuthCubit>()),
        child: Container(
            padding: EdgeInsets.all(20),
            decoration: loginBackGroundDecoration,
            child: Column(children: [
              SizedBox(height: 40),
              _signUpForm(),
              SizedBox(height: 10),
              _signUpButton(),
              SizedBox(height: 10),
              _googleRegister(),
              SizedBox(height: 2),
              Text(
                  'By signing in, I agree with Terms of Use and Privacy Policy',
                  style: TextStyle(fontSize: 9)),
              _loginButton(context)
            ])),
      ),
    );
  }

  Widget _signUpForm() {
    return BlocListener<SignUpBloc, SignUpState>(
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
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _userUsernameField(),
                      textFieldDivider,
                      _userNameField(),
                      textFieldDivider,
                      _userLastNameField(),
                      textFieldDivider,
                      _userEmailField(),
                      textFieldDivider,
                      _userPasswordField(),
                      textFieldDivider,
                      _userPasswordConfirmationField(),
                      SizedBox(height: 12),
                      // _signUpButton(),
                    ],
                  )),
            ),
          ),
        ));
  }

  Future<void> _handleSignUp(BuildContext context) async {
    try {
      AuthRepository authRepository = context.read<AuthRepository>();
      await _googleSignIn.signIn();
      print(_googleSignIn.currentUser);
      GoogleSignInAccount? user = _googleSignIn.currentUser;
      if (user != null) {
        List<String> name = user.displayName!.split(' ');
        List<String> username = user.email.split('@');
        context.read<SignUpBloc>().add(GoogleSignUpSubmitted(
              email: user.email,
              password: user.id,
              name: name[0],
              lastName: name[1],
              username: username[0],
            ));
      }
    } catch (error) {
      print(error);
    }
  }

  Widget _googleRegister() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
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
                      _handleSignUp(context);
                    },
                    child: Text(
                      'Google',
                      style: TextStyle(color: Colors.black),
                    )),
              ),
            );
    });
  }

  Widget _userUsernameField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return TextFormField(
        decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Username',
            hintStyle: TextStyle(fontWeight: FontWeight.bold)),
        validator: (value) => state.isValidUsername ? null : incorrectUsername,
        onChanged: (value) => context
            .read<SignUpBloc>()
            .add(SignUpUsernameChanged(userUsername: value)),
      );
    });
  }

  Widget _userNameField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return TextFormField(
        decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Name',
            hintStyle: TextStyle(fontWeight: FontWeight.bold)),
        validator: (value) => state.isValidUserEmail ? null : incorrectEmail,
        onChanged: (value) =>
            context.read<SignUpBloc>().add(SignUpNameChanged(userName: value)),
      );
    });
  }

  Widget _userLastNameField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return TextFormField(
        decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Last name',
            hintStyle: TextStyle(fontWeight: FontWeight.bold)),
        onChanged: (value) => context
            .read<SignUpBloc>()
            .add(SignUpLastNameChanged(userLastName: value)),
      );
    });
  }

  Widget _userEmailField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return TextFormField(
        decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Email',
            hintStyle: TextStyle(fontWeight: FontWeight.bold)),
        onChanged: (value) => context
            .read<SignUpBloc>()
            .add(SignUpEmaiLChanged(userEmail: value)),
      );
    });
  }

  Widget _userPasswordField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return TextFormField(
        obscureText: true,
        decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Password',
            hintStyle: TextStyle(fontWeight: FontWeight.bold)),
        validator: (value) => state.isValidPassword ? null : incorrectPassword,
        onChanged: (value) => context
            .read<SignUpBloc>()
            .add(SignUpPasswordChanged(userPassword: value)),
      );
    });
  }

  Widget _userPasswordConfirmationField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return TextFormField(
        obscureText: true,
        decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Confirm password',
            hintStyle: TextStyle(fontWeight: FontWeight.bold)),
        validator: (value) => state.isValidPasswordConfirmation
            ? null
            : incorrectPasswordConfirmation,
        onChanged: (value) => context.read<SignUpBloc>().add(
            SignUpPasswordConfirmationChanged(userPasswordConfirmation: value)),
      );
    });
  }

  Widget _signUpButton() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return state.formSubmissionStatus is FormSubmitting
          ? defaultGuestaySpinner()
          : ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: SizedBox(
                width: 400,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: primaryColor, elevation: 0),
                    onPressed: () {
                      _signUpButtonPressed(context);
                    },
                    child: const Text('Sign Up!')),
              ),
            );
    });
  }

  void _signUpButtonPressed(BuildContext context) {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      context.read<SignUpBloc>().add(SignUpSubmitted());
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _loginButton(BuildContext context) {
    return TextButton(
        onPressed: () => context
            .read<AuthCubit>()
            .showLogin(user: context.read<AuthRepository>().user),
        child: const Text(
          'Already have an account? Sign in.',
          style: TextStyle(color: Colors.black),
        ));
  }
}
