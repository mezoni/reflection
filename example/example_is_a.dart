import 'package:reflection/reflection.dart';

void main() {
  isA();
}

void isA() {
  print("=========================");
  var type1 = typeInfo(new TypeOf<List<int>>().type);
  var type2 = typeInfo(new TypeOf<Iterable<Object>>().type);
  var instance = type1.newInstance().reflectee;
  var result = instance is Iterable<Object>;
  printIs(type1, type2, result);

  instance = "";
  type1 = typeInfo(instance.runtimeType);
  type2 = typeInfo(new TypeOf<Comparable<String>>().type);
  result = instance is Comparable<String>;
  printIs(type1, type2, result);

  type1 = typeInfo(new TypeOf<List<int>>().type);
  type2 = typeInfo(new TypeOf<Iterable>().type);
  instance = type1.newInstance().reflectee;
  result = instance is Iterable;
  printIs(type1, type2, result);

  type1 = typeInfo(new TypeOf<int>().type);
  type2 = typeInfo(new TypeOf<num>().type);
  instance = 0;
  result = instance is num;
  printIs(type1, type2, result);

  instance = const {};
  type1 = typeInfo(instance.runtimeType);
  type2 = typeInfo(new TypeOf<Map>().type);
  result = instance is Map;
  printIs(type1, type2, result);

  instance = "";
  type1 = typeInfo(instance.runtimeType);
  type2 = typeInfo(new TypeOf<Comparable<String>>().type);
  result = instance is Comparable<String>;
  printIs(type1, type2, result);

  type1 = typeInfo(new TypeOf<Test<String, int>>().type);
  type2 = typeInfo(new TypeOf<Mixin2<int>>().type);
  instance = type1.newInstance().reflectee;
  result = instance is Mixin2<int>;
  printIs(type1, type2, result);

  type1 = MirrorSystemInfo.current.isolate.libraries.values
    .first((l) => l.simpleName == const Symbol("dart.core"))
    .getClass(#Map);
  type2 = typeInfo(Map);
  result = false;
  printIs(type1, type2, result);
}

void printIs(TypeInfo type, TypeInfo other, bool mustBe) {
  var isSubtype = type.isA(other);
  var message = "${type} is ${other}: $isSubtype";
  if(isSubtype != mustBe) {
    throw new StateError("$message, must be $mustBe");
  }

  print(message);
}

class TypeOf<T> {
  Type get type => T;
}

class Test<T1, T2> extends Object with Mixin1<T1>, Mixin2<T2> {
}

class Mixin1<T> {
}

class Mixin2<T> {
}
