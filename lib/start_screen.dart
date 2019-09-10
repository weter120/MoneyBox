import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'main.dart';
import 'package:scoped_model/scoped_model.dart';
import 'models/scoped_model.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Container(
              margin: EdgeInsets.only(right: 16),
              child: Icon(
                Icons.filter_list,
                color: Colors.black,
              ))
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Коплю',
          style: TextStyle(color: Colors.black),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Hero(
        tag: "bottombar",
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
                  color: Color.fromRGBO(114, 194, 118, 1),
                ),
                onPressed: () {},
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
      floatingActionButton: ScopedModelDescendant<AppModel>(
        builder: (context, child, model) => model.targets.length == 0
            ? FloatingActionButton.extended(
                backgroundColor: Color.fromRGBO(114, 194, 118, 1),
                foregroundColor: Colors.white,
                label: Text('Новая цель'),
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => CatalogScreen()),
                  );
                },
              )
            : FloatingActionButton(
                child: Icon(Icons.add, color: Color.fromRGBO(114, 194, 118, 1)),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => CatalogScreen()),
                  );
                },
              ),
      ),
      body: ScopedModelDescendant<AppModel>(
          builder: (context, child, model) => model.targets.length == 0
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Image.asset('images/new_goal@2x.png')),
                      Column(
                        children: <Widget>[
                          Text('Список пока пуст'),
                          Text('Хотите добавить цель?')
                        ],
                      ),
                    ],
                  ),
                )
              : ListView(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Mercedes-Benz",
                        style: TextStyle(color: Colors.black, fontSize: 24),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "C-Class 63S Sedan Oxblood Color",
                        style: TextStyle(color: Colors.black, fontSize: 24),
                      ),
                    ),
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: <Widget>[
                        Container(
                          child: Text('15%'),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            color: Colors.green,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4))
                          ),
                          child: Text('Осталось н часов'),
                        )
                      ],
                    ),
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
                            tag: "Mers", child: Image.asset('images/2.png'))),
                  ],
                )),
    );
  }
}
