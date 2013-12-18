part of reflection;

abstract class ClosureInfo implements InstanceInfo {
  MethodBase get function;

  InstanceInfo apply(List positionalArguments, [Map<Symbol, dynamic> namedArguments]);

  InstanceInfo findInContext(Symbol name, {ifAbsent: null});
}

class _ClosureInfo extends _InstanceInfo implements ClosureInfo {
  MethodBase _function;

  ClosureMirror _mirror;

  _ClosureInfo({ClosureMirror mirror}) : super(mirror : mirror);

  MethodInfo get function {
    if(_function == null) {
      _function = new _MethodBase.fromMirror(_mirror.function);
    }

    return _function;
  }

  InstanceInfo apply(List positionalArguments, [Map<Symbol, dynamic> namedArguments]) {
    return new _InstanceInfo.fromMirror(_mirror.apply(positionalArguments, namedArguments));
  }

  InstanceInfo findInContext(Symbol name, {ifAbsent: null}) {
    return new _InstanceInfo.fromMirror(_mirror.findInContext(name, ifAbsent : ifAbsent));
  }
}
