import 'main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'models/scoped_model.dart';
import 'models/target_model.dart';
import 'start_screen.dart';

class FrontPanel extends StatefulWidget {
  @override
  _FrontPanelState createState() => _FrontPanelState();
}

class _FrontPanelState extends State<FrontPanel> {
  void expandable(e) {
    setState(() {
      months = e;
      val2 = (val / months);
    });
  }

  void expandable2(z) {
    setState(() {
      val2 = z;
      months = (val / val2);
    });
  }

  double val = 30000;
  double val2 = 450;
  double months = 12;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        color: Theme.of(context).cardColor,
        child: ListView(
          children: <Widget>[
            Container(
              child: Text('Название копилки'),
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(8),
                      hintText: 'Краткое название копилки'),
                )),
            Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('Цена'),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${val.toInt()}' + r' $',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('Сколько плачу в месяц'),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${val2.toInt()}' + r' $',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  child: Slider(
                    activeColor: Colors.green,
                    inactiveColor: Colors.grey,
                    value: val2,
                    onChanged: (double e) => expandable2(e),
                    max: 2500,
                    min: 412,
                  ),
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text("Накоплю через")),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${months.toInt()} месяцев",
                      style:
                          TextStyle(fontSize: 36, fontWeight: FontWeight.w500),
                    )),
                Container(
                  child: Slider(
                    activeColor: Colors.green,
                    inactiveColor: Colors.grey,
                    value: months,
                    onChanged: (double e) => expandable(e),
                    max: 73.1,
                    min: 12,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text('Почему хочу'),
                ),
                Container(
                    child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 6)),
                    contentPadding: EdgeInsets.symmetric(vertical: 50),
                    hintText: 'Необязательно',
                  ),
                )),
                SizedBox(
                  height: 20,
                ),
                ScopedModelDescendant<AppModel>(
                  builder: (context, child, model) => FlatButton(
                        padding: EdgeInsets.all(5),
                        color: Color.fromRGBO(114, 194, 118, 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              'Открыть депозит',
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.white,
                            )
                          ],
                        ),
                        onPressed: () {
                          model.addTarget(Target("Мерс", 400, 30000, "max", "Mersedes-Benz", 48));
                          
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => StartScreen(),),(Route<dynamic> route) => false
                      );
                        },
                      ),
                ),
                SizedBox(
                  height: 15,
                )
              ],
            )
          ],
        ));
  }
}
