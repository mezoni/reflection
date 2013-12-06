part of reflection;

abstract class MirrorSystemInfo {
  static final MirrorSystemInfo current = new _MirrorSystemInfo(mirror : currentMirrorSystem());

  IsolateInfo get isolate;

  MirrorSystem get mirror;
}

class _MirrorSystemInfo implements MirrorSystemInfo {
  IsolateInfo _isolate;

  MirrorSystem _mirror;

  _MirrorSystemInfo({MirrorSystem mirror}) {
    _mirror = mirror;
  }

  IsolateInfo get isolate {
    if(_isolate == null) {
      _isolate = new _IsolateInfo(mirror : _mirror.isolate, mirrorSystem : this);
    }

    return _isolate;
  }

  MirrorSystem get mirror => _mirror;
}
