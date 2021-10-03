// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tarefa_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TarefaController on _TarefaControllerBase, Store {
  Computed<bool>? _$titleValidComputed;

  @override
  bool get titleValid =>
      (_$titleValidComputed ??= Computed<bool>(() => super.titleValid,
              name: '_TarefaControllerBase.titleValid'))
          .value;

  final _$blocoIdAtom = Atom(name: '_TarefaControllerBase.blocoId');

  @override
  int? get blocoId {
    _$blocoIdAtom.reportRead();
    return super.blocoId;
  }

  @override
  set blocoId(int? value) {
    _$blocoIdAtom.reportWrite(value, super.blocoId, () {
      super.blocoId = value;
    });
  }

  final _$titleAtom = Atom(name: '_TarefaControllerBase.title');

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

  final _$checkboxAtom = Atom(name: '_TarefaControllerBase.checkbox');

  @override
  bool get checkbox {
    _$checkboxAtom.reportRead();
    return super.checkbox;
  }

  @override
  set checkbox(bool value) {
    _$checkboxAtom.reportWrite(value, super.checkbox, () {
      super.checkbox = value;
    });
  }

  final _$_TarefaControllerBaseActionController =
      ActionController(name: '_TarefaControllerBase');

  @override
  void setBlocoId(int value) {
    final _$actionInfo = _$_TarefaControllerBaseActionController.startAction(
        name: '_TarefaControllerBase.setBlocoId');
    try {
      return super.setBlocoId(value);
    } finally {
      _$_TarefaControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTitle(String value) {
    final _$actionInfo = _$_TarefaControllerBaseActionController.startAction(
        name: '_TarefaControllerBase.setTitle');
    try {
      return super.setTitle(value);
    } finally {
      _$_TarefaControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCheckbox(bool value) {
    final _$actionInfo = _$_TarefaControllerBaseActionController.startAction(
        name: '_TarefaControllerBase.setCheckbox');
    try {
      return super.setCheckbox(value);
    } finally {
      _$_TarefaControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
blocoId: ${blocoId},
title: ${title},
checkbox: ${checkbox},
titleValid: ${titleValid}
    ''';
  }
}
