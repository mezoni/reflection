part of reflection;

class BindingFlags2 {
  static const int _MASK_ALL = (512 << 1) - 1;

  static const BindingFlags2 DEFAULT = const BindingFlags2("DEFAULT", 0);

  static const BindingFlags2 DECLARED_ONLY = const BindingFlags2("DECLARED_ONLY", 1);

  static const BindingFlags2 GET_CLASS = const BindingFlags2("GET_CLASS", 2);

  static const BindingFlags2 GET_CONSTRUCTOR = const BindingFlags2("GET_CONSTRUCTOR", 4);

  static const BindingFlags2 GET_METHOD = const BindingFlags2("GET_METHOD", 8);

  static const BindingFlags2 GET_PROPERTY = const BindingFlags2("GET_PROPERTY", 16);

  static const BindingFlags2 GET_VARIABLE = const BindingFlags2("GET_VARIABLE", 32);

  static const BindingFlags2 INSTANCE = const BindingFlags2("INSTANCE", 64);

  static const BindingFlags2 PRIVATE = const BindingFlags2("NON_PUBLIC", 128);

  static const BindingFlags2 PUBLIC = const BindingFlags2("PUBLIC", 256);

  static const BindingFlags2 STATIC = const BindingFlags2("STATIC", 512);

  final String name;

  final int value;

  const BindingFlags2(this.name, this.value);

  static final Map<String, BindingFlags2> values = new UnmodifiableMapView<String, BindingFlags2>({
    DEFAULT.name : DEFAULT,
    DECLARED_ONLY.name : DECLARED_ONLY,
    GET_CLASS.name : GET_CLASS,
    GET_CONSTRUCTOR.name : GET_CONSTRUCTOR,
    GET_METHOD.name : GET_METHOD,
    GET_PROPERTY.name : GET_PROPERTY,
    GET_VARIABLE.name : GET_VARIABLE,
    INSTANCE.name : INSTANCE,
    PRIVATE.name : PRIVATE,
    PUBLIC.name : PUBLIC,
    STATIC.name : STATIC});

  bool operator ==(dynamic other) {
    if(identical(this, other)) {
      return true;
    }

    if(other is BindingFlags2) {
      return value == other.value;
    } else if(other is int) {
      return value == other;
    } else {
      return false;
    }
  }

  BindingFlags2 operator ~() {
    return new BindingFlags2("", (~value) & _MASK_ALL);
  }

  BindingFlags2 operator ^(dynamic other) {
    if(other is BindingFlags2) {
      return new BindingFlags2("", (this.value ^ other.value) & _MASK_ALL);
    } else {
      throw new ArgumentError("other: $other");
    }
  }

  BindingFlags2 operator &(dynamic other) {
    if(other is BindingFlags2) {
      return new BindingFlags2("", (this.value & other.value) & _MASK_ALL);
    } else {
      throw new ArgumentError("other: $other");
    }
  }

  BindingFlags2 operator |(dynamic other) {
    if(other is BindingFlags2) {
      return new BindingFlags2("", (this.value | other.value) & _MASK_ALL);
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
