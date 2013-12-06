part of reflection;

InstanceInfo objectInfo(dynamic object) {
  return new _InstanceInfo(mirror : reflect(object));
}

abstract class InstanceInfo implements ObjectInfo {
  bool get hasReflectee;

  InstanceMirror get mirror;

  dynamic get reflectee;

  TypeInfo get type;

  bool operator == (other);

  Function operator [](Symbol name);

  dynamic delegate(Invocation invocation);
}

class _InstanceInfo extends _ObjectInfo implements InstanceInfo {
  InstanceMirror _mirror;

  TypeInfo _type;

  _InstanceInfo({InstanceMirror mirror}) : super(mirror : mirror);

  bool get hasReflectee => _mirror.hasReflectee;

  dynamic get reflectee => _mirror.reflectee;

  TypeInfo get type {
    if(_type == null) {
      _type = new _TypeInfo.fromMirror(_mirror.type);
    }

    return _type;
  }

  bool operator == (other) {
    if(identical(this, other)) {
      return true;
    } else if(other is InstanceInfo) {
      return _mirror == other.mirror;
    } else {
      return false;
    }
  }

  Function operator [](Symbol name) {
    return _mirror[name];
  }

  dynamic delegate(Invocation invocation) {
    return _mirror.delegate(invocation);
  }
}
