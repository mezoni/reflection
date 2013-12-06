// http://stackoverflow.com/questions/14384865/how-can-i-get-the-concrete-type-of-a-generic-type-variable-using-mirrors-in-dart

import 'dart:io';
import 'package:reflection/reflection.dart';

void main() {
  var myList = new List<File>();
  var type1 = typeInfo(myList.runtimeType);
  var type2 = typeInfo(getTypeOfMyInterest());
  print(type1.isA(type2));
}

// Return "List<FileSystemEntity>"
Type getTypeOfMyInterest() {
  return new TypeOf<List<FileSystemEntity>>().type;
}

class TypeOf<T> {
  Type get type => T;
}
