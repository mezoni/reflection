// http://stackoverflow.com/questions/13205176/how-can-i-use-reflection-mirrors-to-access-the-method-names-in-a-dart-class

import 'package:reflection/reflection.dart';

void main() {
  var type = typeInfo(int);
  print("==========================");
  print("Class $type:");
  var methods = type.getMethods();
  printMembers("All declared and inherited methods", methods);

  methods = type.getMethods(BindingFlags.PUBLIC | BindingFlags.PRIVATE | BindingFlags.INSTANCE | BindingFlags.PUBLIC | BindingFlags.STATIC | BindingFlags.DECLARED_ONLY);
  printMembers("All declared methods", methods);

  methods = type.getMethods(BindingFlags.PUBLIC | BindingFlags.INSTANCE);
  printMembers("Public instance methods", methods);

  methods = type.getMethods(BindingFlags.PRIVATE | BindingFlags.INSTANCE);
  printMembers("Private instance methods", methods);

  methods = type.getMethods(BindingFlags.PUBLIC | BindingFlags.PRIVATE | BindingFlags.STATIC);
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
