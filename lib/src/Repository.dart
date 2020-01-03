// Inherit from Repository to create your Data Repository
import 'package:flutter/foundation.dart';
import 'package:state_repository/src/NotifiableState.dart';
import 'package:state_repository/src/RepositoryException.dart';

// Manage State without create Widgets on the tree, 
// Repository notify the Widget do rebuild when data changes.
/// A repository its a class that can be accesible from State<> and
/// shared through multiple Widgets
///
// ```dart
// class CounterRepo extends Repository {
//   int _count;

//   int get count {
//     return _count;
//   }

//   set count(int newValue) {
//     _count = newValue;
//     notifyListeners();
//   }

//   void increment() {
//     _count++;
//     notifyListeners();
//   }
// }
//  ```
//  And instantiate the repo
//  ```dart
//  class _MyHomePageState extends NotifiableState<MyHomePage> {
//   //int _counter = 0;
//   @override
//   void initState() {
//     CounterRepo testRepo = CounterRepo();
//     testRepo.count = 2;
//     //testRepo.addListener(this); //direct
//     //Repository.notifyMeChangesOf<TestRepository>(this); // for default (only one)
//     Repository.notifyMeChangesOf<CounterRepo>(this, testRepo); // for especific
//     super.initState();
//   }
//  Se example for full functionality
//

class Repository {
  static Map<String, List<Repository>> instances =
      Map<String, List<Repository>>();

  ObserverList<NotifiableState> _listeners = ObserverList<NotifiableState>();
  bool preserveWithNoListeners;
  // Returns the repository of context
  // if no context id given then returns the first (default) Repository of type T in the list
  static T of<T extends Repository>([NotifiableState context]) {
    List<Repository> _classInstances =
        Repository.getClassIntances(T.toString());
    T defaultRepo;
    if (_classInstances.length > 0) {
      defaultRepo = _classInstances[0];
      if (context != null)
        for (Repository repository in _classInstances) {
          if (repository._listeners.contains(context)) return repository as T;
        }
    } else
      throw new RepositoryException(
          'There is no one repository of ${T.toString()} created.');
    return defaultRepo;
  }

  // sign for notification when default Repository of type T has change

  static void notifyMeChangesOf<T extends Repository>(NotifiableState context,
      [T instance]) {
    T defaultRepo = instance == null ? Repository.of<T>() : instance;
    if (defaultRepo != null)
      defaultRepo.addListener(context);
    else
      throw new RepositoryException(
          'There is no one repository of ${T.toString()} created.');
  }

//Add a listener
  void addListener(NotifiableState listener) {
    _listeners.add(listener);
  }

//remove a listener
  void removeListener(listener) {
    _listeners.remove(listener);
    // removes from instances if there's no listeners
    if (!preserveWithNoListeners && _listeners.isEmpty) removeFromInstances();
  }

// Should call notifyListeners(); in methods/properties
//void increment()
//{
//  count++;
//  notifyListeners();
// }
  void notifyListeners() {
    if (_listeners != null) {
      final List<NotifiableState> localListeners =
          List<NotifiableState>.from(_listeners);
      for (NotifiableState listener in localListeners) {
        listener.notify(() {
          print(
              'Repository ${this.runtimeType.toString()} notifying ${listener.runtimeType.toString()}');
        });
      }
    }
  }

  static List<Repository> getClassIntances(String className) {
    List<Repository> _classInstances;
    //check if exists this class on map
    if (Repository.instances.containsKey(className))
      _classInstances = Repository.instances[className];
    else {
      _classInstances = List<Repository>();
      Repository.instances[className] = _classInstances;
    }
    return _classInstances;
  }

  Repository([this.preserveWithNoListeners = false]) {
    List<Repository> _classInstances =
        Repository.getClassIntances(this.runtimeType.toString());
    _classInstances.add(this);
  }

  void dispose() {
    removeFromInstances();
  }

  void removeFromInstances() {
    List<Repository> _classInstances =
        Repository.getClassIntances(this.runtimeType.toString());
    _classInstances.remove(this);
  }
}
