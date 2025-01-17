import 'package:sentry/src/hint.dart';
import 'package:test/test.dart';

void main() {
  test('Hint init with map', () {
    final hint = Hint.withMap({'fixture-key': 'fixture-value'});
    expect("fixture-value", hint.get("fixture-key"));
  });

  test('Hint set value is returned with get', () {
    final hint = Hint();
    hint.set("hint1", "some string");

    expect("some string", hint.get("hint1"));
  });

  test('Hint get returns null if not contained', () {
    final hint = Hint();
    expect(hint.get("hint-does-not-exist"), null);
  });

  test('Hint set multiple times only keeps latest value', () {
    final hint = Hint();

    hint.set("hint1", "some string");
    hint.set("hint1", "a different string");

    expect("a different string", hint.get("hint1"));
  });

  test('Hint removed value is not returned by get', () {
    final hint = Hint();

    hint.set("hint1", "some string");
    expect("some string", hint.get("hint1"));

    hint.remove("hint1");
    expect(hint.get("hint1"), null);
  });

  test('Hint remove leaves other values', () {
    final hint = Hint();

    hint.set("hint1", "some string");
    expect("some string", hint.get("hint1"));
    hint.set("hint2", "another string");

    hint.remove("hint1");
    expect(hint.get("hint1"), null);
    expect("another string", hint.get("hint2"));
  });

  test('Hint clear removes all values', () {
    final hint = Hint();

    hint.set("hint1", "some string");
    hint.set("hint2", "another string");

    hint.clear();
    expect(hint.get("hint1"), null);
    expect(hint.get("hint2"), null);
  });
}
