import 'package:flutter/material.dart';
import 'start_screen.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    // FlutterStatusbarManager.setColor(Colors.green, animated:false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: 10, right: 70),
              child: Image.asset('images/12.png')),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(left: 15, top: 10),
                    child: Image.asset('images/first_screen@3x.png')),
                Container(
                    margin: EdgeInsets.only(left: 10, right: 45),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Приветствуем в приложении',
                          style: TextStyle(color: Colors.black, fontSize: 37),
                        ),
                        Text('MoneyBox',
                            style: TextStyle(color: Colors.black, fontSize: 37, fontWeight: FontWeight.w800,fontStyle: FontStyle.italic))
                      ],
                    )),
                RaisedButton(
                  elevation: 4,
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'Авторизироваться через банк',
                      style: TextStyle(
                          color: Color.fromRGBO(114, 194, 118, 1),
                          fontSize: 15),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => StartScreen()),
                    );
                  },
                ),
                Text("Стать клиентом банка",
                    style: TextStyle(color: Colors.black, fontSize: 15))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
