// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Country extends Country {
  @override
  final String name;
  @override
  final String code;

  factory _$Country([void Function(CountryBuilder) updates]) =>
      (new CountryBuilder()..update(updates)).build();

  _$Country._({this.name, this.code}) : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('Country', 'name');
    }
    if (code == null) {
      throw new BuiltValueNullFieldError('Country', 'code');
    }
  }

  @override
  Country rebuild(void Function(CountryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CountryBuilder toBuilder() => new CountryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Country && name == other.name && code == other.code;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, name.hashCode), code.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Country')
          ..add('name', name)
          ..add('code', code))
        .toString();
  }
}

class CountryBuilder implements Builder<Country, CountryBuilder> {
  _$Country _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _code;
  String get code => _$this._code;
  set code(String code) => _$this._code = code;

  CountryBuilder();

  CountryBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _code = _$v.code;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Country other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Country;
  }

  @override
  void update(void Function(CountryBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Country build() {
    final _$result = _$v ?? new _$Country._(name: name, code: code);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
