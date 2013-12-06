part of reflection;

abstract class MemberInfo implements DeclarationInfo {
  LibraryInfo get library;

  TypeInfo get declaringType;

  MemberTypes get memberType;
}

abstract class _MemberInfo extends _DeclarationInfo implements MemberInfo {
  int _hashCode;

  TypeInfo _declaringType;

  LibraryInfo _library;

  _MemberInfo({TypeInfo declaringType, LibraryInfo library, DeclarationMirror mirror, DeclarationInfo owner}) : super(mirror : mirror, owner : owner) {
    _declaringType = declaringType;
    _library = library;
  }

  TypeInfo get declaringType => _declaringType;

  int get hashCode {
    if(_hashCode == null) {
      _hashCode = 0x3b625460;
      _hashCode ^= memberType.hashCode;
      _hashCode ^= owner.hashCode;
      _hashCode ^= simpleName.hashCode;
      _hashCode &= 0x7fffffff;
    }

    return _hashCode;
  }

  LibraryInfo get library => _library;

  bool operator == (other) {
    if(identical(this, other)) {
      return true;
    }

    if(other is MemberInfo) {
      if(hashCode == other.hashCode) {
        return memberType == other.memberType && owner == other.owner && simpleName == other.simpleName;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
