part of reflection;

class MemberTypes {
  static const MemberTypes CLASS = const MemberTypes("CLASS", 1);

  static const MemberTypes CONSTRUCTOR = const MemberTypes("CONSTRUCTOR", 2);

  static const MemberTypes METHOD = const MemberTypes("METHOD", 4);

  static const MemberTypes PROPERTY = const MemberTypes("PROPERTY", 8);

  static const MemberTypes VARIABLE = const MemberTypes("VARIABLE", 16);

  final String name;

  final int value;

  const MemberTypes(this.name, this.value);

  static Map<String, MemberTypes> get values => const {
    "CLASS" : CLASS,
    "CONSTRUCTOR" : CONSTRUCTOR,
    "METHOD" : METHOD,
    "PROPERTY" : PROPERTY,
    "VARIABLE" : VARIABLE};

  String toString() => name;
}
