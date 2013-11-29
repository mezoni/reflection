import 'dart:mirrors';
import 'package:reflection/reflection.dart';

class A {
}

main() {
  double d = 5.5;
  var t1 = reflect(d).type.reflectedType;
  //print(t1 == d.runtimeType);
  //print(t1 == double);
  print(Reflection.typeIs(t1, d.runtimeType));
  print(Reflection.typeIs(t1, double));

  String s = 'boo';
  var t2 = reflect(s).type.reflectedType;
  //print(t2 == s.runtimeType);
  //print(t2 == String);
  print(Reflection.typeIs(t2, s.runtimeType));
  print(Reflection.typeIs(t2, String));


  A a = new A();
  var t3 = reflect(a).type.reflectedType;
  //print(t3 == a.runtimeType);
  //print(t3 == A);
  print(Reflection.typeIs(t3, a.runtimeType));
  print(Reflection.typeIs(t3, A));
}
