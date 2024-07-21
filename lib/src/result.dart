/// A type that represents either success ([Ok]) or failure ([Err]).
sealed class Result<T extends Object, E extends Object> {
  /// Returns true if the result is [Ok], otherwise false.
  bool get isOk => switch (this) { Ok() => true, Err() => false };

  /// Returns true if the result is [Err], otherwise false.
  bool get isErr => !isOk;

  /// Unwraps the result, yielding the content of an [Ok].
  ///
  /// Throws an exception if the result is an [Err], with a message provided by the [Err].
  T unwrap() => switch (this) {
        Ok(:final value) => value,
        Err(:final error) => throw Exception(error)
      };

  /// Unwraps a result, yielding the content of an [Ok].
  ///
  /// If the value is an [Err] then it returns [defaultValue].
  /// Throws an exception if the result is an [Err], with a message provided by the [Err].
  T unwrapOr(T defaultValue) {
    return switch (this) { Ok(:final value) => value, Err() => defaultValue };
  }

  /// Unwraps a result, yielding the content of an [Ok].
  T unwrapOrElse(T Function() fn) =>
      switch (this) { Ok(:final value) => value, Err() => fn() };

  /// Unwraps a result, yielding the content of an [Err].
  E unwrapErr() => switch (this) {
        Ok(:final value) => throw Exception(value),
        Err(:final error) => error
      };

  /// Unwraps a result, yielding the content of an [Err].
  T expect(String message) => switch (this) {
        Ok(:final value) => value,
        Err() => throw Exception(message)
      };

  /// Unwraps a result, yielding the content of an [Err].
  E expectErr(String message) => switch (this) {
        Ok(:final value) => throw Exception('$message : $value'),
        Err(:final error) => error
      };

  /// Maps a [Result<T, E>] to [Result<U, E>] by applying a function to a contained [Ok] value, leaving an [Err] value untouched.
  Result<T, E> inspect(void Function(T) fn) {
    if (this case Ok(:final value)) {
      fn(value);
    }

    return this;
  }

  /// Maps a [Result<T, E>] to [Result<T, F>] by applying a function to a contained [Err] value, leaving an [Ok] value untouched.
  Result<T, E> inspectErr(void Function(E) fn) {
    if (this case Err(:final error)) {
      fn(error);
    }

    return this;
  }

  @override
  String toString() => switch (this) {
        Ok(:final value) => 'Ok($value)',
        Err(:final error) => 'Err($error)'
      };

  const Result();

  /// Creates a [Result] containing a successful value.
  const factory Result.ok(T value) = Ok;

  /// Creates a [Result] containing an error value.
  const factory Result.err(E error) = Err;
}

/// Represents the successful result of a computation.
/// Contains the successful value.
final class Ok<T extends Object, E extends Object> extends Result<T, E> {
  final T value;

  const Ok(this.value);
}

/// Represents the failure result of a computation.
/// Contains the error value.
final class Err<T extends Object, E extends Object> extends Result<T, E> {
  final E error;

  const Err(this.error);
}
