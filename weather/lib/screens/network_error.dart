import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather/screens/loading_screen.dart';

class ErrorScreen extends StatefulWidget {
  @override
  _ErrorScreenState createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30.0,
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return LoadingScreen();
            }));
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'ERROR',
              style: TextStyle(
                color: Colors.white,
                fontSize: 60.0,
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.left,
            ),
            Icon(
              FontAwesomeIcons.sadTear,
              size: 200.0,
            ),
            Text(
              'We are facing some problem. Please make sure that you have proper inetrnet connection and your location in turned on.',
              style: TextStyle(fontSize: 20.0),
            )
          ],
        ),
      ),
    );
  }
}
