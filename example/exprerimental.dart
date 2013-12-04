import 'package:reflection/reflection.dart';

void main() {
  var count = 1000000;
  var sw = new Stopwatch();
  var result1;
  var result2;
  var result3;
  sw.start();
  if(testNativeIs(count) != null) {
    sw.stop();
    result1 = sw.elapsedMilliseconds;
  }

  sw.reset();
  sw.start();
  if(testTypeInfoIs(count) != null) {
    sw.stop();
    result2 = sw.elapsedMilliseconds;
  }

  if(result1 > 0) {
    var slower = (result2 / result1).round();
    print("'TypeInfo.isA' slower then 'is' in $slower times");
  }
}

List testNativeIs(int count) {
  var list = new List(count);
  var runtimeType = list.runtimeType;
  for(var i = 0; i < count; i++) {
    list[i] = runtimeType is Iterable;
  }

  return list;
}

List testTypeInfoIs(int count) {
  var list = new List(count);
  var type1 = typeinfo(list.runtimeType);
  var type2 = typeinfo(Iterable);
  for(var i = 0; i < count; i++) {
    list[i] = type1.isA(type2);
  }

  return list;
}
