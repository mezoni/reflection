Reflection
==========

The reflection helper classes over the mirrors based reflection.

```dart
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
}

void printMembers(String title, Map declarations) {
  print(" ------------------------");
  print(" $title:");
  for(var declaration in declarations.values) {
    var name = Reflection.symbolToString(declaration.simpleName);
    print("  $name");
  }

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
```

Output:
```
=========================
Classs dart.core.Object
 ------------------------
 Declared public members:
  ==
  hashCode
  toString
  noSuchMethod
  runtimeType
  Object
 ------------------------
 Declared and inherited public members:
  ==
  hashCode
  toString
  noSuchMethod
  runtimeType
  Object
 ------------------------
 Declared private members:
  _hashCodeRnd
  _getHash
  _setHash
  _identityHashCode
  _toString
  _symbolMapToStringMap
  _cid
  _leftShiftWithMask32
 ------------------------
 Declared and inherited private members:
  _hashCodeRnd
  _getHash
  _setHash
  _identityHashCode
  _toString
  _symbolMapToStringMap
  _cid
  _leftShiftWithMask32
 ------------------------
 Public constructors:
  Object
 ------------------------
 Private constructors:
 ------------------------
 Static members:
  _hashCodeRnd
=========================
Classs reflection.example.Animal
 ------------------------
 Declared public members:
  animals
  animal
  Animal
 ------------------------
 Declared and inherited public members:
  ==
  hashCode
  toString
  noSuchMethod
  runtimeType
  Object
  animals
  animal
  Animal
 ------------------------
 Declared private members:
  _animal
 ------------------------
 Declared and inherited private members:
  _animal
 ------------------------
 Public constructors:
  Animal
 ------------------------
 Private constructors:
 ------------------------
 Static members:
  animals
=========================
Classs reflection.example.Zebra
 ------------------------
 Declared public members:
  zebras
  Zebra
 ------------------------
 Declared and inherited public members:
  ==
  hashCode
  toString
  noSuchMethod
  runtimeType
  Object
  animal
  Animal
  zebras
  Zebra
 ------------------------
 Declared private members:
  _zebras
  _zebra
  Zebra._internal
 ------------------------
 Declared and inherited private members:
  _animal
  _zebras
  _zebra
  Zebra._internal
 ------------------------
 Public constructors:
  Zebra
 ------------------------
 Private constructors:
  Zebra._internal
 ------------------------
 Static members:
  zebras

```