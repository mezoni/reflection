// http://stackoverflow.com/questions/17631150/is-it-possible-to-get-a-class-mirror-by-name

import 'package:reflection/reflection.dart';

class User {
  String name = "John Smith";
}

class Question {}
class Answer {}

void main() {
  var library = MirrorSystemInfo.current.isolate.rootLibrary;
  var userType = library.getClass(#User);
  var user = userType.newInstance().reflectee;
  print(user.name);
}
