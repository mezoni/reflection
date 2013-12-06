// http://stackoverflow.com/questions/17181108/create-an-instance-of-an-object-from-a-string-in-dart

import 'package:reflection/reflection.dart';

void main() {
  var type = typeInfo(MyClass);
  var myClass = type.newInstance().reflectee;
  var myJack = type.newInstance(#fromJack).reflectee;
  var myJohn = type.newInstance(#fromName, ["John"]).reflectee;
  myClass.sayHello();
  myJack.sayHello();
  myJohn.sayHello();
}

class MyClass {
  var name = "friend";

  MyClass();

  MyClass.fromName(this.name);

  MyClass.fromJack() {
    name = "Jack";
  }

  void sayHello() {
    print("Hello $name");
  }
}
