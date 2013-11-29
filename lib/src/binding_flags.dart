part of reflection;

class BindingFlags {
  static const int INSTANCE = 1;

  static const int PRIVATE = 2;

  static const int PUBLIC = 4;

  static const int STATIC = 8;

  static const int ALL = ((STATIC << 1) - 1);
}
