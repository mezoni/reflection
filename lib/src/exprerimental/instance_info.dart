part of reflection;

abstract class InstanceInfo {
  InstanceMirror get mirror;
}

class _InstanceInfo implements InstanceInfo {
  InstanceMirror _mirror;

  _InstanceInfo({InstanceMirror mirror}) {
    _mirror = mirror;
  }

  InstanceMirror get mirror => _mirror;
}
