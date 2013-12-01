import 'dart:mirrors';
import 'package:reflection/reflection.dart';

void main() {
  var me = reflect(new Foo());
  ClassMirror type = me.getField(#list).type;
  var iterableType = reflectType(Iterable);
  // obviously this work, since 'List' is 'Iterable'
  if(MirrorType.isA(type, iterableType)) {
    print("It works because 'List' is 'Iterable'");
  }
}

class Foo {
  List get list {
    return new List();
  }
}
