# Result Pattern

The `Result Pattern` package for Dart provides a robust way of handling operations that may succeed or fail.
By encapsulating the result of an operation in a `Result` object, this package allows developers to write code that is
more predictable, safer, easier to understand and maintain.

## Benefits

- **Improved error handling**: Encapsulates success and failure results in a single, predictable type.
  predictable type.
- **Cleaner code**: Reduces the need for try-catch blocks, making the code base cleaner and more readable.
- **Composable**: Makes it easy to chain several operations together and manage their results in a unified way.

## Installation

Add `result_pattern` to your `pubspec.yaml` file:

```bash
dart pub add result_pattern
```

## Utilisation

### Basique

```dart
import 'package:result_pattern/result_pattern.dart';

void main() {
  final result = Result.ok(42);
  expect(result.unwrap(), 42);

  final value = switch (result) {
    Ok(:final value) => value,
    Err(:final error) => throw error,
  };

  expect(value, 42);
}
```

### Future usage

```dart
import 'package:result_pattern/result_pattern.dart';

AsyncResult<int, Exception> getOkResult() => Result.ok(42);

Future<void> main() async {
  expect(await future.unwrap(), 42);

  // Use pattern matching to extract the value or throw an error
  final value = switch (await future) {
    Ok(:final value) => value,
    Err(:final error) => throw error,
  };

  // Use the match method to handle error cases
  final value = await getOkResult()
    .expect('Error message');

  expect(value, 42);
}
```

## Contribution

Contributions are welcome!
Feel free to submit a pull request or open an issue if you have suggestions or find bugs.

## License

This package is licensed under the MIT license. See the LICENSE file for more details.
