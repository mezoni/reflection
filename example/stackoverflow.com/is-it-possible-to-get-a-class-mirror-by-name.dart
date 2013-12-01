// http://stackoverflow.com/questions/17631150/is-it-possible-to-get-a-class-mirror-by-name

import 'package:reflection/reflection.dart';

class User {
  String name = "John Smith";
}

class Question {}
class Answer {}

void main() {
  var thisLibrary = Reflection.isolate.rootLibrary;
  var userMirror = MirrorLibrary.getClass(thisLibrary, #User);
  var userType = MirrorType.getType(userMirror);
  var user = TypeHelper.newInstance(userType);
  print(user.name);
}
