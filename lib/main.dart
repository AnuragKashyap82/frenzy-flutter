import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frenzy_store/screens/splash_screen.dart';
import 'package:frenzy_store/theme/custom_theme.dart';
import 'package:frenzy_store/theme/theme.dart';
import 'package:frenzy_store/utils/custom_scrool_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(options: const FirebaseOptions(
        apiKey: "AIzaSyDxYwRoOFAFujdaxzf6xbeCUB4C6Ve9G9I",
        authDomain: "frenzy-store-flutter.firebaseapp.com",
        projectId: "frenzy-store-flutter",
        storageBucket: "frenzy-store-flutter.appspot.com",
        messagingSenderId: "670937123556",
        appId: "1:670937123556:web:fd84a2f82f110a38573af1"
    )
    );
  }else{
    await Firebase.initializeApp();
  }
  runApp( CustomTheme(
    initialThemeKey: MyThemeKeys.LIGHT,

    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomTheme.of(context),
      title: 'Frenzy Store',
      debugShowCheckedModeBanner: false,
        scrollBehavior: MyCustomScrollBehavior(),
      home: const SplashScreen()


      // Scaffold(
      //   appBar: AppBar(
      //     elevation: 0,
      //     title: const Text('Welcome to Flutter'),
      //   ),
      //   body: Center(
      //     child: Column(
      //       mainAxisSize: MainAxisSize.min,
      //       children: [
      //         const Text('Hello World'),
      //         MaterialButton(
      //             color: Theme.of(context).primaryColor, //your Theme color
      //             onPressed: () {
      //               setState(() {
      //                 CustomTheme.instanceOf(context).changeTheme(MyThemeKeys.DARK);
      //               });
      //             },
      //             child: const Text("I'm dark now")),
      //         MaterialButton(
      //             color: Theme.of(context).primaryColor,//your Theme color
      //             onPressed: () {
      //               setState(() {
      //                 CustomTheme.instanceOf(context).changeTheme(MyThemeKeys.LIGHT);
      //               });
      //             },
      //             child: const Text("I'm light now")),
      //       ],
      //     ),
      //   ),
      // ),


    );
  }
}
