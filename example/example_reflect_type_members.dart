import 'package:reflection/reflection.dart';

void main() {
  reflectTypeMembers();
}

void reflectTypeMembers() {
  var types = <Type>[Base, Child];
  for(var type in types) {
    var className = TypeHelper.getQualifiedName(type);
    className = SymbolHelper.getName(className);
    print("=========================");
    print("Class $className:");
    var members = TypeHelper.getMembers(type, flags: BindingFlags.PUBLIC, inherited: false, members: MemberTypes.ALL);
    printMembers("Declared public members", members);

    members = TypeHelper.getMembers(type, flags: BindingFlags.PUBLIC, members: MemberTypes.ALL);
    printMembers("Declared and inherited public members", members);

    members = TypeHelper.getMembers(type, flags: BindingFlags.PRIVATE, inherited: false, members: MemberTypes.ALL);
    printMembers("Declared private members", members);

    members = TypeHelper.getMembers(type, flags: BindingFlags.PRIVATE, members: MemberTypes.ALL);
    printMembers("Declared and inherited private members", members);

    members = TypeHelper.getContructors(type, flags: BindingFlags.PUBLIC);
    printMembers("Public constructors", members);

    members = TypeHelper.getContructors(type, flags: BindingFlags.PRIVATE);
    printMembers("Private constructors", members);

    members = TypeHelper.getMembers(type, flags: BindingFlags.PUBLIC | BindingFlags.STATIC);
    printMembers("Public static members", members);

    members = TypeHelper.getMembers(type, flags: BindingFlags.PRIVATE | BindingFlags.STATIC);
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
