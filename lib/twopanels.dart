import 'package:flutter/material.dart';
import 'main.dart';

class TwoPanels extends StatefulWidget {
  final AnimationController controller;
  final isPanel;
  final Animation transformationAnim;

  TwoPanels({this.controller, this.isPanel, this.transformationAnim});

  @override
  _TwoPanelsState createState() => new _TwoPanelsState();
}

class _TwoPanelsState extends State<TwoPanels> {
  static const header_height = 32.0;

  Animation<RelativeRect> getPanelAnimation(BoxConstraints constraints) {
    final height = constraints.biggest.height;
    final backPanelHeight = height - header_height;
    final frontPanelHeight = -header_height;

    return new RelativeRectTween(
            begin: new RelativeRect.fromLTRB(
                0.0, backPanelHeight, 0.0, frontPanelHeight),
            end: new RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0))
        .animate(new CurvedAnimation(
            parent: widget.controller, curve: Curves.linear));
  }



  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
    final ThemeData theme = Theme.of(context);

    

    return new Container(
      child: new Stack(
        children: <Widget>[
          new Container(
            color: Colors.red,
            child: Container(
        padding:EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color.fromRGBO(200, 23, 23, 1),
        ),
        child: Column(
          children: <Widget>[
            Container(
              child: Image.asset('images/1.png'),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text("Mercedes-Benz", style: TextStyle(color: Colors.white, fontSize: 24),),),
              Container(
              alignment: Alignment.centerLeft,
              child: Text("C-Class 63S Sedan Oxblood Color", style: TextStyle(color: Colors.white, fontSize: 24),),),
              Container(
              alignment: Alignment.centerLeft,
              child: Text(r"$44275", style: TextStyle(color: Colors.white, fontSize: 24),),),
              
          ],
        ),
      ),
          ),
          new PositionedTransition(
            rect: getPanelAnimation(constraints),
            child: GestureDetector(
              onTap: (){
                widget.controller.fling(velocity: widget.isPanel ? -1.0 : 1.0);
              },
                          child: new Material(
                            
                elevation: 12.0,
                borderRadius: widget.transformationAnim.value,
                child: new Column(
                  children: <Widget>[
                    FlatButton(
                      onPressed: (){
                        
                        widget.controller.fling(velocity: widget.isPanel ? -1.0 : 1.0);
                      },
                      child: SizedBox(
                        height: 12,
                      )
                    ,),
                    new Expanded(
                      child: new ListView(
                        children: <Widget>[
                          Text('Someshit')
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(
      builder: bothPanels,
    );
  }
}