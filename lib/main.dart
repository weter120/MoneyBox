import 'package:flutter/material.dart';
// import 'twopanels.dart';
import 'backdrop.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'expand_list.dart';
import 'custom_tapbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'start_screen.dart';
import 'welcome_screen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'models/scoped_model.dart';

import 'dart:math' as math;

import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

List cars = [
  "Mersedes-Bens",
  "Acura",
  "Aston Martin",
  "Bentley",
  "Bugatti",
  "Cadillac",
  "Chevrolette",
  "Citroen",
  "Mersedes-Bens",
  "Acura",
  "Aston Martin",
  "Bentley",
  "Bugatti",
  "Cadillac",
  "Chevrolette",
  "Citroen"
];

List coffee = ['Adler', 'AEG', 'Aresa', 'Ariete', 'Arnica', 'ASKO'];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(
      model: AppModel(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              fontFamily: 'Montserrat',
              accentColor: Colors.white,
              primaryColor: Colors.green),
          title: "MoneyBox",
          home: WelcomeScreen()),
    );
  }
}

class CatalogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: ScopedModelDescendant<AppModel>(
              builder: (context, child, model) => model.targets.length == 0
                  ? FloatingActionButton.extended(
                      backgroundColor: Color.fromRGBO(114, 194, 118, 1),
                      foregroundColor: Colors.white,
                      label: Text('Новая цель'),
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StartScreen()),
                        );
                      },
                    )
                  : FloatingActionButton(
                      backgroundColor: Color.fromRGBO(114, 194, 118, 1),
                      foregroundColor: Colors.white,
                      child: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StartScreen(),
                            ),
                            (Route<dynamic> route) => false);
                      },
                    ),
            ),
            bottomNavigationBar: BottomAppBar(
              //shape: CircularNotchedRectangle(),
              child: Row(
                //mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    padding: EdgeInsets.only(left: 30),
                    icon: Icon(
                      FontAwesomeIcons.piggyBank,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => StartScreen()),
                      );
                    },
                  ),
                  IconButton(
                    padding: EdgeInsets.only(right: 30),
                    icon: Icon(FontAwesomeIcons.userCircle),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              bottom: TabBar(
                unselectedLabelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: new BubbleTabIndicator(
                  indicatorHeight: 25.0,
                  indicatorColor: Color.fromRGBO(114, 194, 118, 1),
                  tabBarIndicatorSize: TabBarIndicatorSize.tab,
                ),
                tabs: <Widget>[
                  Tab(
                    text: "Машины",
                  ),
                  Tab(
                    text: "Кофе",
                  ),
                  Tab(
                    text: "Электроника",
                  ),
                ],
              ),
              elevation: 0,
              backgroundColor: Colors.white,
              title: Text(
                "Каталог",
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: TabBarView(
              children: [
                ListView.builder(
                  itemCount: cars.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(7),
                      child: ListTile(
                        //leading: Icon(Icons.event_seat),
                        title: Text(cars[index]),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CarScreen()),
                          );
                        },
                      ),
                    );
                  },
                ),
                ListView.builder(
                  itemCount: coffee.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(7),
                      child: ListTile(
                        //leading: Icon(Icons.event_seat),
                        title: Text(coffee[index]),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CarScreen()),
                          );
                        },
                      ),
                    );
                  },
                ),
                Icon(Icons.directions_bike),
              ],
            ) /* ListView.builder(
          itemCount: cars.length,
          itemBuilder: (context, index) {
            return ListTile(
              //leading: Icon(Icons.event_seat),
              title: Text(cars[index]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CarScreen()),
                );
              },
            );
          },
        ),*/
            ));
  }
}

class CarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: ScopedModelDescendant<AppModel>(
          builder: (context, child, model) => model.targets.length == 0
              ? FloatingActionButton.extended(
                  backgroundColor: Color.fromRGBO(114, 194, 118, 1),
                  foregroundColor: Colors.white,
                  label: Text('Новая цель'),
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StartScreen(),
                        ),
                        (Route<dynamic> route) => false);
                  },
                )
              : FloatingActionButton(
                  backgroundColor: Color.fromRGBO(114, 194, 118, 1),
                  foregroundColor: Colors.white,
                  child: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StartScreen(),
                        ),
                        (Route<dynamic> route) => false);
                  },
                ),
        ),
        bottomNavigationBar: Hero(
          tag: 'barbottom',
          child: BottomAppBar(
            //shape: CircularNotchedRectangle(),
            child: Row(
              //mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  padding: EdgeInsets.only(left: 30),
                  icon: Icon(
                    FontAwesomeIcons.piggyBank,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => StartScreen()),
                    );
                  },
                ),
                IconButton(
                  padding: EdgeInsets.only(right: 30),
                  icon: Icon(FontAwesomeIcons.userCircle),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          actions: <Widget>[
            Container(
                margin: EdgeInsets.only(right: 16),
                child: Icon(Icons.filter_list))
          ],
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'Mercedes-Benz',
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500),
          ),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Stack(
                    alignment: Alignment(0.85, 0.99),
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment(0.8, 0.8),
                                      colors: [
                                        Color.fromRGBO(255, 78, 78, 1),
                                        Color.fromRGBO(100, 12, 12, 1)
                                      ]),
                                  // color: Colors.grey,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              //color: Colors.grey,
                              padding: EdgeInsets.all(8),
                              child: Hero(
                                  tag: "Mers",
                                  child: Image.asset('images/2.png'))),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              r'AUTHOMATIC 3.0L',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      ),
                      Container(
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SimpleExample()),
                            );
                          },
                          color: Colors.white,
                          elevation: 10,
                          child: Text(
                            "Хочу →",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Mercedes-Benz C-Class 63S Sedan Oxblood Color',
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      r'$44526',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}

// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

class SimpleExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Mercedes-Benz C-Class',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: SafeArea(child: Panels()));
}

class Panels extends StatelessWidget {
  final frontPanelVisible = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Backdrop(
      frontLayer: FrontPanel(),
      backLayer: BackPanel(
        frontPanelOpen: frontPanelVisible,
      ),
      frontHeader: FrontPanelTitle(),
      panelVisible: frontPanelVisible,
      frontPanelOpenHeight: 40.0,
      frontHeaderHeight: 48.0,
      frontHeaderVisibleClosed: true,
    );
  }
}

class FrontPanelTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 13, horizontal: 130),
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(8)))),
    );
  }
}

class BackPanel extends StatefulWidget {
  BackPanel({@required this.frontPanelOpen});
  final ValueNotifier<bool> frontPanelOpen;

  @override
  createState() => _BackPanelState();
}

class _BackPanelState extends State<BackPanel> {
  bool panelOpen;

  @override
  initState() {
    super.initState();
    panelOpen = widget.frontPanelOpen.value;
    widget.frontPanelOpen.addListener(_subscribeToValueNotifier);
  }

  void _subscribeToValueNotifier() =>
      setState(() => panelOpen = widget.frontPanelOpen.value);

  /// Required for resubscribing when hot reload occurs
  @override
  void didUpdateWidget(BackPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.frontPanelOpen.removeListener(_subscribeToValueNotifier);
    widget.frontPanelOpen.addListener(_subscribeToValueNotifier);
  }

  @override
  Widget build(BuildContext context) {
    final String assetName = 'icons/1.svg';
    final String assetName2 = 'icons/3.svg';
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.8, 0.8),
              colors: [
            Color.fromRGBO(255, 78, 78, 1),
            Color.fromRGBO(100, 12, 12, 1)
          ])),
      child: ListView(children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              child: Hero(tag: "Mers", child: Image.asset('images/2.png')),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Mercedes-Benz",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "C-Class 63S Sedan Oxblood Color",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Цена",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                r"$44275",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            SizedBox(height: 40.0),
            Container(
              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    'Характеристики',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  Text(
                    'Настроить → ',
                    style: TextStyle(color: Colors.white30, fontSize: 18),
                  )
                ],
              ),
            ),
            SizedBox(height: 30.0),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Color.fromRGBO(255, 204, 0, 0.32),
                            offset: Offset(1.0, 6.0),
                            blurRadius: 10.0,
                          ),
                        ],
                        color: Color.fromRGBO(255, 181, 70, 1),
                        // border: Border.all(),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(right: 50),
                          alignment: Alignment.centerLeft,
                          child: FlutterLogo(),
                          // child: SvgPicture.asset(
                          //   assetName,
                          //   height: 60,
                          //   color: Colors.white,
                          // ),
                        ),
                        Container(
                          child: Text(
                            'Authomatic',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(139, 0, 0, 1),
                        // border: Border.all(),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(right: 50),
                          alignment: Alignment.centerLeft,
                          child: FlutterLogo(),
                          // child: SvgPicture.asset(
                          //   assetName,
                          //   height: 60,
                          //   color: Colors.white,
                          // ),
                        ),
                        Container(
                          child: Text(
                            'Authomatic',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.0),
            Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Описание",
                  style: TextStyle(color: Colors.white, fontSize: 23),
                )),
            Text(
              "The new Mercedes-AMG C 63 S Sedan also sports the AMG-specific radiator trim. The AMG RIDE CONTROL sport suspension with a three-stage damping adjustment enables lateral acceleration and grip at the highest level and makes the new Mercedes-AMG C 63 S Sedan an exceptional performance vehicle. Thanks to AMG DYNAMIC SELECT with the AMG-specific driving programs \" Slippery\" , \"Individual\", \"Comfort\", \"Sport\" and \"Sport +\" many parameters of the Mercedes-AMG C 63 S Sedan can be adapted. As the strongest model of the C-Class, it also has the “RACE” driving program.",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(
              height: 60,
            )
          ],
        ),
      ]),
    );
  }
}
