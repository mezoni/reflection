part of reflection;

abstract class LibraryInfo implements DeclarationInfo, HasMembers, Membership, ObjectInfo {
  int get id;

  IsolateInfo get isolate;

  LibraryMirror get mirror;

  Map<Symbol, TypeInfo> get types;

  Uri get uri;
}

class _LibraryInfo extends _DeclarationInfo implements LibraryInfo {
  int _hashCode;

  int _id;

  IsolateInfo _isolate;

  Map<Symbol, MemberInfo> _members;

  LibraryMirror _mirror;

  Map<Symbol, TypeInfo> _types;

  _LibraryInfo({int id, IsolateInfo isolate, LibraryMirror mirror}) : super(mirror : mirror) {
    _id = id;
    _mirror = mirror;
  }

  int get hashCode {
    if(_hashCode == null) {
      _hashCode = 0x8d6cb01f;
      _hashCode ^= _isolate.hashCode;
      _hashCode ^= _id.hashCode;
      _hashCode &= 0x7fffffff;
    }

    return _hashCode;
  }

  int get id => _id;

  IsolateInfo get isolate => _isolate;

  LibraryMirror get mirror => _mirror;

  Map<Symbol, MemberInfo> get members {
    if(_members == null) {
      var members = new Map<Symbol, MemberInfo>();
      for(var mirror in _mirror.declarations.values) {
        MemberInfo member;
        var unsupported = false;
        if(mirror is TypeMirror) {
          member = new _TypeInfo.fromMirror(mirror);
        } else if(mirror is MethodMirror) {
          if(mirror.isSetter || mirror.isGetter) {
            member = new _PropertyInfo(library: this, mirror: mirror, owner : this);
          } else if(mirror.isRegularMethod) {
            member = new _MethodInfo(library: this, mirror: mirror, owner : this);
          } else {
            unsupported = true;
          }
        } else if(mirror is ParameterMirror) {
          unsupported = true;
        } else if(mirror is VariableMirror) {
          member = new _VariableInfo(library: this, mirror: mirror, owner : this);
        } else {
          unsupported = true;
        }

        if(unsupported) {
          // throw new StateError("Unsupported declaration type '${mirror.runtimeType}'");
        } else {
          members[member.simpleName] = member;
        }
      }

      _members = new UnmodifiableMapView<Symbol, MemberInfo>(members);
    }

    return _members;
  }

  Map<Symbol, TypeInfo> get types {
    if(_types == null) {
      var types = new HashMap<Symbol, TypeInfo>();
      for(var declaration in _mirror.declarations.values) {
        if(declaration is TypeMirror) {
          types[declaration.simpleName] = new _TypeInfo(library : this, mirror : declaration);
        }
      }

      _types = new UnmodifiableMapView<Symbol, TypeInfo>(types);
    }

    return _types;
  }

  Uri get uri => _mirror.uri;

  bool operator == (other) {
    if(identical(this, other)) {
      return true;
    }

    if(other is LibraryInfo) {
      if(hashCode == other.hashCode) {
        return isolate == other.isolate && id == other.id;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  InstanceInfo get(Symbol fieldName) {
    return new _InstanceInfo(mirror: _mirror.getField(fieldName));
  }

  TypeInfo getClass(Symbol name, [BindingFlags2 bindingAttr]) {
    return _Membership.getClass(this, name, bindingAttr);
  }

  Map<Symbol, TypeInfo> getClasses([BindingFlags2 bindingAttr]) {
    return _Membership.getClasses(this, bindingAttr);
  }

  ConstructorInfo getConstructor(Symbol name, [BindingFlags2 bindingAttr]) {
    return _Membership.getConstructor(this, name, bindingAttr);
  }

  Map<Symbol, ConstructorInfo> getConstructors([BindingFlags2 bindingAttr]) {
    return _Membership.getConstructors(this, bindingAttr);
  }

  MemberInfo getMember(Symbol name, [BindingFlags2 bindingAttr]) {
    return _Membership.getMember(this, name, bindingAttr);
  }

  Map<Symbol, MemberInfo> getMembers([BindingFlags2 bindingAttr]) {
    return _Membership.getMembers(this, bindingAttr);
  }

  MethodInfo getMethod(Symbol name, [BindingFlags2 bindingAttr]) {
    return _Membership.getMethod(this, name, bindingAttr);
  }

  Map<Symbol, MethodInfo> getMethods([BindingFlags2 bindingAttr]) {
    return _Membership.getMethods(this, bindingAttr);
  }

  Map<Symbol, PropertyInfo> getProperties([BindingFlags2 bindingAttr]) {
    return _Membership.getProperties(this, bindingAttr);
  }

  PropertyInfo getProperty(Symbol name, [BindingFlags2 bindingAttr]) {
    return _Membership.getProperty(this, name, bindingAttr);
  }

  Map<Symbol, VariableInfo> getVariables([BindingFlags2 bindingAttr]) {
    return _Membership.getVariables(this, bindingAttr);
  }

  VariableInfo getVariable(Symbol name, [BindingFlags2 bindingAttr]) {
    return _Membership.getVariable(this, name, bindingAttr);
  }

  InstanceInfo invoke(Symbol memberName, List positionalArguments, [Map<Symbol,dynamic> namedArguments]) {
    return new _InstanceInfo(mirror: _mirror.invoke(memberName, positionalArguments));
  }

  InstanceInfo set(Symbol fieldName, Object value) {
    return new _InstanceInfo(mirror: _mirror.setField(fieldName, value));
  }
}
