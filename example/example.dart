library reflection.example;

import 'package:reflection/reflection.dart';

void main() {
  reflectLibraries();
  reflectDartCoreMembers();
  reflectTypeMembers();
  createInstances();
  testTypes();
}

void createInstances() {
  print("=========================");
  print("New instances");
  var foo = Reflection.typeNewInstance(Foo);
  var zero = Reflection.typeNewInstance(String, #fromCharCode, [48]);
  print("zero is $zero");
}

void reflectDartCoreMembers() {
  var library = Reflection.typeGetLibrary(Object);
  var members = Reflection.getClasses(library, flags: BindingFlags.PUBLIC);
  printMembers("Dart core public classes", members);
}

void reflectLibraries() {
  var library = Reflection.getRootLibrary();
  print("=========================");
  print("Root library");
  print(" name: ${Reflection.symbolToString(library.qualifiedName)}");
  print(" uri: ${library.uri}");

  var libraries = Reflection.getLibraries();
  for(var library in libraries.values) {
    print(" ------------------------");
    print(" name: ${Reflection.symbolToString(library.qualifiedName)}");
    print(" uri: ${library.uri}");
  }
}

void reflectTypeMembers() {
  var types = [Object, Animal, Zebra];
  for(var type in types) {
    var className = Reflection.typeGetQualifiedName(type);
    className = Reflection.symbolToString(className);
    print("=========================");
    print("Class $className");
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
}

void printIs(Type type, Type other, bool mustBe) {
  var isSubtype = Reflection.typeIs(type, other);
  var message = "${type} is ${other}: $isSubtype";
  if(isSubtype != mustBe) {
    throw new StateError("$message, must be $mustBe");
  }

  print(message);
}

void printMembers(String title, Map declarations) {
  print(" ------------------------");
  print(" $title:");
  for(var declaration in declarations.values) {
    var name = Reflection.symbolToString(declaration.simpleName);
    print("  $name");
  }
}

void testTypes() {
  print("=========================");
  // Foo<int> is Animal
  var type1 = new TypeOf<Foo<int>>().type;
  var type2 = new TypeOf<Animal>().type;
  var instance = Reflection.typeNewInstance(type1);
  var result = instance is Animal;
  //printIs(type1, type2, result);

  //
  type1 = new TypeOf<FooBoundC<C>>().type;
  type2 = new TypeOf<Foo<B>>().type;
  instance = Reflection.typeNewInstance(type1);
  result = instance is Animal;
  //printIs(type1, type2, result);

  // Foo<int> is Animal
  type1 = new TypeOf<Foo>().type;
  type2 = new TypeOf<Animal>().type;
  instance = Reflection.typeNewInstance(type1);
  result = instance is Animal;
  printIs(type1, type2, result);

  // FooMixedAnimal<FooMixedAnimal> is Foo<Foo>
  type1 = new TypeOf<FooMixedAnimal<FooMixedAnimal>>().type;
  type2 = new TypeOf<Foo<Foo>>().type;
  instance = Reflection.typeNewInstance(type1);
  result = instance is Foo<Foo>;
  printIs(type1, type2, result);

  // Foo<int> is Foo<Object>
  type1 = new TypeOf<Foo<int>>().type;
  type2 = new TypeOf<Foo<Object>>().type;
  instance = Reflection.typeNewInstance(type1);
  result = instance is Foo<Object>;
  printIs(type1, type2, result);

  // Foo<Object> is Foo<int>
  type1 = new TypeOf<Foo<Object>>().type;
  type2 = new TypeOf<Foo<int>>().type;
  instance = Reflection.typeNewInstance(type1);
  result = instance is Foo<int>;
  printIs(type1, type2, result);

  // FooMixedAnimal<List<int>> is FooMixedAnimal<Iterable<Object>>
  type1 = new TypeOf<FooMixedAnimal<List<int>>>().type;
  type2 = new TypeOf<FooMixedAnimal<Iterable<Object>>>().type;
  instance = Reflection.typeNewInstance(type1);
  result = instance is FooMixedAnimal<Iterable<Object>>;
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

class A {
}

class B extends A {
}


class C extends B {
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

class IFooBoundC<T extends C> extends Foo<T> {
}

class FooBoundC<T extends C> implements IFooBoundC<T> {
}

class Mixin<T> {
}
