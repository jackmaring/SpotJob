import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

import 'package:spotjob/pages/profile_pages/initial_edit_profile_info_page.dart';
import 'package:spotjob/pages/welcome_pages/login_page.dart';
import 'package:spotjob/services/auth_service.dart';
import 'package:spotjob/services/crud_models/user_crud_model.dart';
import 'package:spotjob/services/update_methods/user_update_methods.dart';
import 'package:spotjob/styles/custom_colors.dart';
import 'package:spotjob/widgets/welcome_pages_widgets/welcome_form_button.dart';
import 'package:spotjob/widgets/welcome_pages_widgets/welcome_input_decoration.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = '/sign-in';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final UserCRUD userCrud = UserCRUD();

  String _username;
  String _email;
  String _password;
  String _error;
  bool passwordTextIsObscured = true;

  final _formKey = GlobalKey<FormState>();

  checkFields() {
    final form = _formKey.currentState;
    if (form.validate()) {
      return true;
    } else {
      return false;
    }
  }

  String validateEmail(String value) {
    Pattern pattern = r'^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter Valid Email';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: CustomColors.spotJobTopDownGradient,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: (MediaQuery.of(context).size.height * 0.5) - 240),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Text(
                          'Sign up',
                          style: Theme.of(context).textTheme.headline3.copyWith(
                                color: Colors.white,
                              ),
                        ),
                        SizedBox(height: 32),
                        Form(
                          key: _formKey,
                          child: Container(
                            height: 358,
                            width: 252,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 8.0,
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 50, left: 16, right: 16),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: 35,
                                    width: 220,
                                    child: TextFormField(
                                      cursorColor: CustomColors.lightBlue,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: CustomColors.gray,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      decoration: WelcomeInputDecoration
                                          .welcomeInputDecoration(
                                        hintText: 'Username',
                                        iconData: Icons.person_outline,
                                      ),
                                      // validator: (value) => value.isEmpty
                                      //     ? 'Username is required'
                                      //     : validateEmail(value.trim()),
                                      onChanged: (value) {
                                        _username = value;
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 24),
                                  Container(
                                    height: 35,
                                    width: 220,
                                    child: TextFormField(
                                      cursorColor: CustomColors.lightBlue,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: CustomColors.gray,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      decoration: WelcomeInputDecoration
                                          .welcomeInputDecoration(
                                              hintText: 'Email',
                                              iconData: Icons.mail_outline),
                                      // The validator receives the text that the user has entered.
                                      validator: (value) => value.isEmpty
                                          ? 'Email is required'
                                          : validateEmail(value.trim()),
                                      onChanged: (value) {
                                        _email = value;
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 24),
                                  Container(
                                    height: 35,
                                    width: 220,
                                    child: TextFormField(
                                      obscureText: passwordTextIsObscured,
                                      cursorColor: CustomColors.lightBlue,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: CustomColors.gray,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      decoration: WelcomeInputDecoration
                                          .welcomeInputDecoration(
                                        hintText: 'Password',
                                        iconData: passwordTextIsObscured
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        onIconTap: () {
                                          setState(() {
                                            passwordTextIsObscured =
                                                !passwordTextIsObscured;
                                          });
                                        },
                                      ),
                                      // The validator receives the text that the user has entered.
                                      validator: (value) => value.isEmpty
                                          ? 'Password is required'
                                          : null,
                                      onChanged: (value) {
                                        _password = value;
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 24),
                                  WelcomeFormButton(
                                    buttonText: 'Sign up',
                                    onTap: () {
                                      if (_formKey.currentState.validate()) {
                                        AuthService()
                                            .signUp(_email, _password)
                                            .then((uid) {
                                          UserUpdateMethods.createUser(
                                            uid,
                                            _email,
                                            _username,
                                          );
                                          Navigator.pushNamed(
                                            context,
                                            InitialEditProfileInfoPage
                                                .routeName,
                                          );
                                        }).catchError((e) {
                                          // _error = e.message.toString();
                                          setState(() {
                                            _error =
                                                "Error during login, please check your credentials.";
                                          });
                                          throw e;
                                        });
                                      }
                                    },
                                  ),
                                  SizedBox(height: 16),
                                  SignInButton(
                                    Buttons.Google,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            Container(
              width: 280,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SignInButton(
                    Buttons.Apple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27.5),
                    ),
                    mini: true,
                    padding: EdgeInsets.all(10),
                    onPressed: () {},
                  ),
                  SignInButton(
                    Buttons.Facebook,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27.5),
                    ),
                    padding: EdgeInsets.all(10),
                    mini: true,
                    onPressed: () {},
                  ),
                  SignInButton(
                    Buttons.LinkedIn,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27.5),
                    ),
                    padding: EdgeInsets.all(10),
                    mini: true,
                    onPressed: () {},
                  )
                ],
              ),
            ),
            SizedBox(height: 32),
            Text(
              'Already have an account?',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              child: Text(
                'Click here to log in',
                style: TextStyle(
                    color: CustomColors.gray,
                    fontSize: 14,
                    fontWeight: FontWeight.w300),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(LoginInPage.routeName);
              },
            ),
            SizedBox(height: 64),
          ],
        ),
      ),
    );
  }
}
