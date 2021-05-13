import 'package:flutter/material.dart';
import 'package:valiu_challenge/src/bloc/tag_bloc.dart';
import 'package:valiu_challenge/src/service/socket_service.dart';
export 'package:valiu_challenge/src/bloc/tag_bloc.dart';

class Provider extends InheritedWidget {
  static Provider _instancia;

  final _tagBloc = new TagBloc();
  final _socketService = new SocketService();

  factory Provider({Key key, Widget child}) {
    // there is no instance => creates a new one
    if (_instancia == null) {
      return Provider._internal(key: key, child: child);
    }
    // returns existing instance
    return _instancia;
  }

  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static TagBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()._tagBloc;
  }

  static SocketService socketService(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<Provider>()
        ._socketService;
  }
}
