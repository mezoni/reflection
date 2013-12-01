// http://stackoverflow.com/questions/13205176/how-can-i-use-reflection-mirrors-to-access-the-method-names-in-a-dart-class

import 'package:reflection/reflection.dart';

void main() {
  var type = int;
  print("==========================");
  print("Class $type:");
  var methods = TypeHelper.getMethods(type);
  printMembers("All declared and inherited methods", methods);

  methods = TypeHelper.getMethods(type, inherited: false);
  printMembers("All declared methods", methods);

  methods = TypeHelper.getMethods(type, flags: BindingFlags.INSTANCE | BindingFlags.PUBLIC);
  printMembers("Public instance methods", methods);

  methods = TypeHelper.getMethods(type, flags: BindingFlags.INSTANCE | BindingFlags.PRIVATE);
  printMembers("Private instance methods", methods);

  methods = TypeHelper.getMethods(type, flags: BindingFlags.STATIC);
  printMembers("Static methods", methods);
}

void printMembers(String title, Map declarations) {
  print(" ------------------------");
  print(" $title:");
  for(var declaration in declarations.values) {
    var name = SymbolHelper.getName(declaration.simpleName);
    print("  $name");
  }
}
