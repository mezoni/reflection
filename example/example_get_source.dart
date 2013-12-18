import 'package:reflection/reflection.dart';

void main() {
  var function = (x) => x + 1;
  ClosureInfo closure = objectInfo(function);
  print(closure.function.source);
}
