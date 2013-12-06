part of reflection;

abstract class DeclarationInfo implements MirrorInfo {
  DeclarationMirror get declaration;

  bool get isPrivate;

  bool get isTopLevel;

  List<InstanceInfo> get metadata;

  DeclarationInfo get owner;

  Symbol get qualifiedName;

  Symbol get simpleName;
}

class _DeclarationInfo extends _MirrorInfo implements DeclarationInfo {
  List<InstanceInfo> _metadata;

  DeclarationMirror _mirror;

  DeclarationInfo _owner;

  _DeclarationInfo({DeclarationMirror mirror, DeclarationInfo owner}) : super (mirror : mirror) {
    _owner = owner;
  }

  DeclarationMirror get declaration => _mirror;

  bool get isPrivate => _mirror.isPrivate;

  bool get isTopLevel => _mirror.isTopLevel;

  List<InstanceInfo> get metadata {
    if(_metadata == null) {
      List<InstanceInfo> metadata = new List<InstanceInfo>();
      for(var instance in _mirror.metadata) {
        metadata.add(new _InstanceInfo(mirror: instance));
      }

      _metadata = new UnmodifiableListView(metadata);
    }

    return _metadata;
  }

  DeclarationInfo get owner => _owner;

  Symbol get qualifiedName => _mirror.qualifiedName;

  Symbol get simpleName => _mirror.simpleName;

  String toString() => SymbolHelper.getName(_mirror.simpleName);
}
