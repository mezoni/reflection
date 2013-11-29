library reflection.example;

import 'package:reflection/reflection.dart';

void main() {
  var types = [Object, Animal, Zebra];
  for(var type in types) {
    var className = Reflection.typeGetQualifiedName(type);
    className = Reflection.symbolToString(className);
    print("=========================");
    print("Classs $className");
    var members = Reflection.typeGetMembers(type, flags: BindingFlags.PUBLIC, inherited: false);
    printMembers("Declared public members", members);

    members = Reflection.typeGetMembers(type, flags: BindingFlags.PUBLIC);
    printMembers("Declared and inherited public members", members);

    members = Reflection.typeGetMembers(type, flags: BindingFlags.PRIVATE, inherited: false);
    printMembers("Declared private members", members);

    members = Reflection.typeGetMembers(type, flags: BindingFlags.PRIVATE);
    printMembers("Declared and inherited private members", members);

    members = Reflection.typeGetContructors(type, flags: BindingFlags.PUBLIC);
    printMembers("Public constructors", members);

    members = Reflection.typeGetContructors(type, flags: BindingFlags.PRIVATE);
    printMembers("Private constructors", members);

    members = Reflection.typeGetMembers(type, flags: BindingFlags.STATIC);
    printMembers("Static members", members);
  }

  print("=========================");
  print("New instances");
  var foo = Reflection.typeNewInstance(Foo);
  var zero = Reflection.typeNewInstance(String, #fromCharCode, [48]);
  print("zero is $zero");

  print("=========================");
  var type1 = new TypeOf<Foo<int>>().type;
  var type2 = new TypeOf<Animal>().type;
  var instance = Reflection.typeNewInstance(type1);
  var result = instance is Animal;
  //printIs(type1, type2, result);

  type1 = new TypeOf<FooMixedAnimal<FooMixedAnimal>>().type;
  type2 = new TypeOf<Foo<Foo>>().type;
  instance = Reflection.typeNewInstance(type1);
  result = instance is Foo<Foo>;
  printIs(type1, type2, result);

  type1 = new TypeOf<FooMixedAnimal<FooMixedAnimal<FooMixedAnimal>>>().type;
  type2 = new TypeOf<Foo<Foo<Foo>>>().type;
  instance = Reflection.typeNewInstance(type1);
  result = instance is Foo<Foo<Foo>>;
  printIs(type1, type2, result);

  type1 = new TypeOf<Foo>().type;
  type2 = new TypeOf<Animal>().type;
  instance = Reflection.typeNewInstance(type1);
  result = instance is Animal;
  printIs(type1, type2, result);

  type1 = new TypeOf<Foo<int>>().type;
  type2 = new TypeOf<Foo<Object>>().type;
  instance = Reflection.typeNewInstance(type1);
  result = instance is Foo<Object>;
  printIs(type1, type2, result);

  type1 = new TypeOf<Foo<Object>>().type;
  type2 = new TypeOf<Foo<int>>().type;
  instance = Reflection.typeNewInstance(type1);
  result = instance is Foo<int>;
  printIs(type1, type2, result);

  type1 = new TypeOf<FooMixedAnimal<List<int>>>().type;
  type2 = new TypeOf<FooMixedAnimal<Iterable<Object>>>().type;
  instance = Reflection.typeNewInstance(type1);
  result = instance is FooMixedAnimal<Iterable<Object>>;
  printIs(type1, type2, result);

  type1 = new TypeOf<FooMixedAnimal<FooMixedAnimal<int>>>().type;
  type2 = new TypeOf<FooMixedAnimal<FooMixedAnimal<Object>>>().type;
  instance = Reflection.typeNewInstance(type1);
  result = instance is FooMixedAnimal<FooMixedAnimal<Object>>;
  printIs(type1, type2, result);

  type1 = new TypeOf<FooMixedAnimal<FooMixedAnimal<Foo>>>().type;
  type2 = new TypeOf<FooMixedAnimal<FooMixedAnimal<Animal>>>().type;
  instance = Reflection.typeNewInstance(type1);
  result = instance is FooMixedAnimal<FooMixedAnimal<Animal>>;
  printIs(type1, type2, result);

  type1 = new TypeOf<FooMixedAnimal<FooMixedAnimal<Foo<int>>>>().type;
  type2 = new TypeOf<FooMixedAnimal<FooMixedAnimal<Animal>>>().type;
  instance = Reflection.typeNewInstance(type1);
  result = instance is FooMixedAnimal<FooMixedAnimal<Animal>>;
  printIs(type1, type2, result);

  type1 = new TypeOf<FooMixedAnimal<FooMixedAnimal<FooMixedAnimal<int>>>>().type;
  type2 = new TypeOf<Foo<FooMixedAnimal<Foo<Object>>>>().type;
  instance = Reflection.typeNewInstance(type1);
  result = instance is FooMixedAnimal<FooMixedAnimal<Animal>>;
  printIs(type1, type2, result);

  type1 = new TypeOf<Foo_T_Extends_Foo>().type;
  type2 = new TypeOf<Foo>().type;
  instance = Reflection.typeNewInstance(type1);
  result = instance is Foo;
  printIs(type1, type2, result);

  type1 = new TypeOf<Foo_T_Extends_Foo_T>().type;
  type2 = new TypeOf<Foo>().type;
  instance = Reflection.typeNewInstance(type1);
  result = instance is Foo;
  printIs(type1, type2, result);
}

void printMembers(String title, Map declarations) {
  print(" ------------------------");
  print(" $title:");
  for(var declaration in declarations.values) {
    var name = Reflection.symbolToString(declaration.simpleName);
    print("  $name");
  }
}

void printIs(Type type, Type other, bool mustBe) {
  var isSubtype = Reflection.typeIs(type, other);
  var message = "${type} is ${other}: $isSubtype";
  if(isSubtype != mustBe) {
    throw new StateError("$message, must be $mustBe");
  }

  print(message);
}

class Animal {
  static List animals;

  int animal;

  int _animal;
}

class Zebra extends Animal {
  static List zebras;

  List _zebras;

  int _zebra;

  Zebra();

  Zebra._internal() {}
}

class TypeOf<T> {
  Type get type => T;
}

class Foo<T> extends Object {
}

class Foo_T_Extends_Foo<T> extends Foo {
}

class Foo_T_Extends_Foo_T<T> extends Foo<T> {
}

class FooMixedAnimal<T> extends Foo with Mixin<T>, Animal {
}

class Mixin<T> {
}
