part of reflection;

abstract class PropertyInfo implements MethodBase {
  Symbol get fieldName;

  bool get isAbstract;

  bool get isGetter;

  bool get isSetter;

  bool get isStatic;

  PropertyInfo get getter;

  PropertyInfo get setter;

  Object getValue([Object object]);

  void setValue(Object object, dynamic value);
}

class _PropertyInfo extends _MethodBase implements PropertyInfo {
  static const int _FLAG_HAS_NO_GETTER = 1;

  static const int _FLAG_HAS_NO_SETTER = 2;

  Symbol _fieldName;

  int _flag = 0;

  PropertyInfo _getter;

  int _hashCode;

  MethodMirror _mirror;

  Symbol _name;

  PropertyInfo _setter;

  _PropertyInfo({TypeInfo declaringType, DeclarationMirror mirror, LibraryInfo library, DeclarationInfo owner}) : super(declaringType : declaringType, mirror : mirror, owner : owner) {
    if(!(_mirror.isGetter || _mirror.isSetter)) {
      throw new ArgumentError("mirror: '$mirror' is not a property");
    }
  }

  bool get isAbstract => _mirror.isAbstract;

  bool get isGetter => _mirror.isGetter;

  bool get isSetter => _mirror.isSetter;

  bool get isStatic => _mirror.isStatic;

  MemberTypes get memberType => MemberTypes.PROPERTY;

  MethodMirror get mirror => _mirror;

  Symbol get fieldName {
    if(_fieldName == null) {
      if(isGetter) {
        _fieldName = simpleName;
      } else {
        var name = SymbolHelper.getName(_mirror.simpleName);
        name = name.substring(0, name.length - 1);
        _fieldName = new Symbol(name);
      }
    }

    return _fieldName;
  }

  PropertyInfo get getter {
    if(_getter == null && (_flag & _FLAG_HAS_NO_GETTER) == 0) {
      if(isGetter) {
        _getter = this;
      } else {
        var name = SymbolHelper.getName(_mirror.simpleName);
        name = name.substring(0, name.length - 1);
        var getterName = new Symbol(name);
        if(owner is LibraryInfo || owner is TypeInfo) {
          var owner = this.owner;
          _getter = owner.getProperty(getterName, BindingFlags.PRIVATE | BindingFlags.PUBLIC | BindingFlags.INSTANCE | BindingFlags.STATIC);
        }

        if(_getter == null) {
          _flag |= _FLAG_HAS_NO_GETTER;
        }
      }
    }

    return _getter;
  }

  PropertyInfo get setter {
    if(_setter == null && (_flag & _FLAG_HAS_NO_SETTER) == 0) {
      if(isSetter) {
        _setter = this;
      } else {
        var name = SymbolHelper.getName(_mirror.simpleName);
        name = "$name=";
        var setterName = new Symbol(name);
        if(owner is LibraryInfo || owner is TypeInfo) {
          var owner = this.owner;
          _setter = owner.getProperty(setterName, BindingFlags.PRIVATE | BindingFlags.PUBLIC | BindingFlags.INSTANCE | BindingFlags.STATIC);
        }

        if(_setter == null) {
          _flag |= _FLAG_HAS_NO_SETTER;
        }
      }
    }

    return _setter;
  }

  Object getValue([Object object]) {
    if(!isGetter) {
      var getter = this.getter;
      if(getter == null) {
        throw new StateError("The property's get accessor is not found.");
      }

      return getter.getValue(object);
    }

    if(isStatic) {
      var mirror = owner.mirror;
      if(mirror is ObjectMirror) {
        return mirror.getField(simpleName).reflectee;
      }

    } else {
      if(object == null) {
        throw new StateError("The property is an instance property but 'object' is null");
      }

      var instance = objectInfo(object);
      if(owner is TypeInfo) {
        TypeInfo type = owner;
        if(!type.isAssignableFrom(instance.type)) {
          throw new StateError("The object does not match the target type");
        }
      }

      var mirror = instance.mirror;
      if(mirror is ObjectMirror) {
        return mirror.getField(simpleName).reflectee;
      }
    }

    throw new StateError("An error occurred while retrieving the property value");
  }

  void setValue(Object object, dynamic value) {
    if(!isSetter) {
      var setter = this.setter;
      if(setter == null) {
        throw new StateError("The property's set accessor is not found");
      }

      setter.setValue(object, value);
      return;
    }

    if(isStatic) {
      var mirror = owner.mirror;
      if(mirror is ObjectMirror) {
        mirror.setField(fieldName, value);
        return;
      }

    } else {
      if(object == null) {
        throw new StateError("The property is an instance property but 'object' is null");
      }

      var instance = objectInfo(object);
      if(owner is TypeInfo) {
        TypeInfo type = owner;
        if(!type.isAssignableFrom(instance.type)) {
          throw new StateError("The object does not match the target type");
        }
      }

      var mirror = instance.mirror;
      if(mirror is ObjectMirror) {
        mirror.setField(fieldName, value);
        return;
      }
    }

    throw new StateError("An error occurred while setting the property value");
  }
}
