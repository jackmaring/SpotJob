import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/models/category.dart';
import 'package:spotjob/models/chat.dart';
import 'package:spotjob/models/job.dart';
import 'package:spotjob/models/user.dart';
import 'package:spotjob/pages/home_pages/filter_page.dart';
import 'package:spotjob/pages/job_pages/edit_job_info_page.dart';
import 'package:spotjob/pages/job_pages/job_info_page.dart';
import 'package:spotjob/pages/job_pages/new_job_page.dart';
import 'package:spotjob/pages/job_pages/take_requests_page.dart';
import 'package:spotjob/pages/profile_pages/connections_page.dart';
import 'package:spotjob/pages/profile_pages/edit_profile_info_page.dart';
import 'package:spotjob/pages/profile_pages/initial_edit_profile_info_page.dart';
import 'package:spotjob/pages/profile_pages/jobs_completed_page.dart';
import 'package:spotjob/pages/profile_pages/jobs_posted_page.dart';
import 'package:spotjob/pages/profile_pages/profile_page.dart';
import 'package:spotjob/pages/tabs_pages/message_pages/message_page.dart';
import 'package:spotjob/pages/tabs_pages/tabs_page.dart';
import 'package:spotjob/pages/welcome_pages/login_page.dart';
import 'package:spotjob/pages/welcome_pages/sign_up_page.dart';
import 'package:spotjob/pages/welcome_pages/welcome_page.dart';
import 'package:spotjob/providers/change_category.dart';
import 'package:spotjob/providers/create_job.dart';
import 'package:spotjob/providers/create_user.dart';
import 'package:spotjob/providers/settings.dart';
import 'package:spotjob/services/crud_models/categories_crud_model.dart';
import 'package:spotjob/services/crud_models/chat_crud_model.dart';
import 'package:spotjob/services/crud_models/job_crud_model.dart';
import 'package:spotjob/services/crud_models/user_crud_model.dart';
import 'package:spotjob/styles/custom_colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final JobCRUD jobCrud = JobCRUD();
    final UserCRUD userCrud = UserCRUD();
    final ChatCRUD chatCrud = ChatCRUD();
    final CategoryCRUD categoryCrud = CategoryCRUD();
    
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(
          value: FirebaseAuth.instance.onAuthStateChanged,
        ),
        StreamProvider<List<Job>>(
          create: (_) => jobCrud.getJobs(),
        ),
        StreamProvider<List<User>>(
          create: (_) => userCrud.getUsers(),
        ),
        StreamProvider<List<Category>>(
          create: (_) => categoryCrud.getCategories(),
        ),
        StreamProvider<List<Chat>>(
          create: (_) => chatCrud.getChats(),
        ),
        ChangeNotifierProvider(
          create: (_) => CreateJob(),
        ),
        ChangeNotifierProvider(
          create: (_) => CreateUser(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChangeCategory(),
        ),
        ChangeNotifierProvider(
          create: (_) => Settings(),
        ),
      ],
      child: MaterialApp(
        title: 'SpotJob',
        theme: ThemeData(
          primaryColor: CustomColors.darkBlue,
          accentColor: CustomColors.lightBlue,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Helvetica',
          textTheme: TextTheme(
            headline3: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.normal,
              color: CustomColors.darkGray,
            ),
            headline4: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.normal,
              color: CustomColors.darkGray,
            ),
            headline5: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
            headline6: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: CustomColors.gray,
            ),
            subtitle1: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: CustomColors.gray,
            ),
            subtitle2: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: CustomColors.gray,
            ),
            bodyText1: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: CustomColors.darkGray,
            ),
            bodyText2: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: CustomColors.gray,
            ),
            overline: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: CustomColors.darkGray,
              letterSpacing: 0.8,
              height: 1.2,
            ),
            button: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: CustomColors.darkGray,
            ),
          ),
        ),
        home: WelcomePage(), // default is '/'
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case WelcomePage.routeName:
              return PageTransition(
                child: WelcomePage(),
                type: PageTransitionType.fade,
              );
              break;
            case LoginInPage.routeName:
              return PageTransition(
                child: LoginInPage(),
                type: PageTransitionType.fade,
              );
              break;
            case SignUpPage.routeName:
              return PageTransition(
                child: SignUpPage(),
                type: PageTransitionType.fade,
              );
              break;
            case TabsPage.routeName:
              return PageTransition(
                child: TabsPage(),
                type: PageTransitionType.fade,
              );
              break;
            case NewJobPage.routeName:
              return PageTransition(
                child: NewJobPage(),
                type: PageTransitionType.fade,
              );
              break;
            case FilterPage.routeName:
              return PageTransition(
                child: FilterPage(),
                type: PageTransitionType.fade,
              );
              break;
            case JobInfoPage.routeName:
              return PageTransition(
                child: JobInfoPage(),
                type: PageTransitionType.fade,
                settings: settings,
              );
              break;
            case TakeRequestsPage.routeName:
              return PageTransition(
                child: TakeRequestsPage(),
                type: PageTransitionType.fade,
                settings: settings,
              );
              break;
            case EditJobInfoPage.routeName:
              return PageTransition(
                child: EditJobInfoPage(),
                type: PageTransitionType.fade,
                settings: settings,
              );
              break;
            case MessagePage.routeName:
              return PageTransition(
                child: MessagePage(),
                type: PageTransitionType.fade,
                settings: settings,
              );
              break;
            case ProfilePage.routeName:
              return PageTransition(
                child: ProfilePage(),
                type: PageTransitionType.fade,
                settings: settings,
              );
              break;
            case InitialEditProfileInfoPage.routeName:
              return PageTransition(
                child: InitialEditProfileInfoPage(),
                type: PageTransitionType.fade,
              );
              break;
            case EditProfileInfoPage.routeName:
              return PageTransition(
                child: EditProfileInfoPage(),
                type: PageTransitionType.fade,
              );
              break;
            case ConnectionsPage.routeName:
              return PageTransition(
                child: ConnectionsPage(),
                type: PageTransitionType.fade,
                settings: settings,
              );
              break;
            case JobsCompletedPage.routeName:
              return PageTransition(
                child: JobsCompletedPage(),
                type: PageTransitionType.fade,
                settings: settings,
              );
              break;
            case JobsPostedPage.routeName:
              return PageTransition(
                child: JobsPostedPage(),
                type: PageTransitionType.fade,
                settings: settings,
              );
              break;
            default:
              return null;
          }
        },
        // routes: {
        // WelcomePage.routeName: (ctx) => WelcomePage(),
        // LoginInPage.routeName: (ctx) => LoginInPage(),
        // SignUpPage.routeName: (ctx) => SignUpPage(),
        // TabsPage.routeName: (ctx) => TabsPage(),
        // NewJobPage.routeName: (ctx) => NewJobPage(),
        // FilterPage.routeName: (ctx) => FilterPage(),
        // JobInfoPage.routeName: (ctx) => JobInfoPage(),
        // EditJobInfoPage.routeName: (ctx) => EditJobInfoPage(),
        // MessagePage.routeName: (ctx) => MessagePage(),
        // ProfilePage.routeName: (ctx) => ProfilePage(),
        // InitialEditProfileInfoPage.routeName: (ctx) =>
        //     InitialEditProfileInfoPage(),
        // EditProfileInfoPage.routeName: (ctx) => EditProfileInfoPage(),
        // ConnectionsPage.routeName: (ctx) => ConnectionsPage(),
        // JobsCompletedPage.routeName: (ctx) => JobsCompletedPage(),
        // JobsPostedPage.routeName: (ctx) => JobsPostedPage(),
        // },
      ),
    );
  }
}
