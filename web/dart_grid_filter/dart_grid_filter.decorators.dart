import 'dart:async';
import '../models/user.model.dart';

class DartGridFilter<T> {
  Stream<T> applyTo(Stream<T> stream) {
    return stream;
  }
}

class GenderDartGridFilterDecorator extends DartGridFilter<User> {
  DartGridFilter<User> _decoratedFilter;
  String _value;
  GenderDartGridFilterDecorator(String value, DartGridFilter<User> decoratedFilter) {
    this._decoratedFilter = decoratedFilter;
    this._value = value;
  }

  @override
  Stream<User> applyTo(Stream<User> list) {
      return this._decoratedFilter.applyTo(list)
        .where((User user)=>user.gender == this._value);
  }
}

class DepartmentDartGridFilterDecorator extends DartGridFilter<User> {
  DartGridFilter<User> _decoratedFilter;
  String _value;
  DepartmentDartGridFilterDecorator(String value, DartGridFilter<User> decoratedFilter) {
    this._decoratedFilter = decoratedFilter;
    this._value = value;
  }

  @override
  Stream<User> applyTo(Stream<User> list) {
      return this._decoratedFilter.applyTo(list)
        .where((User user)=>user.department == this._value);
  }
}


class CityDartGridFilterDecorator extends DartGridFilter<User> {
  DartGridFilter<User> _decoratedFilter;
  String _value;
  CityDartGridFilterDecorator(String value, DartGridFilter<User> decoratedFilter) {
    this._decoratedFilter = decoratedFilter;
    this._value = value;
  }

  @override
  Stream<User> applyTo(Stream<User> list) {
      return this._decoratedFilter.applyTo(list)
        .where((User user)=>user.address?.city == this._value);
  }
}
