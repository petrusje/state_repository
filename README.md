# state_repository v1.0.0
 Manage State without create Widgets on the tree,
 the widgets sign for notificationchanges then the repository notify the Widget do rebuild when data changes,
 repositories can be shared easily across widgets.

Just create a inherited repository 

```dart
class CounterRepo extends Repository {
  int _count;

  int get count {
    return _count;
  }

  set count(int newValue) {
    _count = newValue;
    notifyListeners();
  }

  void increment() {
    _count++;
    notifyListeners();
  }
}
 ```
 
 And instantiate the repo
 ```dart
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
 ```
 
 You can access the Repo in other widgets and sign to be notified  of changes 

 ```dart
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
                Repository.of<CounterRepo>().increment();
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
 ```

