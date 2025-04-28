import 'package:domain_layer/src/core/failure/domain_failure.dart';
import 'package:domain_layer/src/core/failure/server_failure.dart';
import 'package:equatable/equatable.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group("Failure test", () {
    test("ServerFailure is a DomainFailure", () {
      //arrange

      final serverFailure = ServerFailure();

      //act

      //assert

      expect(serverFailure, isA<DomainFailure>());
      expect(serverFailure, isA<Equatable>());
    });

    test("ServerFailure can hold a message String", () {
      //arrange
      final tServerFailureMessage = "Server is unreachable at the moment";
      final serverFailure = ServerFailure(message: tServerFailureMessage);

      //act

      //assert

      expect(serverFailure.message, equals(tServerFailureMessage));
    });

    test("ServerFailure message could be null once we don't pass a value to it",
        () {
      //arrange
      final serverFailure = ServerFailure();

      //act

      //assert

      expect(serverFailure.message, isNull);
    });
  });

  test("Two ServerFailure with the same message are equal", () {
    //arrange

    final tServerMessage = "Server is down";
    final tServerFailure = ServerFailure(message: tServerMessage);
    final tOtherServerFailure = ServerFailure(message: tServerMessage);

    //act

    //assert
    expect(tOtherServerFailure, equals(tServerFailure));
  });
}
