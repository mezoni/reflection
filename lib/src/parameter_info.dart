part of reflection;

abstract class ParameterInfo implements VariableInfo {
  InstanceInfo get defaultValue;

  bool get isOptional;

  bool get isNamed;

  bool get hasDefaultValue;

  ParameterMirror get mirror;

  MethodBase get method;
}

class _ParameterInfo extends _VariableInfo implements ParameterInfo {
  InstanceInfo _defaultValue;

  ParameterMirror _mirror;

  _ParameterInfo({TypeInfo declaringType, LibraryInfo library, DeclarationMirror mirror, MethodBase owner})  : super (declaringType : declaringType, library : library, mirror : mirror, owner : owner);

  InstanceInfo get defaultValue {
    if(_defaultValue == null) {
      _defaultValue = new _InstanceInfo(mirror: _mirror.defaultValue);
    }

    return _defaultValue;
  }

  bool get isOptional => _mirror.isOptional;

  bool get isNamed => _mirror.isNamed;

  bool get hasDefaultValue => _mirror.hasDefaultValue;

  MethodBase get method => _owner;

  ParameterMirror get mirror => _mirror;
}
