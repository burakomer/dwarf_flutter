

class DatabaseResult {
  static String delimiter = "|";

  static DatabaseResult ok([dynamic message = ""]) => OKresult(message);
  static DatabaseResult error([String message = ""]) => ERRORresult(message);
  static DatabaseResult list<M>([List<M> list = const []]) => LISTresult<M>(list);

  final dynamic arguments;

  DatabaseResult(
    this.arguments,
  );
}

class OKresult extends DatabaseResult {
  OKresult(arguments) : super(arguments);
}
class ERRORresult extends DatabaseResult {
  ERRORresult(arguments) : super(arguments);

  String get message => arguments as String;
}
class LISTresult<M> extends DatabaseResult {
  LISTresult(List<M> list) : super(list);

  List<M> get modelList => arguments as List<M>;
}
