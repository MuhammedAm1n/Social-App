import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/DataLayer/Drs/DataSource.dart';
import 'package:social/DataLayer/Repositry/Repositry.dart';
import 'package:social/DomainLayer/AbsRepositry/AbsReposity.dart';
import 'package:social/DomainLayer/UseCases/LoginUseCase.dart';
import 'package:social/PresentaionLayer/Component/Themes/ThemeProvider.dart';
import 'package:social/PresentaionLayer/Component/Themes/ToggleAuth.dart';
import 'package:social/PresentaionLayer/Component/Themes/ToggleLogin_Register.dart';
import 'package:social/PresentaionLayer/Screens/Homepage.dart';
import 'package:social/PresentaionLayer/Screens/Profilepage.dart';
import 'package:social/PresentaionLayer/Screens/UsersPage.dart';
import 'package:social/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  AbstractRemoteData abstractRemoteData = RemoteData();
  AbsRepositry absRepositry = Repositry(abstractRemoteData);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider()),
      ChangeNotifierProvider<UseCases>(
          create: (context) => UseCases(absRepositry)),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const AuthPage(),
      routes: {
        'Login_Register': (context) => const LogOrReg(),
        'Home': (context) => HomePage(),
        'Profile': (context) => const ProfilePage(),
        'Users': (context) => const UsersPage(),
      },
    );
  }
}
