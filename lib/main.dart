import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:washaacustomer/providers/data_provider.dart';
import 'package:washaacustomer/widgets/layouts/public_layout.dart';
import 'package:washaacustomer/widgets/layouts/main_layout.dart';

void main() async {
  // await initializeNotifications(); // Call the function to initialize notifications
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataProvider(), // Provide your DataProvider here
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // title: 'Login',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(), // Set SplashScreen as the initial screen
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate some initialization process, like loading data, etc.
    Timer(Duration(seconds: 222), () {
      // After 2 seconds, navigate to the appropriate screen based on user login status
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => Consumer<DataProvider>(
            builder: (context, dataProvider, _) {
              return dataProvider.isLoggedIn ? MainLayout() : PublicLayout();
            },
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Colors.blue.shade800,
              Colors.blue.shade300,
            ],
          ),
        ),
        child: Center(
          child: FractionallySizedBox(
            heightFactor: 0.5,
            child: Column(
              //space around each child
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FractionallySizedBox(
                  widthFactor: 0.8, // Set the width factor to 80%
                  child: Image.asset('assets/icons/washaalogolarge.png'),
                ),
                SizedBox(height: 30),
                LoadingAnimationWidget.hexagonDots(
                  color: Colors.white,
                  size: 100,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}
