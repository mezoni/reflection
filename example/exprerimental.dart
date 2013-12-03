import 'dart:mirrors';
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

  sw.start();
  if(testTypeInfoIsType(count) != null) {
    sw.stop();
    result2 = sw.elapsedMilliseconds;
  }

  if(result1 > 0) {
    var slower = (result2 / result1).round();
    print("'TypeInfo.isA(Type)' slower then 'is' in $slower times");
  }

  sw.reset();
  sw.start();
  if(testTypeInfoIsTypeInfo(count) != null) {
    sw.stop();
    result2 = sw.elapsedMilliseconds;
  }

  if(result1 > 0) {
    var slower = (result2 / result1).round();
    print("'TypeInfo.isA(TypeInfo)' slower then 'is' in $slower times");
  }

  sw.reset();
  sw.start();
  if(testTypeInfoIsTypeMirror(count) != null) {
    sw.stop();
    result2 = sw.elapsedMilliseconds;
  }

  if(result1 > 0) {
    var slower = (result2 / result1).round();
    print("'TypeInfo.isA(TypeMirror)' slower then 'is' in $slower times");
  }
}

List testNativeIs(int count) {
  var list = new List(count);
  var runtimeType = list.runtimeType;
  for(var i = 0; i < count; i++) {
    // Prevent optimization
    list[i] = runtimeType is Iterable;
  }

  return list;
}

List testTypeInfoIsType(int count) {
  var list = new List(count);
  var listType = list.runtimeType;
  var listInfo = typeinfo(listType);
  for(var i = 0; i < count; i++) {
    // Prevent optimization
    list[i] = listInfo.isA(Iterable);
  }

  return list;
}

List testTypeInfoIsTypeInfo(int count) {
  var list = new List(count);
  var listType = list.runtimeType;
  var listInfo = typeinfo(listType);
  var iterableInfo = typeinfo(Iterable);
  for(var i = 0; i < count; i++) {
    // Prevent optimization
    list[i] = listInfo.isA(iterableInfo);
  }

  return list;
}

List testTypeInfoIsTypeMirror(int count) {
  var list = new List(count);
  var listType = list.runtimeType;
  var listInfo = typeinfo(listType);
  var iterableMirror = reflectType(Iterable);
  for(var i = 0; i < count; i++) {
    // Prevent optimization
    list[i] = listInfo.isA(iterableMirror);
  }

  return list;
}

