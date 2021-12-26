
abstract class FbEvent{}

class IfUserExistsEvent extends FbEvent{
  final String uid;
  IfUserExistsEvent(this.uid);
}

