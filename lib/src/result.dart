sealed class Result<T extends Object, E extends Object> {
  bool get isOk => switch (this) {
    Ok() => true,
    Err() => false
  };

  bool get isErr => !isOk;

  T unwrap() => switch (this) {
    Ok(:final value) => value,
    Err(:final error) => throw Exception(error)
  };

  T unwrapOr(T defaultValue) => switch (this) {
    Ok(:final value) => value,
    Err() => defaultValue
  };
  T unwrapOrElse(T Function() fn) => switch (this) {
    Ok(:final value) => value,
    Err() => fn()
  };

  E unwrapErr() => switch (this) {
    Ok(:final value) => throw Exception(value),
    Err(:final error) => error
  };

  T expect(String message) => switch (this) {
    Ok(:final value) => value,
    Err(:final error) => throw Exception('$message : $error')
  };

  E expectErr(String message) => switch (this) {
    Ok(:final value) => throw Exception('$message : $value'),
    Err(:final error) => error
  };

  Result<T, E> inspect(void Function(T) fn) {
    if (this case Ok(:final value)) {
      fn(value);
    }

    return this;
  }

  Result<T, E> inspectErr(void Function(E) fn) {
    if (this case Err(:final error)) {
      fn(error);
    }

    return this;
  }

  @override
  String toString() => switch (this) {
    Ok(:T value) => 'Ok($value)',
    Err(:E error) => 'Err($error)'
  };

  const Result();
  const factory Result.ok(T value) = Ok;
  const factory Result.err(E error) = Err;
}

final class Ok<T extends Object, E extends Object> extends Result<T, E> {
  final T value;

  const Ok(this.value);
}

final class Err<T extends Object, E extends Object> extends Result<T, E> {
  final E error;

  const Err(this.error);
}
