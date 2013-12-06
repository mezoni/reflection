// http://stackoverflow.com/questions/20245748/reflecting-primitive-types-such-as-double-results-in-unexpected-output

import 'package:reflection/reflection.dart';

void main() {
  test("Double is num", () {
    double d = 10.1;
    var typeNum = typeInfo(num);
    expect(typeInfo(d.runtimeType).isA(typeNum), true, reason: "${d.runtimeType} is $num");
  });
}

void expect(dynamic expected, dynamic actual, {String reason}) {
  if(expected != actual) {
    var message = [];
    message.add("Expected: $expected");
    message.add("Actual: $actual");
    if(reason == null || reason.isEmpty) {
      message.add("Reason: $reason");
    }
    throw message.join("\n");
  }
}

void test(String name, action()) {
  try {
    action();
  } catch(e) {
    print("FAIL: $name");
  }
}
