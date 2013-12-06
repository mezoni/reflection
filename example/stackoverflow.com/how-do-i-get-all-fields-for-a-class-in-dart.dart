// http://stackoverflow.com/questions/17021327/how-do-i-get-all-fields-for-a-class-in-dart

import 'package:reflection/reflection.dart';

void main() {
  reflectTypeMembers();
}

void reflectTypeMembers() {
  var types = <TypeInfo>[typeInfo(Base), typeInfo(Child)];
  for(TypeInfo type in types) {
    var className = SymbolHelper.getName(type.qualifiedName);
    print("=========================");
    print("Class $className:");
    var members = type.getMembers(BindingFlags2.PUBLIC | BindingFlags2.INSTANCE | BindingFlags2.STATIC | BindingFlags2.DECLARED_ONLY);
    printMembers("Declared public members", members);

    members = type.getMembers();
    printMembers("Declared and inherited public members", members);

    members = type.getMembers(BindingFlags2.PRIVATE | BindingFlags2.INSTANCE | BindingFlags2.STATIC | BindingFlags2.DECLARED_ONLY);
    printMembers("Declared private members", members);

    members = type.getMembers(BindingFlags2.PRIVATE | BindingFlags2.INSTANCE | BindingFlags2.STATIC);
    printMembers("Declared and inherited private members", members);

    members = type.getConstructors();
    printMembers("Public constructors", members);

    members = type.getConstructors(BindingFlags2.PRIVATE);
    printMembers("Private constructors", members);

    members = type.getMembers(BindingFlags2.PUBLIC | BindingFlags2.STATIC);
    printMembers("Public static members", members);

    members = type.getMembers(BindingFlags2.PRIVATE | BindingFlags2.STATIC);
    printMembers("Private static members", members);
  }
}

void printMembers(String title, Map declarations) {
  print(" ------------------------");
  print(" $title:");
  for(var declaration in declarations.values) {
    var name = SymbolHelper.getName(declaration.simpleName);
    print("  $name");
  }
}

class Base {
  static Object baseStatic;

  static Object _baseStatic;

  Base();

  Base._internal();

  Object base;

  Object _base;
}

class Child extends Base {
  static Object childStatic;

  static Object _childStatic;

  Child();

  Child._internal();

  Object child;

  Object _child;
}
