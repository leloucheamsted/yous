/// A mixin that provides a `debugName` property to a class.
/// This is useful for logging and debugging purposes.
///
/// Please note that Type and runtimeType are a very bad choice
/// for a debugName, as they can be obfuscated in production mode.
mixin Debuggable {
  String get debugName;
}
