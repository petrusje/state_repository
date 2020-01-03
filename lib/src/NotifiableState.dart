import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:state_repository/src/Repository.dart';


// Use NotifiableState instead State to receive notifications
// Should inherit from NotifiableState to receive Change Notifications from Repositories
// The only reason a create this class is because setState is protected in State

abstract class NotifiableState<T extends StatefulWidget> extends State<T> {
  ObserverList<Repository> repositories = ObserverList<Repository>();

  void notify(VoidCallback fn) {
    setState(fn);
  }

  @mustCallSuper
  @override
  void dispose() {
    // remove itself from the signed repositories
    if (repositories.isNotEmpty)
      for (Repository repo in repositories) repo.removeListener(this);
    super.dispose();
  }
}
