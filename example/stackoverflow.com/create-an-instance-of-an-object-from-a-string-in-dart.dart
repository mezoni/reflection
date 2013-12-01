// http://stackoverflow.com/questions/17181108/create-an-instance-of-an-object-from-a-string-in-dart

import 'package:reflection/reflection.dart';

void main() {
  var myClass = TypeHelper.newInstance(MyClass);
  var myJack = TypeHelper.newInstance(MyClass, #fromJack);
  var myJohn = TypeHelper.newInstance(MyClass, #fromName, ["John"]);
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
