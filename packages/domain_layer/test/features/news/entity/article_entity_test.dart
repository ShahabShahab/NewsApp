import 'package:domain_layer/src/features/entity/article.dart';
import 'package:equatable/equatable.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  EquatableConfig.stringify = true;

  const tArticle = Article(
      title: "A",
      description: "This is the very beginning of our A article",
      url: "https://x.com",
      content: "This is the very content of our Article");

  group("value semantics", () {
    test("our entity must be equatable", () {
      //arrange

      //act

      //assert

      expect(tArticle, isA<Equatable>());
    });

    test("two identical objects are equal", () {
      //arrange

      const other = Article(
          title: "A",
          description: "This is the very beginning of our A article",
          url: "https://x.com",
          content: "This is the very content of our Article");

      //act

      //assert
      expect(other, equals(tArticle));
    });

    test("object differing in one field are not equal", () {
      //arrange

      const different = Article(
          title: "B",
          description: "This is the very beginning of our A article",
          url: "https://x.com",
          content: "This is the very content of our Article");

      //act

      final result = different == tArticle;

      //assert

      expect(result, isFalse);
    });

    test(
        "copyWith returns the exact object when every one of the fields are identical",
        () {
      //arrange

      final sameObject = tArticle.copyWith(
          title: "A",
          description: "This is the very beginning of our A article",
          url: "https://x.com",
          content: "This is the very content of our Article");

      //act

      final result = sameObject == tArticle;

      //assert

      expect(result, isTrue);
    });

    test(
        "copyWith returns a new object one at least one of the fields are not null and not equal",
        () {
      //arrange

      final differentObject = tArticle.copyWith(title: "B");

      //act

      final result = differentObject == tArticle;

      //assert

      expect(result, isFalse);
    });
  });
}
