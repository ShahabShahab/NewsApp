import 'package:domain_layer/src/core/failure/domain_failure.dart';

class ServerFailure extends DomainFailure{
    final String? message;

  ServerFailure({this.message});

  @override
  List<Object?> get props => [message];
}