
import 'package:flutter/material.dart';
import 'package:firebase_user_login/items.dart';
import 'package:firebase_user_login/screens/LoginScreen.dart';

import 'screens/LoginScreen.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome Screen',
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{

 double _scale;
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }
  
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }



  List<Widget> slides = items
      .map((item) => Container(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Image.asset(
                  item['image'],
                 
                  height:400,
                  width: 300.0,
                  alignment: Alignment.bottomCenter,
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: <Widget>[
                      Text(item['header'],
                          style: item['header']=="Welcome to Yonsei Dairy"?TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w400,
                              color: Color(0XFF3F3D56),
                              height: 2.0)
                              :
                              TextStyle(
                              fontSize: 50.0,
                              fontWeight: FontWeight.w300,
                              color: Color(0XFF3F3D56),
                              height: 2.0)),

                      Text(
                        item['description'],
                        style: TextStyle(
                            color: Colors.grey,
                            letterSpacing: 1.2,
                            fontSize: 16.0,
                            height: 1.3),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              )
            ],
          )))
      .toList();

  List<Widget> indicator() => List<Widget>.generate(
      slides.length,
      (index) => Container(
            margin: EdgeInsets.symmetric(horizontal: 3.0),
            height: 14.0,
            width: 14.0,
            decoration: BoxDecoration(
                color: currentPage.round() == index
                    ? Color(0xfffec321)
                    : Color(0XFF256075).withOpacity(0.2),
                borderRadius: BorderRadius.circular(10.0)),
          ));

  double currentPage = 0.0;
  final _pageViewController = new PageController();
  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Stack(
          children: <Widget>[
            PageView.builder(
             
              physics: BouncingScrollPhysics(),
              controller: _pageViewController,
              pageSnapping: true,
              itemCount: slides.length,
              itemBuilder: (BuildContext context, int index) {
                _pageViewController.addListener(() {
                  setState(() {
                    currentPage = _pageViewController.page;
                  });
                });
                return slides[index];
              },
            ),
            Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 70.0),
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: indicator(),
                  ),
                )
                //  ),
                ),



   Align(
                         alignment: Alignment.bottomCenter,
                         child: Container(
                             margin: EdgeInsets.only(top: 70.0),
                  padding: EdgeInsets.symmetric(vertical: 150.0),
                           child: Text("double tap to",style: TextStyle(fontSize: 11),))
                           ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(

                     margin: EdgeInsets.only(top: 40.0),
                  padding: EdgeInsets.symmetric(vertical: 90.0),
                    child: GestureDetector(
                      
              onTapDown: _onTapDown,
              onTapUp: _onTapUp,
              onDoubleTap: (){
                                 Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LoginScreen()),
  );
             
              },
              
              child: Transform.scale(
                scale: _scale,
                child: _animatedButtonUI,
              ),
            ),
                       
                       )
                       ),
                    
            // )
          ],
        ),
      ),
    );
  }


  
  Widget get _animatedButtonUI => Container(
        height: 45,
        width: 140,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            boxShadow: [
              BoxShadow(
                color: Color(0x80000000),
                blurRadius: 30.0,
                offset: Offset(0.0, 5.0),
              ),
            ],
            gradient:LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
               Color(0xfffec321),
                Color(0xfffec321),
              ],
            )),
        child: Center(
          child: Text(
            'Get Started',
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      );

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
        
             
  }
}
