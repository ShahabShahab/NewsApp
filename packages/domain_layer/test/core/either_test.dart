import 'package:domain_layer/src/core/either.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group("Either sanity checks and some integrity issues", () {
    test("can create a left and right with distinct generic types", () {
      //arrange

      final left = Left<String, int>();
      final right = Right<String, int>();

      //act

      //assert

      expect(left, isA<Either>());
      expect(left, isA<Left<String, int>>());

      expect(right, isA<Either>());
      expect(right, isA<Right<String, int>>());
    });

    test("left and right can hold a value", () {
      //arrange

      final left = Left<String, int>(value: "failed");
      final right = Right<String, int>(value: 12);

      //act
      final leftValue = left.value;
      final rightValue = right.value;

      //assert
      expect(leftValue, equals("failed"));
      expect(rightValue, equals(12));
    });

    test("integrity of the types of left and right types", () {
      //arrange
      const left = Left<String, int>(value: 'oops');
      const right = Right<String, int>(value: 99);

      //act

      //assert

      expect(left.value, isA<String>());
      expect(left.value, 'oops');

      expect(right.value, isA<int>());
      expect(right.value, 99);
    });

    test('isLeft / isRight helpers reflect the variant', () {
      //arrange
      const left = Left<String, int>(value: 'fail');
      const right = Right<String, int>(value: 1);

      //act

      //assert
      expect(left.isLeft, isTrue);
      expect(left.isRight, isFalse);

      expect(right.isLeft, isFalse);
      expect(right.isRight, isTrue);
    });
  });

  group('Either equality & hashCode', () {
    test('two Lefts with same value are equal and share hashCode', () {
      //arrange
      final l1 = Left<String, int>(value: 'err');
      final l2 = Left<String, int>(value: 'err');

      //act

      //assert
      expect(l1, equals(l2));
      expect(l1.hashCode, l2.hashCode);
    });

    test('two Rights with same value are equal and share hashCode', () {
      //arrange
      final r1 = Right<String, int>(value: 7);
      final r2 = Right<String, int>(value: 7);

      //act

      //assert
      expect(r1, equals(r2));
      expect(r1.hashCode, r2.hashCode);
    });

    test('Left of X ≠ Right of X', () {
      //arrange
      final l = Left<String, int>(value: 'same');
      final r = Right<String, String>(value: 'same');

      //act

      //assert
      expect(l, isNot(equals(r)));
    });
  });

  group("Check whether the either is referring to a Value or a Failure", () {
    test('fold applies the correct function for each variant', () {
      //arrange
      final l = Left<String, int>(value: 'oops');
      final r = Right<String, int>(value: 7);

      //act
      final leftResult = l.fold(
        (err) => 'LEFT:$err',
        (val) => 'RIGHT:$val',
      );
      final rightResult = r.fold(
        (err) => 'LEFT:$err',
        (val) => 'RIGHT:$val',
      );

      //assert
      expect(leftResult, equals('LEFT:oops'));
      expect(rightResult, equals('RIGHT:7'));
    });

    test("Returns null if left VALUE is null", () {
      //arrange

      final l = Left<String, int>();

      //act

      final leftResult = l.fold((err) => err, (val) => val);

      //assert

      expect(leftResult, isNull);
    });

    test("Once the Either is Left, the right must not be called", () {
      //arrange

      final l = Left<String, String>(value: "The operation failed!");
      var tTheRightValueIsCalledOrNot = "";

      //act

      final result = l.fold((error) => error, (value) {
        tTheRightValueIsCalledOrNot = "Right value is called! Which is wrong";
      });

      //assert

      expect(result, equals("The operation failed!"));
      expect(tTheRightValueIsCalledOrNot,
          isNot("Right value is called! Which is wrong"));
    });
  });
}
