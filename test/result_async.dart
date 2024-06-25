import 'package:result_pattern/result_pattern.dart';
import 'package:result_pattern/src/async_result.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  AsyncResult<int, Exception> getOkResult() async => Result.ok(42);

  group('async value is Success', () {
    final future = getOkResult();

    test('is instanceOf Success', () async {
      final result = await future;

      expect(result, isA<Ok>());
      expect(result.isOk, isTrue);
      expect(result.isErr, isFalse);
    });

    test('result equals', () async {
      expect(await future.unwrap(), 42);
    });
  });
}
