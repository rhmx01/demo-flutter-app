import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:washaacustomer/providers/data_provider.dart';

class PublicLayout extends StatefulWidget {
  const PublicLayout({super.key});

  @override
  PublicLayoutState createState() => PublicLayoutState();
}

class PublicLayoutState extends State<PublicLayout> {
  PageController _pageController = PageController();
  int _currentIndex = 0;


  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.grey[100],
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text('Public layout'),
            ),
          )),
    );
  }
}
