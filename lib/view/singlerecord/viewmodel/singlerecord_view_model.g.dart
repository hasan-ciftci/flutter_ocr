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

  final _$latitudeAtom = Atom(name: '_SingleRecordViewModelBase.latitude');

  @override
  double get latitude {
    _$latitudeAtom.reportRead();
    return super.latitude;
  }

  @override
  set latitude(double value) {
    _$latitudeAtom.reportWrite(value, super.latitude, () {
      super.latitude = value;
    });
  }

  final _$longitudeAtom = Atom(name: '_SingleRecordViewModelBase.longitude');

  @override
  double get longitude {
    _$longitudeAtom.reportRead();
    return super.longitude;
  }

  @override
  set longitude(double value) {
    _$longitudeAtom.reportWrite(value, super.longitude, () {
      super.longitude = value;
    });
  }

  final _$getRecordInfoAsyncAction =
      AsyncAction('_SingleRecordViewModelBase.getRecordInfo');

  @override
  Future<RecordModel> getRecordInfo(int currentId) {
    return _$getRecordInfoAsyncAction.run(() => super.getRecordInfo(currentId));
  }

  final _$getNextAsyncAction =
      AsyncAction('_SingleRecordViewModelBase.getNext');

  @override
  Future getNext() {
    return _$getNextAsyncAction.run(() => super.getNext());
  }

  final _$getPreviousAsyncAction =
      AsyncAction('_SingleRecordViewModelBase.getPrevious');

  @override
  Future getPrevious() {
    return _$getPreviousAsyncAction.run(() => super.getPrevious());
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
  String toString() {
    return '''
recordId: ${recordId},
latitude: ${latitude},
longitude: ${longitude}
    ''';
  }
}
