// http://stackoverflow.com/questions/19187197/how-to-quickly-test-if-a-typemirror-is-a-subtype-of-another

import 'package:reflection/reflection.dart';

void main() {
  var me = objectInfo(new Foo());
  var type = me.get(#list).type;
  var iterableType = typeInfo(Iterable);
  // obviously this work, since 'List' is 'Iterable'
  if(type.isA(iterableType)) {
    print("It works because 'List' is 'Iterable'");
  }
}

class Foo {
  List get list {
    return new List();
  }
}
