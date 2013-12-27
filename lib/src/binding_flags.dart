part of reflection;

class BindingFlags {
  static const int _MASK_ALL = (512 << 1) - 1;

  static const BindingFlags DEFAULT = const BindingFlags("DEFAULT", 0);

  static const BindingFlags DECLARED_ONLY = const BindingFlags("DECLARED_ONLY", 1);

  static const BindingFlags GET_CLASS = const BindingFlags("GET_CLASS", 2);

  static const BindingFlags GET_CONSTRUCTOR = const BindingFlags("GET_CONSTRUCTOR", 4);

  static const BindingFlags GET_METHOD = const BindingFlags("GET_METHOD", 8);

  static const BindingFlags GET_PROPERTY = const BindingFlags("GET_PROPERTY", 16);

  static const BindingFlags GET_VARIABLE = const BindingFlags("GET_VARIABLE", 32);

  static const BindingFlags INSTANCE = const BindingFlags("INSTANCE", 64);

  static const BindingFlags PRIVATE = const BindingFlags("NON_PUBLIC", 128);

  static const BindingFlags PUBLIC = const BindingFlags("PUBLIC", 256);

  static const BindingFlags STATIC = const BindingFlags("STATIC", 512);

  final String name;

  final int value;

  const BindingFlags(this.name, this.value);

  static Map<String, BindingFlags> get values => const {
    "DEFAULT" : DEFAULT,
    "DECLARED_ONLY" : DECLARED_ONLY,
    "GET_CLASS" : GET_CLASS,
    "GET_CONSTRUCTOR" : GET_CONSTRUCTOR,
    "GET_METHOD" : GET_METHOD,
    "GET_PROPERTY" : GET_PROPERTY,
    "GET_VARIABLE" : GET_VARIABLE,
    "INSTANCE" : INSTANCE,
    "PRIVATE" : PRIVATE,
    "PUBLIC" : PUBLIC,
    "STATIC" : STATIC};

  bool operator ==(dynamic other) {
    if(identical(this, other)) {
      return true;
    }

    if(other is BindingFlags) {
      return value == other.value;
    } else if(other is int) {
      return value == other;
    } else {
      return false;
    }
  }

  BindingFlags operator ~() {
    return new BindingFlags("", (~value) & _MASK_ALL);
  }

  BindingFlags operator ^(dynamic other) {
    if(other is BindingFlags) {
      return new BindingFlags("", (this.value ^ other.value) & _MASK_ALL);
    } else {
      throw new ArgumentError("other: $other");
    }
  }

  BindingFlags operator &(dynamic other) {
    if(other is BindingFlags) {
      return new BindingFlags("", (this.value & other.value) & _MASK_ALL);
    } else {
      throw new ArgumentError("other: $other");
    }
  }

  BindingFlags operator |(dynamic other) {
    if(other is BindingFlags) {
      return new BindingFlags("", (this.value | other.value) & _MASK_ALL);
    } else {
      throw new ArgumentError("other: $other");
    }
  }

  String toString() {
    if(value == null) {
      return null.toString();
    }

    var list = <String>[];
    if(value == 0) {
      list.add(DEFAULT.name);
    } else {
      for(var value in values.values) {
        if(value.value == 0) {
          continue;
        }

        if((this.value & value.value) != 0) {
          list.add(value.name);
        }
      }
    }

    var rest = value & ~_MASK_ALL;
    if(rest != 0) {
      list.add("$rest");
    }

    return list.join(" | ");
  }
}
