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
  var childs = new List<String>();
  var typeOrig = type.originalDeclaration;
  var libraries = MirrorSystemInfo.current.isolate.libraries;
  for(var library in libraries.values) {
    var classes = library.getClasses(BindingFlags2.PRIVATE | BindingFlags2.PUBLIC);
    for(var clazz in classes.values) {
      // Skip itself
      if(clazz.originalDeclaration == typeOrig) {
        continue;
      }

      if(clazz.isA(type)) {
        childs.add(SymbolHelper.getName(clazz.simpleName));
      }
    }
  }

  return childs;
}
