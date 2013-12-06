part of reflection;

class MemberTypes2 {
  static const MemberTypes2 CLASS = const MemberTypes2("CLASS", 1);

  static const MemberTypes2 CONSTRUCTOR = const MemberTypes2("CONSTRUCTOR", 2);

  static const MemberTypes2 METHOD = const MemberTypes2("METHOD", 4);

  static const MemberTypes2 PROPERTY = const MemberTypes2("PROPERTY", 8);

  static const MemberTypes2 VARIABLE = const MemberTypes2("VARIABLE", 16);

  final String name;

  final int value;

  const MemberTypes2(this.name, this.value);

  static Map<String, MemberTypes2> get values {
    return new UnmodifiableMapView<String, MemberTypes2>(
      {CLASS.name : CLASS,
       CONSTRUCTOR.name : CONSTRUCTOR,
       METHOD.name : METHOD,
       PROPERTY.name : PROPERTY,
       VARIABLE.name : VARIABLE});
  }

  String toString() => name;
}
