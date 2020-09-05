import 'package:flutter/material.dart';

import 'package:spotjob/pages/welcome_pages/sign_up_page.dart';
import 'package:spotjob/styles/custom_colors.dart';
import 'package:spotjob/widgets/welcome_pages_widgets/welcome_button.dart';
import 'login_page.dart';

class WelcomePage extends StatelessWidget {
  static const routeName = '/welcome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 130, left: 8),
            height: MediaQuery.of(context).size.height * .74,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/welcome.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Welcome to',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'SpotJob',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              WelcomeButton(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Theme.of(context).accentColor,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                text: Text(
                  'Login',
                  style: Theme.of(context).textTheme.button,
                ),
                onTap: () {
                  Navigator.pushNamed(context, LoginInPage.routeName);
                },
              ),
              SizedBox(height: 32),
              WelcomeButton(
                decoration: BoxDecoration(
                  gradient: CustomColors.spotJobDiagonalGradient,
                  borderRadius: BorderRadius.circular(10),
                ),
                text: Text(
                  'Sign up',
                  style: Theme.of(context).textTheme.button.copyWith(
                        color: Colors.white,
                      ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, SignUpPage.routeName);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
