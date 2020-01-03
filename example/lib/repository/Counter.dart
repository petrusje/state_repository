import 'package:staterepository/staterepository.dart';

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
