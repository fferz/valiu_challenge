import 'package:flutter/material.dart';
import 'package:valiu_challenge/src/bloc/tag_bloc.dart';
export 'package:valiu_challenge/src/bloc/tag_bloc.dart';

class Provider extends InheritedWidget {
  static Provider _instancia;

  final _tagBloc = new TagBloc();

  // constructor del Provider
  factory Provider({Key key, Widget child}) {
    // no hay instancia, creo una
    if (_instancia == null) {
      return Provider._internal(key: key, child: child);
    }
    // hay instancia, devuelvo la que existe
    return _instancia;
  }

  // constructor interno
  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  // busca un provider en el arbol de widgets y de ahi saca el LoginBloc
  static TagBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()._tagBloc;
  }
}
