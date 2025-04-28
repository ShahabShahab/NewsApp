import 'package:equatable/equatable.dart';

sealed class Either<L, R> extends Equatable {
  const Either();

  bool get isLeft => this is Left<L, R>;

  bool get isRight => this is Right<L, R>;

  T fold<T>(T Function(L l) onLeft, T Function(R r) onRight) => switch (this) {
        Left(:final value) => onLeft(value as L),
        Right(:final value) => onRight(value as R),
      };
}

final class Left<L, R> extends Either {
  final L? value;

  const Left({this.value});

  @override
  List<Object?> get props => [value];
}

final class Right<L, R> extends Either {
  final R? value;

  const Right({this.value});

  @override
  List<Object?> get props => [value];
}
