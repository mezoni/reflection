// http://stackoverflow.com/questions/16150437/find-all-subclasses-in-dart

import 'dart:io';
import 'package:reflection/reflection.dart';

void main() {
  var type = FileSystemEntity;
  var result = findAllSubclasses(typeInfo(type));
  var text = result.join("\r");
  print("==============================");
  print("Subclasses of '${type}'");
  print(text);
}

List<String> findAllSubclasses(TypeInfo type) {
  var typeOrig = type.originalDeclaration;
  var childs = MirrorSystemInfo.current.isolate.libraries.values
    .select((library) => library.getClasses(BindingFlags.PRIVATE | BindingFlags.PUBLIC).values)
    .selectMany((clazz) => clazz)
    .where((clazz) => clazz.isA(type) && clazz.originalDeclaration != typeOrig);
  return childs.toList();
}
