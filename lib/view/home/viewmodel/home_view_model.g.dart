// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeViewModel on _HomeViewModelBase, Store {
  final _$isLoadingAtom = Atom(name: '_HomeViewModelBase.isLoading');

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

  final _$scannedTextAtom = Atom(name: '_HomeViewModelBase.scannedText');

  @override
  String get scannedText {
    _$scannedTextAtom.reportRead();
    return super.scannedText;
  }

  @override
  set scannedText(String value) {
    _$scannedTextAtom.reportWrite(value, super.scannedText, () {
      super.scannedText = value;
    });
  }

  final _$locationModelAtom = Atom(name: '_HomeViewModelBase.locationModel');

  @override
  LocationModel get locationModel {
    _$locationModelAtom.reportRead();
    return super.locationModel;
  }

  @override
  set locationModel(LocationModel value) {
    _$locationModelAtom.reportWrite(value, super.locationModel, () {
      super.locationModel = value;
    });
  }

  final _$scanImageAsyncAction = AsyncAction('_HomeViewModelBase.scanImage');

  @override
  Future<void> scanImage() {
    return _$scanImageAsyncAction.run(() => super.scanImage());
  }

  final _$getImageFileAsyncAction =
      AsyncAction('_HomeViewModelBase.getImageFile');

  @override
  Future<void> getImageFile() {
    return _$getImageFileAsyncAction.run(() => super.getImageFile());
  }

  final _$_HomeViewModelBaseActionController =
      ActionController(name: '_HomeViewModelBase');

  @override
  void updateEditableText(dynamic value) {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
        name: '_HomeViewModelBase.updateEditableText');
    try {
      return super.updateEditableText(value);
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _changeLoadingStatus() {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
        name: '_HomeViewModelBase._changeLoadingStatus');
    try {
      return super._changeLoadingStatus();
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _updateScannedText(String producedText) {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
        name: '_HomeViewModelBase._updateScannedText');
    try {
      return super._updateScannedText(producedText);
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void prepareToNewFile() {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
        name: '_HomeViewModelBase.prepareToNewFile');
    try {
      return super.prepareToNewFile();
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
scannedText: ${scannedText},
locationModel: ${locationModel}
    ''';
  }
}
