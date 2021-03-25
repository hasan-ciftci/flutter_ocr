// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'records_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RecordsViewModel on _RecordsViewModelBase, Store {
  final _$idAtom = Atom(name: '_RecordsViewModelBase.id');

  @override
  int get id {
    _$idAtom.reportRead();
    return super.id;
  }

  @override
  set id(int value) {
    _$idAtom.reportWrite(value, super.id, () {
      super.id = value;
    });
  }

  final _$_RecordsViewModelBaseActionController =
      ActionController(name: '_RecordsViewModelBase');

  @override
  dynamic setCurrentId(int currentId) {
    final _$actionInfo = _$_RecordsViewModelBaseActionController.startAction(
        name: '_RecordsViewModelBase.setCurrentId');
    try {
      return super.setCurrentId(currentId);
    } finally {
      _$_RecordsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
id: ${id}
    ''';
  }
}
