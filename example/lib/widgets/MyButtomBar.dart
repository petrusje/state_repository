import 'package:flutter/material.dart';
import 'package:staterepository/staterepository.dart';
import '../repository/Counter.dart';

class MyButtomBar extends StatefulWidget {
  @override
  _MyButtomBarState createState() => _MyButtomBarState();
}

class _MyButtomBarState extends NotifiableState<MyButtomBar> {
  @override
  void initState() {
    Repository.notifyMeChangesOf<CounterRepo>(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20),
      height: 50,
      alignment: Alignment(-1.0, 1.0),
      decoration: BoxDecoration(color: Colors.yellow),
      child: new Stack(
        children: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.touch_app,
                size: 30,
              ),
              onPressed: () {
                Repository.of<CounterRepo>(this).increment();
              }),
          Repository.of<CounterRepo>().count != 0
              ? new Positioned(
                  right: 11,
                  top: 11,
                  child: new Container(
                    padding: EdgeInsets.all(2),
                    decoration: new BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 14,
                      minHeight: 14,
                    ),
                    child: Text(
                      '${Repository.of<CounterRepo>().count}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : new Container()
        ],
      ),
    );
  }
}
