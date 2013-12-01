// http://stackoverflow.com/questions/17395799/using-mirrors-how-can-i-get-a-reference-to-a-classs-method

import 'dart:mirrors';
import 'package:reflection/reflection.dart';

class Foo {
  @CoolMethod()
  a(s) {print("a says $s");}

  @CoolMethod()
  b(s) {print("b says $s");}
}

void main() {
  var f = new Foo();
  findByName(f);
  findByAnnotation(f);
}

void findByName(Foo foo) {
  var method = TypeHelper.getMethod(Foo, #a);
  var coolMethod = reflect(const CoolMethod());
  var metadata = method.metadata;
  if(method != null && method.metadata.contains(coolMethod)) {
    reflect(foo).invoke(#a, ["hello"]);
  }
}

void findByAnnotation(Foo foo) {
  var methods = TypeHelper.getMethods(Foo, flags: BindingFlags.PUBLIC | BindingFlags.INSTANCE);
  var coolMethod = reflect(const CoolMethod());
  for(var method in methods.values) {
    var metadata = method.metadata;
    if(method.metadata.contains(coolMethod)) {
      reflect(foo).invoke(method.simpleName, ["hello"]);
    }
  }
}

class CoolMethod {
  const CoolMethod();
}