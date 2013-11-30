part of queries.reflection;

class MemberTypes {
  static const int ACCESSOR = 1;

  static const int CLASS = 2;

  static const int CONSTRUCTOR = 4;

  static const int METHOD = 8;

  static const int VARIABLE = 16;

  static const int ALL = (VARIABLE << 1) - 1;
}
