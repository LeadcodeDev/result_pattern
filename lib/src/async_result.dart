import 'package:result_pattern/result_pattern.dart';

typedef AsyncResult<T extends Object, E extends Object> = Future<Result<T, E>>;

extension AsyncResultExtension<T extends Object, E extends Object>
    on AsyncResult<T, E> {
  Future<T> unwrap() async {
    final result = await this;
    return result.unwrap();
  }

  Future<T> expect(String message) async {
    final result = await this;
    return result.expect(message);
  }
}
