import 'package:reflection/reflection.dart';

void main() {
  isA();
}

void isA() {
  print("=========================");
  var type1 = new TypeOf<List<int>>().type;
  var type2 = new TypeOf<Iterable<Object>>().type;
  var instance = TypeHelper.newInstance(type1);
  var result = instance is Iterable<Object>;
  //printIs(type1, type2, result);

  instance = "";
  type1 = instance.runtimeType;
  type2 = new TypeOf<Comparable<String>>().type;
  result = instance is Comparable<String>;
  printIs(type1, type2, result);

  type1 = new TypeOf<List<int>>().type;
  type2 = new TypeOf<Iterable>().type;
  instance = TypeHelper.newInstance(type1);
  result = instance is Iterable;
  printIs(type1, type2, result);

  type1 = new TypeOf<int>().type;
  type2 = new TypeOf<num>().type;
  instance = 0;
  result = instance is num;
  printIs(type1, type2, result);

  instance = const {};
  type1 = instance.runtimeType;
  type2 = new TypeOf<Map>().type;
  result = instance is Map;
  printIs(type1, type2, result);

  instance = "";
  type1 = instance.runtimeType;
  type2 = new TypeOf<Comparable<String>>().type;
  result = instance is Comparable<String>;
  printIs(type1, type2, result);
}

void printIs(Type type, Type other, bool mustBe) {
  var isSubtype = TypeHelper.isA(type, other);
  var message = "${type} is ${other}: $isSubtype";
  if(isSubtype != mustBe) {
    throw new StateError("$message, must be $mustBe");
  }

  print(message);
}

class TypeOf<T> {
  Type get type => T;
}
