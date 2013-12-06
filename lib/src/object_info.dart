part of reflection;

abstract class ObjectInfo implements MirrorInfo {
  InstanceInfo get(Symbol name);

  InstanceInfo invoke(Symbol memberName, List positionalArguments, [Map<Symbol,dynamic> namedArguments]);

  InstanceInfo set(Symbol name, Object value);
}

class _ObjectInfo  extends _MirrorInfo implements ObjectInfo {
  ObjectMirror _mirror;

  _ObjectInfo({ObjectMirror mirror}) : super(mirror : mirror);

  InstanceInfo get(Symbol fieldName) {
    return new _InstanceInfo(mirror: _mirror.getField(fieldName));
  }

  InstanceInfo invoke(Symbol memberName, List positionalArguments, [Map<Symbol,dynamic> namedArguments]) {
    return new _InstanceInfo(mirror: _mirror.invoke(memberName, positionalArguments));
  }

  InstanceInfo set(Symbol fieldName, Object value) {
    return new _InstanceInfo(mirror: _mirror.setField(fieldName, value));
  }
}
