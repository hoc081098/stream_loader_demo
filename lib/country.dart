import 'package:built_value/built_value.dart';

part 'country.g.dart';

abstract class Country implements Built<Country, CountryBuilder> {
  String get name;

  String get code;

  Country._();

  factory Country([void Function(CountryBuilder) updates]) = _$Country;
}
