import 'package:result_pattern/result_pattern.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('value is Success', () {
    final result = Result.ok(42);

    test('is instanceOf Success', () {
      expect(result, isA<Ok>());
      expect(result.isOk, isTrue);
      expect(result.isErr, isFalse);
    });

    test('result equals', () {
      expect(result.unwrap(), 42);
    });

    test('with switch statement', () {
      final value = switch (result) {
        Ok(:final value) => value,
        Err(:final error) => throw error,
      };

      expect(value, 42);
    });

    test('result equals', () {
      expect(result.unwrapOr(0), 42);
    });

    test('result equals', () {
      expect(result.unwrapOrElse(() => 0), 42);
    });

    test('result equals', () {
      expect(result.inspect((value) => expect(value, 42)), result);
    });

    test('result with match', () {
      final value = result.match(
        ok: (value) => value,
        err: (error) => throw error,
      );

      expect(value, 42);
    });
  });

  group('result is Failure', () {
    final result = Result.err('error');

    test('is instanceOf Failure', () {
      expect(result, isA<Err>());
      expect(result.isOk, isFalse);
      expect(result.isErr, isTrue);
    });

    test('result equals', () {
      expect(
          () => result.unwrap(),
          throwsA(isA<Exception>()
              .having((e) => e.toString(), 'description', contains('error'))));
    });

    test('with switch statement', () {
      final error = switch (result) {
        Ok(:final unwrap) => unwrap(),
        Err(:final error) => error,
      };

      expect(error, 'error');
    });

    test('result equals', () {
      expect(result.unwrapOr(0), 0);
    });

    test('result equals', () {
      expect(result.unwrapOrElse(() => 0), 0);
    });

    test('result equals', () {
      expect(result.inspectErr((value) => expect(value, 'error')), result);
    });

    test('result with match', () {
      final value = result.match(
        err: (error) => error,
      );

      expect(value, 'error');
    });

    test('result with throwing match', () {
      expect(
          () => result.match(
                err: (error) => throw Exception(error),
              ),
          throwsA(isA<Exception>()));
    });

    test('result with throwing match and err not defined', () {
      expect(() => result.match(), throwsA(isA<Exception>()));
    });
  });
}
