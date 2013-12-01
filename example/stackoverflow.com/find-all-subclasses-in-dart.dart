// http://stackoverflow.com/questions/16150437/find-all-subclasses-in-dart

import 'dart:io';
import 'package:reflection/reflection.dart';

void main() {
  var type = FileSystemEntity;
  var result = findAllSubclasses(type);
  var text = result.join("\r");
  print("==============================");
  print("Subclasses of '${type}'");
  print(text);
}

List<String> findAllSubclasses(Type type) {
  var childs = new List<String>();
  var typeMirror = TypeHelper.getTypeMirror(type);
  var typeMirrorOrig = typeMirror.originalDeclaration;
  var libraries = Reflection.getLibraries();
  for(var library in libraries.values) {
    var classes = MirrorLibrary.getClasses(library);
    for(var clazz in classes.values) {
      // Skip itself
      if(clazz.originalDeclaration == typeMirrorOrig) {
        continue;
      }

      if(MirrorType.isA(clazz, typeMirror)) {
        childs.add(SymbolHelper.getName(clazz.simpleName));
      }
    }
  }

  return childs;
}
