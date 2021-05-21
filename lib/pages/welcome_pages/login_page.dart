import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

import 'package:spotjob/pages/welcome_pages/sign_up_page.dart';
import 'package:spotjob/pages/tabs_pages/tabs_page.dart';
import 'package:spotjob/services/auth_service.dart';
import 'package:spotjob/styles/custom_colors.dart';
import 'package:spotjob/widgets/welcome_pages_widgets/welcome_form_button.dart';
import 'package:spotjob/widgets/welcome_pages_widgets/welcome_input_decoration.dart';

class LoginInPage extends StatefulWidget {
  static const routeName = '/log-in';

  @override
  _LoginInPageState createState() => _LoginInPageState();
}

class _LoginInPageState extends State<LoginInPage> {
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
      body: Column(
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
                  top: (MediaQuery.of(context).size.height * 0.5) - 240,
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Text(
                        'Log in',
                        style: Theme.of(context).textTheme.headline3.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      SizedBox(height: 32),
                      Form(
                        key: _formKey,
                        child: Container(
                          height: 299,
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
                                    textAlignVertical: TextAlignVertical.center,
                                    cursorColor: CustomColors.lightBlue,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: CustomColors.gray,
                                      fontWeight: FontWeight.w300,
                                    ),
                                    decoration: WelcomeInputDecoration
                                        .welcomeInputDecoration(
                                      hintText: 'Email',
                                      iconData: Icons.mail_outline,
                                    ),
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
                                  buttonText: 'Log in',
                                  onTap: () {
                                    // Navigator.of(context)
                                    //     .pushNamed(TabsPage.routeName);
                                    if (_formKey.currentState.validate()) {
                                      AuthService.signIn(_email, _password)
                                          .then((result) {
                                        Navigator.of(context)
                                            .pushNamed(TabsPage.routeName);
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
                                SizedBox(height: 24),
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
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                child: Text(
                  'Forgot password',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                onTap: () {},
              ),
              SizedBox(width: 8),
              Text(
                '|',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              SizedBox(width: 8),
              GestureDetector(
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(SignUpPage.routeName);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
