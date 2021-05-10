// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'records_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RecordsViewModel on _RecordsViewModelBase, Store {
  final _$pageAtom = Atom(name: '_RecordsViewModelBase.page');

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  final _$scrollControllerAtom =
      Atom(name: '_RecordsViewModelBase.scrollController');

  @override
  ScrollController get scrollController {
    _$scrollControllerAtom.reportRead();
    return super.scrollController;
  }

  @override
  set scrollController(ScrollController value) {
    _$scrollControllerAtom.reportWrite(value, super.scrollController, () {
      super.scrollController = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_RecordsViewModelBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$usersAtom = Atom(name: '_RecordsViewModelBase.users');

  @override
  ObservableList<dynamic> get allRecords {
    _$usersAtom.reportRead();
    return super.allRecords;
  }

  @override
  set allRecords(ObservableList<dynamic> value) {
    _$usersAtom.reportWrite(value, super.allRecords, () {
      super.allRecords = value;
    });
  }

  final _$newDataAtom = Atom(name: '_RecordsViewModelBase.newData');

  @override
  List<dynamic> get newData {
    _$newDataAtom.reportRead();
    return super.newData;
  }

  @override
  set newData(List<dynamic> value) {
    _$newDataAtom.reportWrite(value, super.newData, () {
      super.newData = value;
    });
  }

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
  dynamic startFetchingData() {
    final _$actionInfo = _$_RecordsViewModelBaseActionController.startAction(
        name: '_RecordsViewModelBase.startFetchingData');
    try {
      return super.startFetchingData();
    } finally {
      _$_RecordsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic completeFetchingData() {
    final _$actionInfo = _$_RecordsViewModelBaseActionController.startAction(
        name: '_RecordsViewModelBase.completeFetchingData');
    try {
      return super.completeFetchingData();
    } finally {
      _$_RecordsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

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
page: ${page},
scrollController: ${scrollController},
isLoading: ${isLoading},
users: ${allRecords},
newData: ${newData},
id: ${id}
    ''';
  }
}
