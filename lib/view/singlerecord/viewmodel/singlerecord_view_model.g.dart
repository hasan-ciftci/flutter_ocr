// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'singlerecord_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SingleRecordViewModel on _SingleRecordViewModelBase, Store {
  final _$recordIdAtom = Atom(name: '_SingleRecordViewModelBase.recordId');

  @override
  int get recordId {
    _$recordIdAtom.reportRead();
    return super.recordId;
  }

  @override
  set recordId(int value) {
    _$recordIdAtom.reportWrite(value, super.recordId, () {
      super.recordId = value;
    });
  }

  final _$_SingleRecordViewModelBaseActionController =
      ActionController(name: '_SingleRecordViewModelBase');

  @override
  dynamic setRecordId(int currentId) {
    final _$actionInfo = _$_SingleRecordViewModelBaseActionController
        .startAction(name: '_SingleRecordViewModelBase.setRecordId');
    try {
      return super.setRecordId(currentId);
    } finally {
      _$_SingleRecordViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic getNext() {
    final _$actionInfo = _$_SingleRecordViewModelBaseActionController
        .startAction(name: '_SingleRecordViewModelBase.getNext');
    try {
      return super.getNext();
    } finally {
      _$_SingleRecordViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic getPrevious() {
    final _$actionInfo = _$_SingleRecordViewModelBaseActionController
        .startAction(name: '_SingleRecordViewModelBase.getPrevious');
    try {
      return super.getPrevious();
    } finally {
      _$_SingleRecordViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
recordId: ${recordId}
    ''';
  }
}
