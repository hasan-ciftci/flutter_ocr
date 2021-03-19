// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeViewModel on _HomeViewModelBase, Store {
  final _$isScanningAtom = Atom(name: '_HomeViewModelBase.isScanning');

  @override
  bool get isScanning {
    _$isScanningAtom.reportRead();
    return super.isScanning;
  }

  @override
  set isScanning(bool value) {
    _$isScanningAtom.reportWrite(value, super.isScanning, () {
      super.isScanning = value;
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

  final _$imageAtom = Atom(name: '_HomeViewModelBase.image');

  @override
  File get image {
    _$imageAtom.reportRead();
    return super.image;
  }

  @override
  set image(File value) {
    _$imageAtom.reportWrite(value, super.image, () {
      super.image = value;
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
  void _changeScanningStatuts() {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
        name: '_HomeViewModelBase._changeScanningStatuts');
    try {
      return super._changeScanningStatuts();
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
  void _updateSelectedImage(File selectedImage) {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
        name: '_HomeViewModelBase._updateSelectedImage');
    try {
      return super._updateSelectedImage(selectedImage);
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _prepareToNewFile() {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
        name: '_HomeViewModelBase._prepareToNewFile');
    try {
      return super._prepareToNewFile();
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isScanning: ${isScanning},
scannedText: ${scannedText},
image: ${image}
    ''';
  }
}