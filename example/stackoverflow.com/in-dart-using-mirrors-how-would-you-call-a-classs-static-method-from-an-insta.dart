// http://stackoverflow.com/questions/20743346/in-dart-using-mirrors-how-would-you-call-a-classs-static-method-from-an-insta

import 'package:reflection/reflection.dart';

abstract class Junk {
  bool _fresh = true;
  bool get fresh => _fresh;
  void set fresh(fresh) { _fresh = fresh; }
}
class Hamburger extends Junk {
  static bool get lettuce => true;
}
class HotDog extends Junk {
  static bool get lettuce => false;
}

Junk food;

void main() {
  food = new Hamburger();
  var type = objectInfo(food).type;
  var lettuce = type.getProperty(#lettuce, BindingFlags.PUBLIC | BindingFlags.STATIC);
  print(lettuce.getValue());

  // Default: BindingFlags.PUBLIC | BindingFlags.INSTANCE
  var fresh = type.getProperty(#fresh);
  print(fresh.getValue(food));

  // Stale
  fresh.setValue(food, false);
  print(fresh.getValue(food));
}
