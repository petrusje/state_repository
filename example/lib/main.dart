import 'package:flutter/material.dart';
import 'package:staterepository/staterepository.dart';
import 'repository/Counter.dart';
import 'widgets/MyButtomBar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Repository Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Repository Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends NotifiableState<MyHomePage> {
  //int _counter = 0;
  @override
  void initState() {
    CounterRepo testRepo = CounterRepo();
    testRepo.count = 2;
    //testRepo.addListener(this); //direct
    //Repository.notifyMeChangesOf<TestRepository>(this); // for default (only one)
    Repository.notifyMeChangesOf<CounterRepo>(this, testRepo); // for especific
    super.initState();
  }

  void _incrementCounter() {
    Repository.of<CounterRepo>(this).increment();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${Repository.of<CounterRepo>(this).count}',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: MyButtomBar(),
    ); 
  }
}
