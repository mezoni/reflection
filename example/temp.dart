import 'package:reflection/reflection.dart';

void main() {
  classIncludesMixin1(AClass, MyMixin);
  classIncludesMixin1(BClass, MyMixin);
  classIncludesMixin2(new AClass(), MyMixin);
  classIncludesMixin2(new BClass(), MyMixin);
}

classIncludesMixin1(Type type, Type mixin) {
  var ti1 = typeInfo(type);
  var ti2 = typeInfo(mixin);
  print(ti1.isA(ti2));
}

classIncludesMixin2(Object object, Type mixin) {
  classIncludesMixin1(object.runtimeType, mixin);
}

class MyMixin{}

class AClass extends Object with MyMixin {}
class BClass extends Object {}
