// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  Computed<bool>? _$titleValidComputed;

  @override
  bool get titleValid =>
      (_$titleValidComputed ??= Computed<bool>(() => super.titleValid,
              name: '_HomeControllerBase.titleValid'))
          .value;
  Computed<dynamic>? _$formValidComputed;

  @override
  dynamic get formValid =>
      (_$formValidComputed ??= Computed<dynamic>(() => super.formValid,
              name: '_HomeControllerBase.formValid'))
          .value;

  final _$titleAtom = Atom(name: '_HomeControllerBase.title');

  @override
  String get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  final _$checkBoxAtom = Atom(name: '_HomeControllerBase.checkBox');

  @override
  bool get checkBox {
    _$checkBoxAtom.reportRead();
    return super.checkBox;
  }

  @override
  set checkBox(bool value) {
    _$checkBoxAtom.reportWrite(value, super.checkBox, () {
      super.checkBox = value;
    });
  }

  final _$_sendAsyncAction = AsyncAction('_HomeControllerBase._send');

  @override
  Future<void> _send() {
    return _$_sendAsyncAction.run(() => super._send());
  }

  final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase');

  @override
  void setTitle(String value) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.setTitle');
    try {
      return super.setTitle(value);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCheckBox(bool value) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.setCheckBox');
    try {
      return super.setCheckBox(value);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
title: ${title},
checkBox: ${checkBox},
titleValid: ${titleValid},
formValid: ${formValid}
    ''';
  }
}
